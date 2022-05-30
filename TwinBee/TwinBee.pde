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

int cooldown = 5;

boolean shoot;
boolean[] keys;
int numKeys = 4;

Player player1;
ArrayList<Projectile> bullets;
Cloud cloud9;

void setup() {
  size(512, 448);
  keys = new boolean[numKeys];

  player1 = new Player(width/2, height/2, 1);
  bullets = new ArrayList<Projectile>();
  
  cloud9 = new Cloud(width/2, height/2);
}

void draw() {
  background(0, 0, 255);
  //player1.x = mouseX;
  //player1.y = mouseY;
  player1.move();
  cloud9.update();

  handleBullets();
  player1.display();
  cloud9.display();

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
