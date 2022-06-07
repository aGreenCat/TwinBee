class Boss extends Enemy {
  boolean ENTERING = true;
  float xTheta = 0;

  Boss(float _x, float _y) {
    super(_x, _y);
    //    sprite = ;
    yVel = 0.5;
  }

  void display() {
    image(sprite, x-36, y-29, 72, 58);
  }

  void changes() {
    if (y >= 100) {
      ENTERING = false;
      yVel = 3;
    }
    if (!ENTERING) {
      if (y >= 200) {
        yVel = -abs(yVel);
      }
      if (y <= 50) {
        yVel = abs(yVel);
      }
      x = newX(100, width/2, xTheta);
      xTheta++;
    }
  }

  float newX(int radius, int xCenter, float t) {
    float x;
    x = cos(radians(t));
    x = radius * x + xCenter;
    return x;
  }
}
