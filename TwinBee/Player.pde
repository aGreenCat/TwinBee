class Player{
  float x, y;
  float xVel, yVel;
  PImage sprite;
  
  Player(float _x, float _y, int playerNum){
    x = _x;
    y = _y;
    
    sprite = loadImage("P" + playerNum + ".png");
    xVel = 1;
    yVel = 1;
  }
  
  void display(){
    image(sprite, x-16, y-16, 32, 32);   
  }
  
  void move(){
    if (keys[LEFTMOVE]) {
      x-=xVel;
    }
    if (keys[RIGHTMOVE]) {
      x+=xVel;
    }
    if (keys[UPMOVE]) {
      y-=yVel;
    }
    if (keys[DOWNMOVE]) {
      y+=yVel;
    }
  }
  
}
