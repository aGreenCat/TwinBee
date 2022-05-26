class Enemy{
  
  float x, y;
  float xVel, yVel;
  PImage sprite;
  
  Player(float _x, float _y, PImage _sprite){
    x = _x;
    y = _y;
    xVel = 0;
    yVel = 0;
    sprite = _sprite;
  }
  
  void display(){
    image(sprite, x, y);   
  }
  
}
