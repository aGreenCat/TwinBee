class Strawberry extends Enemy {

  boolean changedDir = false;

  Strawberry(float _x, float _y) {
    super(_x, _y);
    sprites = new PImage[2];
    sprites[0] = STRAWBERRYSPRITE0;
    sprites[1] = STRAWBERRYSPRITE1;

    sprite = sprites[0];

    if (x > width/2) {
      xVel = -3;
    } else {
      xVel = 3;
    }
    yVel = 2.75;

    f_rate = 10;
    
    points = 100;
  }

  void changes() {
    if (player1.dead == 0) {
      if (!changedDir && abs(player1.x - x) < 5 && player1.y - y < 128) {
        xVel *= -1;
        changedDir = true;
      }

      float m = (player1.x - x)/(player1.y - y);
      if (!changedDir && abs(xVel/yVel + m) < 0.05) {
        if (player1.y < y) {
          yVel*= -1;
        } else {
          xVel *= -1;
        }
        changedDir = true;
      }
    }

    if (mode == TWO_PLAYER_GAME && player2.dead == 0) {
      if (!changedDir && abs(player2.x - x) < 5 && player2.y - y < 128) {
        xVel *= -1;
        changedDir = true;
      }

      float n = (player2.x - x)/(player2.y - y);
      if (!changedDir && abs(xVel/yVel + n) < 0.05) {
        if (player2.y < y) {
          yVel*= -1;
        } else {
          xVel *= -1;
        }
        changedDir = true;
      }
    }
  }
}
