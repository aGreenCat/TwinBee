import java.util.*;
import processing.sound.*;

//Mode
int mode;
int MENU = 0;
int ONE_PLAYER_GAME = 1;
int TWO_PLAYER_GAME = 2;
boolean BOSS;

PImage banner;

float FRAMERATE = 60.0;

int LEFTMOVEONE = 0;
int RIGHTMOVEONE = 1;
int UPMOVEONE = 2;
int DOWNMOVEONE = 3;

int LEFTMOVETWO = 4;
int RIGHTMOVETWO = 5;
int UPMOVETWO = 6;
int DOWNMOVETWO = 7;

int PLAYER = 23;
int ENEMY = 32;
int nextEnemy = 0;

int MAX_CLOUDS = 3;
int nextCloud = 0;

int cooldown1 = 5;
int cooldown2 = 5;

int scroll;

int score = 0;

boolean shoot1, shoot2;
boolean[] keys;
int numKeys = 8;

Player player1, player2;
Set<Projectile> bullets;
Set<Projectile> badBullets;
Set<Cloud> clouds;
Set<Enemy> enemies;
Set<Bell> bells;


int bossAspawn;
BossA A;

Boss currentBoss;


//for health bar
float hbw;

PImage background[];
float BACK_SCROLL = 0.5;

PImage BELLSPRITES[];
PImage CLOUD0, CLOUD1;
PImage DEATH0, DEATH1, DEATH2, DEATH3;
PImage PLAYERSPRITE1, PLAYERSPRITE2;
PImage DEADPLAYER0, DEADPLAYER1;
PImage BULLETSPRITE;
PImage STRAWBERRYSPRITE0, STRAWBERRYSPRITE1;
PImage TURNIP0, TURNIP1;
PImage GRAPE0, GRAPE1;
PImage BOSSASHEILD;

void loadImages() {
  banner = loadImage("banner.png");

  CLOUD0 = loadImage("cloud0.png");
  CLOUD1 = loadImage("cloud1.png");
  DEATH0 = loadImage("death_0.png");
  DEATH1 = loadImage("death_1.png");
  DEATH2 = loadImage("death_2.png");
  DEATH3 = loadImage("death_3.png");
  PLAYERSPRITE1 = loadImage("P1.png");
  PLAYERSPRITE2 = loadImage("P2.png");
  DEADPLAYER0 = loadImage("deadPlayer0.png");
  DEADPLAYER1 = loadImage("deadPlayer1.png");
  BULLETSPRITE = loadImage("bullet.png");
  STRAWBERRYSPRITE0 = loadImage("enemy_strawberry_0.png");
  STRAWBERRYSPRITE1 = loadImage("enemy_strawberry_1.png");
  BOSSASHEILD = loadImage("bossA_sheilds.png");
  TURNIP0 = loadImage("enemy_turnip_0.png");
  TURNIP1 = loadImage("enemy_turnip_1.png");
  GRAPE0 = loadImage("enemy_grape_0.png");
  GRAPE1 = loadImage("enemy_grape_1.png");

  //bells
  color colors[];

  colors = new color[8];
  colors[0] = #23B4F5; //blue
  colors[1] = #2F91BC; //dark blue
  colors[2] = #FFFFFF; //white
  colors[3] = #CCCCCC; //gray
  colors[4] = #47F248; //green
  colors[5] = #409B41; //dark green
  colors[6] = #E83521; //red
  colors[7] = #791E14; //dark red

  BELLSPRITES = new PImage[15];
  BELLSPRITES[0] = loadImage("bell.png");
  BELLSPRITES[1] = loadImage("bell_left.png");
  BELLSPRITES[2] = loadImage("bell_right.png");

  for (int i = 3; i < 15; i+=3) {
    BELLSPRITES[i] = loadImage("bell.png");
    BELLSPRITES[i+1] = loadImage("bell_left.png");
    BELLSPRITES[i+2] = loadImage("bell_right.png");

    BELLSPRITES[i].loadPixels();
    BELLSPRITES[i+1].loadPixels();
    BELLSPRITES[i+2].loadPixels();

    for (int j = 0; j < 48*48; j++) {
      for (int k = 0; k < 3; k ++) {
        if (BELLSPRITES[i+k].pixels[j] == #fed18e) {
          BELLSPRITES[i+k].pixels[j] = colors[2*(i/3-1)];
        }

        if (BELLSPRITES[i+k].pixels[j] == #1fa5fe) {
          BELLSPRITES[i+k].pixels[j] = colors[2*(i/3-1)+1];
        }
      }
    }

    BELLSPRITES[i].updatePixels();
    BELLSPRITES[i+1].updatePixels();
    BELLSPRITES[i+2].updatePixels();
  }
}

