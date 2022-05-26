class Bell{
  PVector pos;
  PVector vel;
  PVector ace;
  PImage sprite;
  
  Bell(PVector _pos, PVector _vel){
    pos = _pos;
    vel = _vel;
    ace = PVector(0, 0);  
    sprite = loadImage();
  }
}
