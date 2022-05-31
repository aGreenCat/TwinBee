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

void setup() {
  size(512, 448);
  keys = new boolean[numKeys];

  player1 = new Player(width/2, 400, 1);
  bullets = new ArrayList<Projectile>();
  clouds = new ArrayList<Cloud>();
  enemies = new ArrayList<Enemy>();
}

void draw() {
  background(0, 0, 255);
  player1.move();

  handleBullets();
  handleClouds();
  handleEnemies();

  player1.display();

  cooldown++;
  if (cooldown > 10 && shoot) {
    bullets.add(new Projectile(player1.x, player1.y, 0, -10, PLAYER));
    cooldown = 0;
  }
}

void handleBullets() {
  for (int i = 0; i < bullets.size(); i++) {
    Projectile bullet = bullets.get(i);

    bullet.update();

    if (bullet.touchingEdges()) {
      bullets.remove(bullet);
      i--;
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
    }

    if (enemy.dead == 0) {
      enemy.move();

      if (enemy.atBottom()) {
        enemies.remove(enemy);
        i--;
      }

      for (int j = 0; j < bullets.size(); j++) {
        Projectile bullet = bullets.get(j);

        if (enemy.collided(bullet)) {
          enemy.setDead();

          bullets.remove(bullet);
          j--;
        }
      }
    }

    enemy.update();
    enemy.display();
  }
}


void spawnStrawberries() {
  if (random(1) < 0.5) {
    for (int i = 0; i < 5; i++) {
      enemies.add(new Strawberry(112-i*32, -16-i*32));
    }
  } else {
    for (int i = 0; i < 5; i++) {
      enemies.add(new Strawberry(400+i*32, -16-i*32));
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
