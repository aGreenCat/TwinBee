class Projectile{
  static final int PLAYER = 0;
  static final int ENEMY = 1;
  
  float x, y;
  float xVel, yVel;
  int source;
  PImage sprite;
  
  Projectile(float _x, float _y, int _xVel, int _yVel, int _source){
    this(_x, _y, float(_xVel), float(_yVel), _source);
  }
  
  Projectile(float _x, float _y, float _xVel, float _yVel, int _source){
    x = _x;
    y = _y;
    xVel = _xVel;
    yVel = _yVel;
    source = _source;
    sprite = BULLETSPRITE;
  }
  
  void display(){
    image(sprite, x-16, y-16, 32, 32);   
  }
  
  void update() {
    x += xVel;
    y += yVel;
  }
  
  boolean touchingEdges() {
    return (x-22 > width)
      || (x-10 < 0)
      || (y-22 > height)
      || (y-10 < 0);
  }
}
