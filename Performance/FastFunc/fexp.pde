// Fast exp func from page
// http://firstclassthoughts.co.uk/misc/optimized_power_method_for_java_and_c_and_cpp.html
//
static double fpow( double a, double b) {
    final int x = (int) (Double.doubleToLongBits(a) >> 32);
    final int y = (int) (b * (x - 1072632447) + 1072632447);
    return Double.longBitsToDouble(((long) y) << 32);
}

static double fexp(final double val) {
    final long tmp = (long) (1512775 * val + 1072632447);
    return Double.longBitsToDouble(tmp << 32);
}

// exp(x) = exp(x) - exp(x-0.35)*exp(0.35) 
//
/*
static double ffexp(final double val) {
    final long tmp1 = (long) (1512775 * val + 1072632447);
    double A = Double.longBitsToDouble(tmp1 << 32);
    final long tmp2 = (long) (1512775 * (val-0.35) + 1072632447);
    double B = Double.longBitsToDouble(tmp2 << 32);
    return (A + B*1.41906755)/3;
}
*/
