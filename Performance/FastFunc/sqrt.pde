


static double fsqrt( double a) {
    
  // fast pow() as guess 
    final int x = (int) (Double.doubleToLongBits(a) >> 32);
    final int y = (int) (0.5 * (x - 1072632447) + 1072632447);
    double x1 = Double.longBitsToDouble(((long) y) << 32);
    
    // babylon formula to improve accuracy, 
    // add few more iterations forbetter accuracy
    double x2 = a/x1;
    x1=0.5*(x1+x2);
    x2=a/x1;
    x1=0.5*(x1+x2);
    //x2=a/x1;
    //x1=0.5*(x1+x2);
    //x2=a/x1;
    //x1=0.5*(x1+x2);
    
    return x1;
}


