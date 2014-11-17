
/*
  There we divide screen into smaller squre tiles
  and buffer just atoms which does belong to given tile 
*/

double RaySphere( double sphR, double3 sphPos, double3 x0, double3 dir ){
  dp.sub(x0,sphPos);
  double a   = dir.dot();
  double b   = dp .dot(dir);             
  double c   = dp .dot() - sphR*sphR;  // (o-c).(o-c) - r^2
  double DD  = b*b - a*c;   // FIXME   should there be  4*a*c
  double d=1000000.0f;
  if (DD>0) { d = - b - Math.sqrt(DD); }
  return d;
}

