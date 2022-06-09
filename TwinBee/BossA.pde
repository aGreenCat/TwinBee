class BossA extends Boss {
  float theta = 0;
  int b, nextB;
  

  BossA() {
    super();
    sprite = loadImage("Boss0.png");
    
    maxHealth = 30;
    health = maxHealth;
    b = nextB = 0;
  }

  void changes() {
    super.changes();
    
    b++;

    if (!ENTERING && dead == 0) {
      x = width/2+140*sin(radians(theta));
      y = 100+40*sin(radians(theta*2));
      theta++;
    }
    
    if (b > nextB) {
      float hyp = sqrt(sq(player1.x - x) + sq(player1.y - y));
      
      badBullets.add(new Projectile(x, y, 3*(player1.x - x)/hyp, 3*(player1.y - y)/hyp));
      nextB += int(random(10, 90));
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