void setup() {
  size(512, 448);
  frameRate(90);

  loadImages();

  keys = new boolean[numKeys];


  resetGame();

  background = new PImage[3];
  background[0] = loadImage("back0.png");
  background[1] = loadImage("back1.png");
  background[2] = loadImage("back2.png");
}

void resetGame() {
  mode = MENU;

  bossAspawn = scroll + 90*2;
  BOSS = false;

  bullets = new HashSet<Projectile>();
  badBullets = new HashSet<Projectile>();
  clouds = new HashSet<Cloud>();
  enemies = new HashSet<Enemy>();
  bells = new HashSet<Bell>();
}


void draw() {
  background(0);

  if (!BOSS) scroll++; 
  image(background[0], 0, -992 + (scroll*BACK_SCROLL + 960) % 1440);
  image(background[1], 0, -992 + (scroll*BACK_SCROLL + 480) % 1440);
  image(background[2], 0, -992 + scroll*BACK_SCROLL % 1440);

  handleClouds();
  if (mode != MENU) {

    if (BOSS) {
      fill(#55000000);
      rect(0, 0, width, height);
    }

    handleBullets();
    handleBadBullets();

    handleEnemies();
    handleBells();


    player1.update();
    player1.display();
    if (mode == TWO_PLAYER_GAME) {
      player2.update();
      player2. display();
    }


    if (player1.dead == 0) {
      cooldown1++;
      if (cooldown1 > frameRate/6.0 && shoot1) {
        if (player1.shootMode == 1){
          bullets.add(new Projectile(player1.x, player1.y, 0, -10));
        }
        if (player1.shootMode == 2){
          bullets.add(new Projectile(player1.x-7.5, player1.y, 0, -10));
          bullets.add(new Projectile(player1.x+7.5, player1.y, 0, -10));
        }
        if (player1.shootMode == 3){
          bullets.add(new Projectile(player1.x, player1.y, 0, -10));
          bullets.add(new Projectile(player1.x-15, player1.y, 0, -10));
          bullets.add(new Projectile(player1.x+15, player1.y, 0, -10));
        }
        
        if(player1.cone){
          bullets.add(new Projectile(player1.x, player1.y, cos(radians(80))*-10, sin(radians(80))*-10));
          bullets.add(new Projectile(player1.x, player1.y, cos(radians(100))*-10, sin(radians(100))*-10));  
        }
        
        cooldown1 = 0;
      }
    }
    if (mode == TWO_PLAYER_GAME && player2.dead == 0) {
      cooldown2++;
      if (cooldown2 > frameRate/6.0 && shoot2) {
        if (player2.shootMode == 1) {
          bullets.add(new Projectile(player2.x, player2.y, 0, -10));
        }
        if (player2.shootMode == 2) {
          bullets.add(new Projectile(player2.x-7.5, player2.y, 0, -10));
          bullets.add(new Projectile(player2.x+7.5, player2.y, 0, -10));
        }
        if (player2.shootMode == 3) {
          bullets.add(new Projectile(player2.x, player2.y, 0, -10));
          bullets.add(new Projectile(player2.x-15, player2.y, 0, -10));
          bullets.add(new Projectile(player2.x+15, player2.y, 0, -10));
        }
        
        if(player2.cone){
          bullets.add(new Projectile(player2.x, player2.y, cos(radians(80))*-10, sin(radians(80))*-10));
          bullets.add(new Projectile(player2.x, player2.y, cos(radians(100))*-10, sin(radians(100))*-10));  
        }
        
        cooldown2 = 0;
      }
    }


    if (player1.dead == 2 && (mode == ONE_PLAYER_GAME || player2.dead == 2)) {
      resetGame();
    }

    fill(255);
    textSize(20);
    textAlign(LEFT, BASELINE);
    if(!gameOver(mode) && !BOSS){
      score++;
    }
    text(score, 35, 50); 


    if (scroll > bossAspawn) {
      BOSS = true;
      A = new BossA();
      enemies.add(A);
      currentBoss = A;

      for (int i = 0; i < 8; i++) {
        enemies.add(new BossASheilds(45 * i));
      }

      bossAspawn += 99999999;
    }

    if (BOSS) {
      hbw += 0.1*(width*currentBoss.health*1.0/currentBoss.maxHealth - hbw);
      float g = currentBoss.health * 1.0/currentBoss.maxHealth;
      fill(color(255-g*170, 85+g*170, 100));
      rect(0, 0, hbw, 6);
    }
  } else {
    //needed so that the menu time doesn't factor into when the boss spawns.
    bossAspawn ++;


    textAlign(CENTER, CENTER);
    textSize(17);
    noStroke();


    fill(#e0f070ca);
    if (abs(mouseX - width/2) < 75 && abs(mouseY - 275) < 30) {
      fill(#f070ca);
      if (mousePressed) mode = ONE_PLAYER_GAME;
      player1 = new Player(width/2, 400, 1);
    }
    rect(width/2-75, 250, 150, 60, 5);

    fill(#e0f070ca);
    if (abs(mouseX - width/2) < 75 && abs(mouseY - 350) < 30) {
      fill(#f070ca);
      if (mousePressed) mode = TWO_PLAYER_GAME;
      player1 = new Player(width/3.0, 400, 1);
      player2 = new Player(width*2.0/3, 400, 2);
    }
    rect(width/2-75, 325, 150, 60, 5);

    fill(255);
    text("One Player", width/2, 276);
    text("Two Players", width/2, 351);

    image(banner, width/2-160, 75, 330, 90);
  }
}

boolean gameOver(int m){
  if (m == ONE_PLAYER_GAME && player1.dead != 0){
    return true;
  }
  if (m == TWO_PLAYER_GAME && player1.dead != 0 && player2.dead != 0){
    return true;
  }
  return false;
}

void handleBullets() {
  Iterator<Projectile> iter = bullets.iterator();
  while (iter.hasNext()) {
    Projectile bullet = iter.next();

    bullet.update();

    if (bullet.touchingEdges()) {
      iter.remove();
      continue;
    }

    if (!BOSS) {
      Iterator<Cloud> itera = clouds.iterator();
      while (itera.hasNext()) {
        Cloud cloud = itera.next();

        if (cloud.bell && cloud.collided(bullet)) {
          cloud.bell = false;
          bells.add(new Bell(cloud));

          iter.remove();
        }
      }
    }

    bullet.display();
  }
}

void handleClouds() {
  if (!BOSS) {
    if (frameCount > nextCloud) {
      clouds.add(new Cloud(random(64, width-64), -32));
      nextCloud = (int) random(frameCount + frameRate/2, frameCount + frameRate*5.0);
    }
  }

  Iterator<Cloud> iter = clouds.iterator();
  while (iter.hasNext()) {
    Cloud cloud = iter.next();
    cloud.update();

    if (cloud.atBottom()) {
      iter.remove();
    }

    cloud.display();
  }
}

void handleEnemies() {
  if (scroll > nextEnemy) {
    if (random(1) < 0.33) {
      spawnStrawberries();
    } 
    else if (random(1) < 0.33){
      spawnTurnips();
    }
    else {
      spawnGrapes();
    }
    nextEnemy = (int) random(scroll + frameRate*2, scroll + frameRate*3);
  }

  Iterator<Enemy> iter = enemies.iterator();
  while (iter.hasNext()) {
    Enemy enemy = iter.next();

    if (enemy.dead == 2) {
      if (enemy.equals(currentBoss)) {
        BOSS = false;
        nextEnemy = (int) random(scroll + frameRate*0.5, scroll + frameRate*3);
      }
      score += enemy.points;
      iter.remove();
      continue;
    }

    if (enemy.dead == 0) {
      enemy.move();

      if (enemy.atBottom()) {
        iter.remove();
        continue;
      }

      Iterator<Projectile> itera = bullets.iterator();
      while (itera.hasNext()) {
        Projectile bullet = itera.next();

        if (enemy.collided(bullet)) {
          itera.remove();
          {
            enemy.health--;

            if (enemy.health == 0) {
              enemy.setDead();
            }
          }
        }
      }
      if (player1.dead == 0 && enemy.collided(player1)) {
        if (player1.dead == 0) {
          player1.setDead();
        }
      }
      if (mode == TWO_PLAYER_GAME && player2.dead == 0 && enemy.collided(player2)) {
        if (player2.dead == 0) {
          player2.setDead();
        }
      }
    }

    enemy.update();
    enemy.display();
  }
}


void handleBadBullets() {
  Iterator<Projectile> iter = badBullets.iterator();
  while (iter.hasNext()) {
    Projectile bullet = iter.next();

    bullet.update();

    if (bullet.touchingEdges()) {
      iter.remove();
      continue;
    }

    if (player1.dead == 0 && player1.collided(bullet)) {
      iter.remove();
      player1.setDead();
    }
    if (mode == TWO_PLAYER_GAME && player2.dead == 0 && player2.collided(bullet)) {
      iter.remove();
      player2.setDead();
    }

    bullet.display();
  }
}

void handleBells() {
  Iterator<Bell> iter = bells.iterator();
  while (iter.hasNext()) {
    Bell bell = iter.next();

    bell.update();

    if (player1.dead == 0 && bell.collided(player1)) {
      player1.powerUp(bell.type);

      iter.remove();
      continue;
    }
    if (mode == TWO_PLAYER_GAME && player2.dead == 0 && bell.collided(player2)) {
      player2.powerUp(bell.type);

      iter.remove();
      continue;
    }

    Iterator<Projectile> itera = bullets.iterator();
    while (itera.hasNext()) {
      Projectile bullet = itera.next();

      if (bell.collided(bullet)) {
        bell.yVel = -3;
        bell.xVel = (bell.x - bullet.x) / 27;
        bell.changeColor();
        itera.remove();
        break;
      }
    }

    if (bell.atBottom()) {
      iter.remove();
    }

    bell.display();
  }
}

void spawnStrawberries() {
  float xSpawn;
  if (mode == ONE_PLAYER_GAME || player2.dead != 0 || random(1) < 0.5) {
    if (mode == TWO_PLAYER_GAME && player1.dead != 0) {
      xSpawn = player2.x;
    } else {
      xSpawn = player1.x;
    }
  } else {
    xSpawn = player2.x;
  }
  

  if (player1.x > width/2) {
    xSpawn -= player1.y + 16;
    xSpawn = max(xSpawn, 16);
    for (int i = 0; i < 5; i++) {
      enemies.add(new Strawberry(xSpawn-i*23, -16-i*23));
    }
  } else {
    xSpawn += player1.y + 16;
    xSpawn = min(xSpawn, 496);
    for (int i = 0; i < 5; i++) {
      enemies.add(new Strawberry(xSpawn+i*23, -16-i*23));
    }
  }
}


void spawnTurnips() {
  float xSpawn;
  if (mode == ONE_PLAYER_GAME || player2.dead != 0 || random(1) < 0.5) {
    if (mode == TWO_PLAYER_GAME && player1.dead != 0) {
      xSpawn = player2.x;
    } else {
      xSpawn = player1.x;
    }
  } else {
    xSpawn = player2.x;
  }

  if (player1.x > width/2) {
    xSpawn -= player1.y + 16;
    xSpawn = max(xSpawn, 16);
    for (int i = 0; i < 3; i++) {
      enemies.add(new Turnip(xSpawn-i*23, -16-i*23));
    }
  } else {
    xSpawn += player1.y + 16;
    xSpawn = min(xSpawn, 496);
    for (int i = 0; i < 3; i++) {
      enemies.add(new Turnip(xSpawn+i*23, -16-i*23));
    }
  }
}

void spawnGrapes(){
  float xSpawn;
  if (mode == ONE_PLAYER_GAME || player2.dead != 0 || random(1) < 0.5) {
    if (mode == TWO_PLAYER_GAME && player1.dead != 0) {
      xSpawn = player2.x;
    } else {
      xSpawn = player1.x;
    }
  } else {
    xSpawn = player2.x;
  }
  

  if (player1.x > width/2) {
    xSpawn -= player1.y + 16;
    xSpawn = max(xSpawn, 16);
    for (int i = 0; i < 5; i++) {
      enemies.add(new Grape(xSpawn-i*23, -16-i*23));
    }
  } else {
    xSpawn += player1.y + 16;
    xSpawn = min(xSpawn, 496);
    for (int i = 0; i < 5; i++) {
      enemies.add(new Grape(xSpawn+i*23, -16-i*23));
    }
  }
}

void keyPressed() {
  if (key=='a') {
    keys[LEFTMOVEONE]=true;
  }
  if (key=='d') {
    keys[RIGHTMOVEONE]=true;
  }
  if (key=='w') {
    keys[UPMOVEONE]=true;
  }
  if (key=='s') {
    keys[DOWNMOVEONE]=true;
  }

  if (key == 'n') {
    shoot1 = true;
  }

  if (keyCode==LEFT) {
    keys[LEFTMOVETWO]=true;
  }
  if (keyCode==RIGHT) {
    keys[RIGHTMOVETWO]=true;
  }
  if (keyCode==UP) {
    keys[UPMOVETWO]=true;
  }
  if (keyCode==DOWN) {
    keys[DOWNMOVETWO]=true;
  }

  if (key == '.') {
    shoot2 = true;
  }
}

void keyReleased() {
  if (key=='a') {
    keys[LEFTMOVEONE]=false;
  }
  if (key=='d') {
    keys[RIGHTMOVEONE]=false;
  }
  if (key=='w') {
    keys[UPMOVEONE]=false;
  }
  if (key=='s') {
    keys[DOWNMOVEONE]=false;
  }
  if (key == 'n') {
    shoot1 = false;
  }

  if (keyCode==LEFT) {
    keys[LEFTMOVETWO]=false;
  }
  if (keyCode==RIGHT) {
    keys[RIGHTMOVETWO]=false;
  }
  if (keyCode==UP) {
    keys[UPMOVETWO]=false;
  }
  if (keyCode==DOWN) {
    keys[DOWNMOVETWO]=false;
  }

  if (key == '.') {
    shoot2 = false;
  }
}
