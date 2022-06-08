class BossA extends Boss {
  float theta = 0;
  
  BossA() {
    super();
    sprites = new PImage[2];
    sprites[0] = loadImage("Boss0.png");
    sprites[1] = sprites[0];
    
    sprite = sprites[0];
  }
  
  void changes() {
    super.changes();
    
    if (!ENTERING) {
      x = width/2+140*sin(radians(theta));
      y = 100+40*sin(radians(theta*2));
      theta++;
    }
  }
}
