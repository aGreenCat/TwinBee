class Cloud {
  static final float bellRate = 0.5;

  float x, y;
  float yVel;
  PImage sprite;
  PImage sprites[];
  boolean bell;
  int frameCoolDown = 0;
  int frame = 1;

  Cloud(float _x, float _y) {
    x =_x;
    y= _y;
    yVel = random(0.5, 0.75);
    if (random(1) < bellRate) {
      bell = true;
    }
    sprites = new PImage[2];
    sprites[0] = loadImage("cloud1.png");
    sprites[1] = loadImage("cloud0.png");
    
    sprite = sprites[0];
  }

  void display() {
    image(sprite, x-32, y-16, 64, 32);
  }

  void update() {
    y+=yVel;
    
    bounce();
  }
  
  boolean atBottom() {
    return y-16 > height;
  }

  void bounce() {
    frameCoolDown++;
    if (frameCoolDown > 30) {
      frame = 1 - frame;
      sprite = sprites[frame];
      frameCoolDown = 0;
    }
  }
}
