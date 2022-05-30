class Enemy{
  
  float x, y;
  float xVel, yVel;
  PImage sprite;
  
  Enemy(float _x, float _y){
    x = _x;
    y = _y;
    xVel = 0;
    yVel = 0;
  }
  
  void display(){
    image(sprite, x, y);   
  }
  
  
  void update(){
    
  }
   
  void move(){
    x += xVel;
    y += yVel;
  }
  
}
