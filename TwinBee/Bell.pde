class Bell {
  float x, y;
  float xVel, yVel;
  float xAcel, yAcel;
  PImage sprite;
  PImage sprites[];

  int frameCoolDown = 0;
  int frame = 0;
  
  float POWER_UP_RATE = 0.12;

  int BNORMAL = 0;
  int BSPEED = 1;
  int BBULLET = 2;
  int BSHIELD = 3;
  int BCLONE = 4;
  
  int type;

  Bell(Cloud c) {
    x = c.x;
    y = c.y;
    xVel = 0;
    yVel = -2;
    xAcel = 0;
    yAcel = 0.07;

    sprites = BELLSPRITES;
    
    type = int(random(5));
    sprite = sprites[type*3];
  }

  void display() {
    image(sprite, x-16, y-16, 32, 32);
  }

  void update() {
    spin();
    x += xVel*FRAMERATE/frameRate;
    y += yVel*FRAMERATE/frameRate;
    xVel += xAcel*FRAMERATE/frameRate;
    yVel += yAcel*FRAMERATE/frameRate;
  }
  
  boolean collided(Projectile p) {
    return abs(p.x - x) < 22 && abs(p.y - y) < 22;
  }
  
  boolean collided(Player p) {
    return abs(p.x - x) < 30 && abs(p.y - y) < 30;
  }
  
  boolean atBottom() {
    return y-16 > height;
  }
  
  void changeColor() {
    if (type == 0) {
      if (random(1) < POWER_UP_RATE) {
        type = int(random(1, 5));
      }
    } else {
      type = 0;
    }
  }
  
  void spin() {
    frameCoolDown++;
    if (frameCoolDown > 10) {
      frame++;
      if (frame == 3) {
        frame = 0;
      }
      sprite = sprites[frame+type*3];
      frameCoolDown = 0;
    }
  }
}
