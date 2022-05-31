class Strawberry extends Enemy{
  
  boolean changedDir = false;
  
  Strawberry(float _x, float _y){
    super(_x, _y);
    sprites = new PImage[2];
    sprites[0] = loadImage("enemy_strawberry_0.png");
    sprites[1] = loadImage("enemy_strawberry_1.png");
    
    sprite = sprites[0];
    
    if (x > width/2) {
      xVel = -3;
    } else {
      xVel = 3;
    }
    yVel = 3;
  }
  
  void changes() {
    if (!changedDir && abs(player1.x - x) < 5 && player1.y - y < 128) {
      xVel *= -1;
      changedDir = true;
    }
  }
}
