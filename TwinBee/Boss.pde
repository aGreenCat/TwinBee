class Boss extends Enemy {
  boolean ENTERING = true;
  float maxHealth;
 
  Boss() {
    super(width/2, -320);
    yVel = 2;
  }

  void display() {
    image(sprite, x-36, y-29, 72, 58);
  }

  void changes() {
    if (y >= 100) {
      ENTERING = false;
    }
  }
  
}
