class Strawberry extends Enemy{
  
  boolean changedDir = false;
  
  Strawberry(float _x, float _y){
    super(_x, _y);
    sprites = new PImage[2];
    sprites[0] = STRAWBERRYSPRITE0;
    sprites[1] = STRAWBERRYSPRITE1;
    
    sprite = sprites[0];
    
    if (x > width/2) {
      xVel = -3.5;
    } else {
      xVel = 3.5;
    }
    yVel = 3.5;
  }
  
  void changes() {
    if (!changedDir && abs(player1.x - x) < 5 && player1.y - y < 128) {
      xVel *= -1;
      changedDir = true;
    }
  }
}