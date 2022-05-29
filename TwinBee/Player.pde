class Player {
  static final float xVel = 2;
  static final float yVel = 2;

  float x, y;
  int playerNum;
  PImage sprite;

  Player(float _x, float _y, int _pn) {
    x = _x;
    y = _y;
    playerNum = _pn;

    sprite = loadImage("P" + playerNum + ".png");
  }

  void display() {
    image(sprite, x-16, y-16, 32, 32);
  }

  void move() {
    if (playerNum == 1) {
      if (keys[LEFTMOVEONE]) {
        x-=xVel;
      }
      if (keys[RIGHTMOVEONE]) {
        x+=xVel;
      }
      if (keys[UPMOVEONE]) {
        y-=yVel;
      }
      if (keys[DOWNMOVEONE]) {
        y+=yVel;
      }
    } else {
    
    }
  }
}
