class Turnip extends Enemy {

  boolean shot = false;

  Turnip(float _x, float _y) {
    super(_x, _y);
    sprites = new PImage[2];
    sprites[0] = TURNIP0;
    sprites[1] = TURNIP1;

    sprite = sprites[0];

    if (x > width/2) {
      xVel = -1;
    } else {
      xVel = 1;
    }
    yVel = 2;

    f_rate = 7;
  }

  void changes() {
    if (player1.dead == 0) {
    if (!shot && abs(player1.x - x) < 100 && player1.y - y < -100) {
      float hyp = sqrt(sq(player1.x - x) + sq(player1.y - y));

      badBullets.add(new Projectile(x, y, 3*(player1.x - x)/hyp, 3*(player1.y - y)/hyp));
      shot = true;
    }
    }

    if (mode == TWO_PLAYER_GAME && player2.dead == 0) {
      if (!shot && abs(player2.x - x) < 100 && player2.y - y < -100) {
        float hyp = sqrt(sq(player2.x - x) + sq(player2.y - y));

        badBullets.add(new Projectile(x, y, 3*(player2.x - x)/hyp, 3*(player2.y - y)/hyp));
        shot = true;
      }
    }
  }
}
