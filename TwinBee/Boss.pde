class Boss extends Enemy {
  boolean ENTERING = true;
 
  Boss() {
    super(width/2, -29);
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
