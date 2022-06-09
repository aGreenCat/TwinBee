class BossA extends Boss {
  float theta = 0;
  

  BossA() {
    super();
    sprite = loadImage("Boss0.png");
    
    maxHealth = 30;
    health = maxHealth;
  }

  void changes() {
    super.changes();

    if (!ENTERING && dead == 0) {
      x = width/2+140*sin(radians(theta));
      y = 100+40*sin(radians(theta*2));
      theta++;
    }
  }

  boolean collided(Projectile p) {
    return abs(p.x - x) < 42 && abs(p.y - y) < 35;
  }

  void handleFrames() {
    f++;

    if (dead == 1) {
      if (f > 10) {
        frame++;
        if (frame < 5) {
          sprite = deaths[frame];
        }
        f = 0;
      }
      if (frame == 24) {
        dead = 2;
      }
    }
  }
}
