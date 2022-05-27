class Projectile{
  static final int PLAYER = 0;
  static final int ENEMY = 1;
  
  float x, y;
  float xVel, yVel;
  int source;
  PImage sprite;
  
  Projectile(float _x, float _y, float _xVel, float _yVel, int _source){
    x = _x;
    y = _y;
    xVel = _xVel;
    yVel = _yVel;
    source = _source;
    //sprite = ;
  }
  
  void display(){
    image(sprite, x, y);   
  }
}
