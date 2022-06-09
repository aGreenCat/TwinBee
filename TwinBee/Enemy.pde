class Enemy {

  float x, y;
  float xVel, yVel;
  float xAcel, yAcel;
  PImage sprite;
  PImage sprites[];
  
  //for bosses only
  int health;
  
  PImage deaths[];
  int dead = 0;

  float f_rate = frameRate/10.0;
  int f = 0;
  int frame = 0;

  Enemy(float _x, float _y) {
    x = _x;
    y = _y;
    xVel = 0;
    yVel = 0;
    xAcel = 0;
    yAcel = 0;
    
    deaths = new PImage[5];
    deaths[0] = DEATH0;
    deaths[1] = DEATH1;
    deaths[2] = DEATH2;
    deaths[3] = DEATH3;
    deaths[4] = createImage(0, 0, 0);
  }

  void display() {
    image(sprite, x-16, y-16, 32, 32);
  }

  void update() {
    handleFrames();
    
    changes();

    xVel += xAcel*FRAMERATE/frameRate;
    yVel += yAcel*FRAMERATE/frameRate;
  }
  
  void changes() {
    //leave blank: define in each subclass
  }

  void move() {
    x += xVel*FRAMERATE/frameRate;
    y += yVel*FRAMERATE/frameRate;
  }

  void setDead() {
    dead = 1;
    f = 10;
  }

  boolean atBottom() {
    return y-16 > height;
  }

  boolean collided(Projectile p) {
    return abs(p.x - x) < 22 && abs(p.y - y) < 22;
  }

  boolean collided(Player p) {
    return sqrt(sq(p.x-x) + sq(p.y-y)) < 16;
  }

  void handleFrames() {
    f++;
    
    if (dead == 0) {
      if (f > f_rate) {
        frame = 1 - frame;
        sprite = sprites[frame];
        f = 0;
      }
    }
    
    if (dead == 1) {
      if (f > 10) {
        frame++;
        sprite = deaths[frame];
        f = 0;
      }
      
      if (frame == deaths.length - 1) {
        dead = 2;
      }
    }
  }
}
