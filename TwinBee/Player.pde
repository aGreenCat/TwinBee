class Player{
  float x, y;
  float xVel, yVel;
  PImage sprite;
  
  Player(float _x, float _y, int playerNum){
    x = _x;
    y = _y;
    if (playerNum == 1){
      sprite = ;
    }
    else {
      sprite = ; 
    }
    xVel = 0;
    yVel = 0;
  }
  
  void display(){
    image(sprite, x, y);   
  }
  
}
