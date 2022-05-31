class Bell {
  float x, y;
  float xVel, yVel;
  float xAcel, yAcel;
  PImage sprite;
  PImage sprites[];

  int frameCoolDown = 0;
  int frame = 0;

  Bell(Cloud c) {
    x = c.x;
    y = c.y;
    xVel = 0;
    yVel = -5;
    xAcel = 0;
    yAcel = 0.08;

    sprites = new PImage[3];
    sprites[0] = loadImage("bell.png");
    sprites[1] = loadImage("bell_left.png");
    sprites[2] = loadImage("bell_right.png");

    sprite = sprites[0];
  }

  void display() {
    image(sprite, x-16, y-16, 32, 32);
  }

  void update() {
    spin();
    x += xVel;
    y += yVel;
    xVel += xAcel;
    yVel += yAcel;
  }
  
  boolean collided(Projectile p) {
    return abs(p.x - x) < 22 && abs(p.y - y) < 22;
  }
  
  boolean atBottom() {
    return y-16 > height;
  }
  
  void spin() {
    frameCoolDown++;
    if (frameCoolDown > 5) {
      frame++;
      if (frame == 3) {
        frame = 0;
      }
      sprite = sprites[frame];
      frameCoolDown = 0;
    }
  }
}
