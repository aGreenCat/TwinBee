class BossASheilds extends Enemy {
  int theta;
  
  BossASheilds(int t) {
    super(0, 0);
    
    health = 10;
    theta = t;
    sprite = BOSSASHEILD;
  }
  
  void changes() {
    theta++;
    
    x = currentBoss.x + 90*cos(radians(theta));
    y = currentBoss.y + 90*sin(radians(theta));
    
    if (currentBoss.dead != 0) {
      setDead();
    }
  }
  
  boolean collided(Player p) {
    return sq(p.x - x) + sq(p.y - y) < sq(32);
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
      if (frame == 5) {
        dead = 2;
      }
    }
  }
}
