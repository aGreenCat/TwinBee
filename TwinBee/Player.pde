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
  int deadr = 0;

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
    if (dead != 2 && deadr < 5)
      image(sprite, x-16, y-16, 32, 32);
  }

  void move() {
    if (playerNum == 1) {
      if (keys[LEFTMOVEONE]) {
        x-=xVel*FRAMERATE/frameRate;
        if (x < 16) x = 16;
      }
      if (keys[RIGHTMOVEONE]) {
        x+=xVel*FRAMERATE/frameRate;
        if (x > width-16) x = width-16;
      }
      if (keys[UPMOVEONE]) {
        y-=yVel*FRAMERATE/frameRate;
        if (y < 16) y = 16;
      }
      if (keys[DOWNMOVEONE]) {
        y+=yVel*FRAMERATE/frameRate;
        if (y > height-16) y = height-16;
      }
    } else {
    }
  }

  void update() {
    if (dead == 0) {
      move();
    } else if (dead == 1) {
      f++;

      if (f > f_rate) {
        if (deadr < 5) {
          frame = 1 - frame;
          sprite = deaths[frame];

          f = 0;
        }
        deadr++;
      }

      if (deadr > 100) {
        dead = 2;
      }
    }
  }

  void setDead() {
    dead = 1;
    f = 0;
  }

  boolean collided(Projectile p) {
    return abs(p.x - x) < 22 && abs(p.y - y) < 22;
  }
}
