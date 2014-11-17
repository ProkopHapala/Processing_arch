
/*

from here:
http://www1.fpl.fs.fed.us/Fmin.java

Here is a copy of the Netlib documentation:

c
c      An approximation x to the point where f attains a minimum on
c  the interval (ax,bx) is determined.
c
c  input..
c
c  ax    left endpoint of initial interval
c  bx    right endpoint of initial interval
c  f     function subprogram which evaluates f(x) for any x
c        in the interval (ax,bx)
c  tol   desired length of the interval of uncertainty of the final
c        result (.ge.0.)
c
c  output..
c
c  fmin  abcissa approximating the point where  f  attains a
c        minimum
c
c     The method used is a combination of golden section search and
c  successive parabolic interpolation.  Convergence is never much slower
c  than that for a Fibonacci search.  If f has a continuous second
c  derivative which is positive at the minimum (which is not at ax or
c  bx), then convergence is superlinear, and usually of the order of
c  about 1.324.
c     The function f is never evaluated at two points closer together
c  than eps*abs(fmin)+(tol/3), where eps is approximately the square
c  root of the relative machine precision.  If f is a unimodal
c  function and the computed values of f are always unimodal when
c  separated by at least eps*abs(x)+(tol/3), then fmin approximates
c  the abcissa of the global minimum of f on the interval (ax,bx) with
c  an error less than 3*eps*abs(fmin)+tol.  If f is not unimodal,
c  then fmin may approximate a local, but perhaps non-global, minimum to
c  the same accuracy.

*/

double lineSearch_brent_prokop (double a, double b, double tol) {
    double  x,  u, v, w; 
    double fx, fu,fv,fw;
    double p,q,r;
    double tol1,t2;

    double c = 0.5*( 3.0 - Math.sqrt(5.0) );
    double d = 0.0;

    double eps = 1.2e-16;
    tol1 = eps + 1.0;
    eps = Math.sqrt(eps);

    v = a + c*(b-a);
    w = v;
    x = v;
    double e = 0.0;
    fx = testfunc(x); ellipse( sX(x),  sY(fx), 2,2 );
    fv = fx;
    fw = fx;
    final double tol3 = tol/3.0;

    double xm = 0.5*(a + b);
    tol1 = eps*Math.abs(x) + tol3;
    t2 = 2.0*tol1;

// main loop

    while (Math.abs(x-xm) > (t2 - .5*(b-a))) {
       p = q = r = 0.0;
       if (Math.abs(e) > tol1) {   // fit the parabola
          r = (x-w)*(fx-fv);
          q = (x-v)*(fx-fw);
          p = (x-v)*q - (x-w)*r;
          q = 2.0*(q-r);
          if (q > 0.0)  p = -p;
          else          q = -q;
          r = e;
          e = d;         
       }

       if ((Math.abs(p) < Math.abs(.5*q*r)) && (p > q*(a-x)) && (p < q*(b-x))) {  // a parabolic interpolation step
          d = p/q;
          u = x+d;
          if (((u-a) < t2) || ((b-u) < t2)) {   // f must not be evaluated too close to a or b
             d = tol1;             // offset from left
             if (x >= xm) d = -d;  // offset from right
          }
          print( " parabolic "  );
       } else {   // a golden-section step
          if (x < xm) e = b-x;
          else        e = a-x;
          d = c*e;
          print( " golden    "  );
       }

       if (Math.abs(d) >= tol1) {    // f must not be evaluated too close to x
          u = x+d;
       } else {
          if (d > 0.0) u = x + tol1;
          else         u = x - tol1;
       }

       fu = testfunc(u);         ellipse( sX(u),  sY(fu), 2,2 );

       if (fx <= fu) {
          if (u < x) a = u;
          else       b = u;
       }
       if (fu <= fx) {
          if( Math.abs(u-x)<tol) break;
          if (u < x)  b = x;
          else        a = x;
          v = w; fv = fw;  
          w = x; fw = fx;
          x = u; fx = fu;
       } else {
          if ( (fu <= fw) || (w == x) ) {
             v = w; fv = fw;
             w = u; fw = fu;
          } else { 
            if (!((fu > fv) && (v != x) && (v != w))) {
               v = u;  fv = fu;
            }
          }  
       }   
       xm   = .5*(a + b);
       tol1 = eps*Math.abs(x) + tol3;
       t2   = 2.0*tol1;
       
       println( " t2 "+t2 +"  tol1   "+ tol1 + "    x   "+ x );
       //println( " |x-xm| "+Math.abs(x-xm) +"    t2-(a-b)/2   "+ (t2 - .5*(b-a)) + "    t2   "+ t2+" u " + u+" x "+x );
       //println( "    a "+a +"    x "+ x + "    b "+ b );
    }
    return x;
 }   

