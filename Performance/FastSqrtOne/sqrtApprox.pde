

final static double fastSqrtOne_taylor(double x){
 return 1 + x*( 0.5d + x*( -0.125d + x* ( 0.0625d + x* -0.0390625d)));
 //return 1 + x*( 0.5d + x*( -0.125d + x* ( 0.0625d + x* -0.0390625d + x*( 0.02734375d +x* -0.0205078125d))));
}

final static double fastSqrtOne_pade(double x){
 //double p = 1 + x*(1.75d + x*(0.875d + x*0.109375d));
 //double q = 1 + x*(1.25d + x*(0.375d + x*0.015625d));
 double p = 1 + x*(1.25d + x*0.3125d);
 double q = 1 + x*(0.75d + x*0.0625d);
 return p/q;
}
