class Strawberry extends Enemy{
  
  int spriteState = 1;
  
  Strawberry(float _x, float _y){
    super(_x, _y);
    sprite = loadImage("enemy_strawberry_1.png");
  }
  
  
}
