 
final double phi = (1 + Math.sqrt(5)) / 2;
final double resphi = 2 - phi;
final float  tau = 0.001; 
 
// a and c are the current bounds; the minimum is between them.
// b is a center point
// f(x) is some mathematical function elsewhere defined
// a corresponds to x1; b corresponds to x2; c corresponds to x3
// x corresponds to x4
 
double lineSearch_golden(double a, double b, double c, double Eb, double tau) {
    double x;
    if (c - b > b - a)
      x = b + resphi * (c - b);
    else
      x = b - resphi * (b - a);
    if (Math.abs(c - a) < tau * (Math.abs(b) + Math.abs(x))) 
      return (c + a) / 2; 
    //assert(f(x) != f(b));
    double Ex = testfunc(x);
    ellipse( sX(x),  sY(Ex), 2,2 );
    if ( Ex <  Eb) {
      if (c - b > b - a) return lineSearch_golden(b, x, c, Ex, tau);
      else               return lineSearch_golden(a, x, b, Ex, tau);
    }
    else {
      if (c - b > b - a) return lineSearch_golden(a, b, x, Eb, tau);
      else               return lineSearch_golden(x, b, c, Eb, tau);
    }
  }
