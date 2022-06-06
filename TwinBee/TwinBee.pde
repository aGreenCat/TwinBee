/*
PROJECT V0 DEMO
 
 USE WASD to move.
 N to shoot.
 
 Clouds currently do nothings and you do not die.
 */
import java.util.*;

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

int cooldown = 5;

boolean shoot;
boolean[] keys;
int numKeys = 4;

Player player1;
ArrayList<Projectile> bullets;
ArrayList<Cloud> clouds;
ArrayList<Enemy> enemies;
ArrayList<Bell> bells;

PImage background[];
float BACK_SCROLL = 0.5;

PImage BELLSPRITES[];
PImage CLOUD0, CLOUD1;
PImage DEATH0, DEATH1, DEATH2, DEATH3;
PImage PLAYERSPRITE1, PLAYERSPRITE2;
PImage DEADPLAYER0, DEADPLAYER1;
PImage BULLETSPRITE;
PImage STRAWBERRYSPRITE0, STRAWBERRYSPRITE1; 

void loadImages() {
 CLOUD0 = loadImage("cloud0.png"); CLOUD1 = loadImage("cloud1.png");
 DEATH0 = loadImage("death_0.png"); DEATH1 = loadImage("death_1.png"); DEATH2 = loadImage("death_2.png"); DEATH3 = loadImage("death_3.png");
 PLAYERSPRITE1 = loadImage("P1.png"); PLAYERSPRITE2 = loadImage("P2.png");
 DEADPLAYER0 = loadImage("deadPlayer0.png"); DEADPLAYER1 = loadImage("deadPlayer1.png");
 BULLETSPRITE = loadImage("bullet.png");
 STRAWBERRYSPRITE0 = loadImage("enemy_strawberry_0.png"); STRAWBERRYSPRITE1 = loadImage("enemy_strawberry_1.png"); 
  
  //bells
  color colors[];

  colors = new color[8];
  colors[0] = #23B4F5;
  colors[1] = #2F91BC;
  colors[2] = #FFFFFF;
  colors[3] = #CCCCCC;
  colors[4] = #47F248;
  colors[5] = #409B41;
  colors[6] = #E83521;
  colors[7] = #791E14;

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
  
  loadImages();
  keys = new boolean[numKeys];

  player1 = new Player(width/2, 400, 1);
  bullets = new ArrayList<Projectile>();
  clouds = new ArrayList<Cloud>();
  enemies = new ArrayList<Enemy>();
  bells = new ArrayList<Bell>();

  background = new PImage[3];
  background[0] = loadImage("back0.png");
  background[1] = loadImage("back1.png");
  background[2] = loadImage("back2.png");

  

  fill(255);
  textSize(20);
}

void draw() {
  background(0);
  image(background[0], 0, -992 + (frameCount*BACK_SCROLL + 960) % 1440);
  image(background[1], 0, -992 + (frameCount*BACK_SCROLL + 480) % 1440);
  image(background[2], 0, -992 + frameCount*BACK_SCROLL % 1440);

  text(frameCount, 35, 50);
  
  handleBullets();
  handleClouds();
  handleEnemies();
  handleBells();

  player1.update();
  player1.display();

  if (player1.dead == 0) {
    cooldown++;
    if (cooldown > 10 && shoot) {
      bullets.add(new Projectile(player1.x, player1.y, 0, -10, PLAYER));
      cooldown = 0;
    }
  }
}

void handleBullets() {
  for (int i = 0; i < bullets.size(); i++) {
    Projectile bullet = bullets.get(i);

    bullet.update();

    if (bullet.touchingEdges()) {
      bullets.remove(bullet);
      i--;
      continue;
    }

    for (int j = 0; j < clouds.size(); j++) {
      Cloud cloud = clouds.get(j);

      if (cloud.bell && cloud.collided(bullet)) {
        cloud.bell = false;
        bells.add(new Bell(cloud));

        bullets.remove(bullet);
        i--;
      }
    }

    bullet.display();
  }
}

void handleClouds() {
  if (frameCount > nextCloud) {
    clouds.add(new Cloud(random(64, width-64), -32));
    nextCloud = (int) random(frameCount + 40, frameCount + 300);
  }

  for (int i = 0; i < clouds.size(); i++) {
    Cloud cloud = clouds.get(i);
    cloud.update();

    if (cloud.atBottom()) {
      clouds.remove(cloud);
      i--;
    }

    cloud.display();
  }
}

void handleEnemies() {
  if (frameCount > nextEnemy) {
    spawnStrawberries();
    nextEnemy = (int) random(frameCount + 120, frameCount + 600);
  }

  for (int i = 0; i < enemies.size(); i++) {
    Enemy enemy = enemies.get(i);

    if (enemy.dead == 2) {
      enemies.remove(enemy);
      i--;
      continue;
    }

    if (enemy.dead == 0) {
      enemy.move();

      if (enemy.atBottom()) {
        enemies.remove(enemy);
        i--;
        continue;
      }

      for (int j = 0; j < bullets.size(); j++) {
        Projectile bullet = bullets.get(j);

        if (enemy.collided(bullet)) {
          enemy.setDead();

          bullets.remove(bullet);
          j--;
        }
      }

      if (enemy.collided(player1)) {
        player1.setDead();
      }
    }

    enemy.update();
    enemy.display();
  }
}


void handleBells() {
  for (int i = 0; i < bells.size(); i++) {
    Bell bell = bells.get(i);

    bell.update();

    if (bell.collided(player1)) {
      bells.remove(bell);
      i--;
      continue;
    }

    for (int j = 0; j < bullets.size(); j++) {
      Projectile bullet = bullets.get(j);

      if (bell.collided(bullet)) {
        bell.yVel = -3;
        bell.xVel = (bell.x - bullet.x) / 27;
        bullets.remove(bullet);
        j--;
        break;
      }
    }

    if (bell.atBottom()) {
      bells.remove(bell);
      i--;
    }

    bell.display();
  }
}

void spawnStrawberries() {
  float xSpawn = player1.x;

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
    shoot = true;
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
    shoot = false;
  }
}
