

// ==========================================================
//     Taylor exapnsion 
// ===========================================================

double fast_asin2(double x) {    return x*( 1.0 +  0.5707963267948966*x*x);  }

double fast_asin4(double x) {
  double x2 = x*x;
  return x*( 1.0 +  0.5707963267948966*x2*x2);
}

double fast_asin24(double x) {
  final double a = 0.3;
  final double b = 0.5707963267948966-a;
  double x2 = x*x;
  return x*( 1.0 +  a*x2 +  b*x2*x2);
}

double fast_asin28(double x) {
  final double a = 0.1825;
  final double b = 0.5707963267948966-a;
  double x2 = x*x;
  double x4 = x2*x2;
  return x*( 1.0 + a*x2 + b*x4*x4);
}

double fast_asin216(double x) {
  //final double a = param1;
  final double a = 0.1825;
  final double b = 0.5707963267948966-a;
  double x2 = x*x;
  double x4 = x2*x2;
  double x8 = x4*x4;
  return x*( 1.0 + a*x2 + b*x8*x8);
}

double fast_asin2816(double x) {
  double a = param1;
  double b = param2;
  //final double a = 0.1825;
  final double c = 0.5707963267948966-a;
  double x2 = x*x;
  double x4 = x2*x2;
  double x8 = x4*x4;
  return x*( 1.0 + a*x2 + b*x8 + c*x8*x8);
}

double fast_asin48(double x) {
  final double a = 0.3;
  final double b = 0.5707963267948966-a;
  double x2 = x*x;
  double x4 = x2*x2;
  return x*( 1.0 + a*x4 + b*x4*x4);
}

double fast_asin248(double x) {
  double a = param1;
  double b = param2;
  /*
  final double a = 0.285;
  final double b = -0.40;
  */
  final double c = 0.5707963267948966-(a+b);
  double x2 = x*x;
  double x4 = x2*x2;
  return x*( 1.0 + a*x2 + b*x4 + c*x4*x4);
}



// ==========================================================
//     SQRT approximations fits asin well for 
// ===========================================================
/*
  
  I.  In central part good aproximation is        x * ( 1 + a*x^2) is  
  II. In edge part good approciomation is         c*(b + sqrt(1-x) )

 We fit coefficintas a,b,c such that funstions are equal to true asin(x) in points x = { 0.0, x0, 1.0 }
 this can be achieved by this code
 
 double x0 = Math.sqrt(0.5d);
 double A = Math.asin(1.0d);
 double B = Math.asin( x0 );
 double a = (B - x0) / (x0*x0*x0);
 double b = A*Math.sqrt(1.0d-x0)/(A-B);
 double c = A/b;
 println(x1+" "+c+" "+b+" "+ a);

*/

double fast_asin_sqrtif(double x) {
  final double x0 = 0.5d;
  final double a  = 0.1887902047863914d;
  final double b  = 1.0606601717798212d;
  final double c  = 1.4809609793861223d;
  if      (x >  x0 ) { return c*( b - Math.sqrt(1.0d-x)  ); } 
  else if (x > -x0 ) { return x*( 1.0d + a*x*x           ); } 
  else               { return c*( Math.sqrt(1.0d+x) - b  ); }
}

double fast_asin_sqrtif2(double x) {
  final double x0 = 0.7071067811865476d;
  final double a  = 0.22144146907918316d;
  final double b  = 1.082392200292394d;
  final double c  = 1.4512265760697154d;
  if      (x >  x0 ) { return c*( b - Math.sqrt(1.0d-x)  ); } 
  else if (x > -x0 ) { return x*( 1.0d + a*x*x           ); } 
  else               { return c*( Math.sqrt(1.0d+x) - b  ); }
}

/*
// experimental int version - is not faster

double fast_asin_sqrtif2_(double x) {
  final double x0 = 0.7071067811865476d;
  final double a  = 0.22144146907918316d;
  final double b  = 1.082392200292394d;
  final double c  = 1.4512265760697154d;
  int i = (int)(x/x0);
  if      (i >  0 ) { return c*( b - Math.sqrt(1.0d-x)  ); } 
  else if (i > -1 ) { return x*( 1.0d + a*x*x           ); } 
  else              { return c*( Math.sqrt(1.0d+x) - b  ); }
}
*/

// ==========================================================
//   using TABLE 
// ===========================================================
/*
 Table was evaluated using this code
 
 for (int i=-32;i<33;i++){
 double x = i/32.0d;
 //println( x+" "+ Math.asin( x ) );
 print( Math.asin( x )+", " ); 
 }

*/

final double [] asin_table = {
  -1.5707963267948966, -1.3201406644587659, -1.2153751251046732, -1.1343272980599775, 
  -1.0654358165107394, -1.0042319961738184, -0.948427838239876, -0.8966658201275814, 
  -0.848062078981481, -0.8020027778036185, -0.758040765426236, -0.7158380602251112, 
  -0.6751315329370317, -0.6357112854013022, -0.5974064166453502, -0.560075306226582, 
  -0.5235987755982989, -0.48787514754029293, -0.4528165947449256, -0.4183463864434681, 
  -0.3843967744956391, -0.3509073435910811, -0.31782370392788073, -0.2850964402527462, 
  -0.25268025514207865, -0.22053326092083333, -0.1886163861754041, -0.1568928710204612, 
  -0.1253278311680654, -0.09388787510751648, -0.06254076179649139, -0.031255088499495154, 
   0.0, 0.031255088499495154, 0.06254076179649139, 0.09388787510751648, 0.1253278311680654, 
   0.1568928710204612, 0.1886163861754041, 0.22053326092083333, 0.25268025514207865, 
   0.2850964402527462, 0.31782370392788073, 0.3509073435910811, 0.3843967744956391, 
   0.4183463864434681, 0.4528165947449256, 0.48787514754029293, 0.5235987755982989, 
   0.560075306226582, 0.5974064166453502, 0.6357112854013022, 0.6751315329370317, 
   0.7158380602251112, 0.758040765426236, 0.8020027778036185, 0.848062078981481, 
   0.8966658201275814, 0.948427838239876, 1.0042319961738184, 1.0654358165107394, 
   1.1343272980599775, 1.2153751251046732, 1.3201406644587659, 1.5707963267948966};

double fast_asin_table(double  x){
  double xx = x*32.0d + 32.0d;
  int ix = (int)xx;
  double dx = xx-ix; 
  double mx = (1.0d-dx);
  double f1 = asin_table[ix]; double f2=asin_table[ix+1];
  return mx*f1+dx*f2;
}





