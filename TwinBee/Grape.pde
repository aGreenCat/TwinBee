class Grape extends Enemy {
  boolean changedDir = false;
  boolean shot = false;

  Grape(float _x, float _y) {
    super(_x, _y);
    sprites = new PImage[2];
    sprites[0] = GRAPE0;
    sprites[1] = GRAPE1;

    sprite = sprites[0];

    if (x > width/2) {
      xVel = -1;
    } else {
      xVel = 1;
    }
    yVel = 2;

    f_rate = 7;

    points = 100;
  }

  void changes() {
    if (player1.dead == 0) {
      if (!changedDir && abs(y-player1.y) <= 200) {
        yAcel = -0.10;
        changedDir = true;
        if (!shot) {
          float hyp = sqrt(sq(player1.x - x) + sq(player1.y - y));
          if (random(1) < 0.25) {
            badBullets.add(new Projectile(x, y, 3*(player1.x - x)/hyp, 3*(player1.y - y)/hyp));
          }
          shot = true;
        }
      }
    }

    if (mode == TWO_PLAYER_GAME && player2.dead == 0) {
      if (!changedDir && abs(y-player2.y) <= 200) {
        yAcel = -0.10;
        changedDir = true;
        if (!shot) {
          float hyp = sqrt(sq(player2.x - x) + sq(player2.y - y));
          if (random(1) < 0.25) {
            badBullets.add(new Projectile(x, y, 3*(player2.x - x)/hyp, 3*(player2.y - y)/hyp));
          }
          shot = true;
        }
      }
    }
  }
}
