class Strawberry extends Enemy{
  
  Strawberry(float _x, float _y){
    super(_x, _y);
    sprites = new PImage[2];
    sprites[0] = loadImage("enemy_strawberry_0.png");
    sprites[1] = loadImage("enemy_strawberry_1.png");
    
    sprite = sprites[0];
    
    if (x > width/2) {
      xVel = -2;
    } else {
      xVel = 2;
    }
    yVel = 2;
  }
}
