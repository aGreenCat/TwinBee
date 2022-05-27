int LEFTMOVE = 0;
int RIGHTMOVE = 1;
int UPMOVE = 2;
int DOWNMOVE = 3;

boolean[] keys;
int numKeys = 4;

Player player1;


void setup(){
  size(512, 448);
  keys = new boolean[numKeys];
  player1 = new Player(width/2, height/2, 1);
}

void draw(){
  background(0, 0, 255);
  //player1.x = mouseX;
  //player1.y = mouseY;
  
  player1.display();
  
  player1.move();
}


void keyPressed() {
  if (key=='a') {
    keys[LEFTMOVE]=true;
  }
  if (key=='d') {
    keys[RIGHTMOVE]=true;
  }
  if (key=='w') {
    keys[UPMOVE]=true;
  }
  if (key=='s') {
    keys[DOWNMOVE]=true;
  }
}

void keyReleased() {
  if (key=='a') {
    keys[LEFTMOVE]=false;
  }
  if (key=='d') {
    keys[RIGHTMOVE]=false;
  }
  if (key=='w') {
    keys[UPMOVE]=false;
  }
  if (key=='s') {
    keys[DOWNMOVE]=false;
  }
}
