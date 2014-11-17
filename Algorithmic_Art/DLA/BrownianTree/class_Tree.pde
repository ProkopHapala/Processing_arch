class Particle {
  int x, y;
  Particle() { x = int(random(sz));  y = int(random(sz));   }
 
  /* returns true if either out of bounds or collided with tree */
  boolean move() {
   int dx = int(random(3)) - 1;
   int dy = int(random(3)) - 1;
   x += dx;  y += dy;
   if ((x < 0) || (y < 0) || (y >= sz) || (x >= sz) ) {  return true;  }
   if ( Bs[x][y] > 0 ) {
        Bs[x - dx][y - dy] = 1;
        set( x - dx, y - dy, color(0) );
        return true;
      }
     return false;
   }
}
