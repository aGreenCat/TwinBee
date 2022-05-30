class Cloud {
  static final float bellRate = 0.5;

  float x, y;
  float yVel;
  PImage sprite;
  boolean bell;
  int bounceCoolDown = 5;
  int bounceState = 1;

  Cloud(int _x, int _y) {
    x =_x;
    y= _y;
    yVel = .75;
    if (random(1) < bellRate) {
      bell = true;
    }
    sprite = loadImage("cloud1.png");
  }

  void display() {
    image(sprite, x-32, y-16, 64, 32);
  }

  void update() {
    y+=yVel;
    bounce();
  }

  void bounce() {
    bounceCoolDown++;
    if (bounceCoolDown > 50) {
      bounceState = abs(bounceState - 1);
      sprite = loadImage("cloud" + bounceState + ".png");
      bounceCoolDown = 0;
    }
  }
}
