class Player {
  static final float xVel = 2;
  static final float yVel = 2;

  float x, y;
  int playerNum;
  PImage sprite;
  PImage deaths[];

  int dead = 0;

  int f_rate = 6;
  int f = 0;
  int frame = 0;

  Player(float _x, float _y, int _pn) {
    x = _x;
    y = _y;
    playerNum = _pn;

    if (playerNum == 1)
      sprite = PLAYERSPRITE1;
    else 
      sprite = PLAYERSPRITE2;
    deaths = new PImage[2];
    deaths[0] = DEADPLAYER0;
    deaths[1] = DEADPLAYER1;
  }

  void display() {
    if (dead != 6)
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

  void update() {
    if (dead == 0) {
      move();
    } else if (dead < 6) {
      f++;

      if (f > f_rate) {
        frame = 1 - frame;
        sprite = deaths[frame];

        f = 0;
        dead++;
      }
    }
  }

  void setDead() {
    dead = 1;
  }
}
