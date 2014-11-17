
////////////////////////////////////////////////
//    Vector operation utilities
////////////////////////////////////////////////

final static float  dot ( final float [] a, final float [] b ){  float sum = 0;  for(int i=0; i<a.length; i++) {                     sum+=a[i]*b[i]; } return sum; }
final static float dist2( final float [] a, final float [] b ){  float sum = 0;  for(int i=0; i<a.length; i++) { float dx=a[i]-b[i]; sum+=dx*dx;     } return sum; }

final static void  div( final float [] a, final float f, float [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]/f; }  }
final static void  mul( final float [] a, final float f, float [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]*f; }  }
final static void  add( final float [] a, final float f, float [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]+f; }  }
final static void  sub( final float [] a, final float f, float [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]-f; }  }

final static void  div( final float [] a, final float [] b, float [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]/b[i]; }  }
final static void  mul( final float [] a, final float [] b, float [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]*b[i]; }  }
final static void  add( final float [] a, final float [] b, float [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]+b[i]; }  }
final static void  sub( final float [] a, final float [] b, float [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]-b[i]; }  }
final static void  fma( final float [] a, final float [] b, float f, float [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]+f*b[i]; }  }

final static void copy( final float [] a, final float [] b ){ System.arraycopy( a, 0, b, 0, a.length );    }

final void set      ( float c,                float [] a) { for(int i=0; i<a.length; i++) {  a[i] = c;                     } }
final void setRandom( float amin, float amax, float [] a) { for(int i=0; i<a.length; i++) {  a[i] = random(amin,amax);   } }
final void setRandom( final float [] amins, final float [] amaxs, float [] a) { for(int i=0; i<a.length; i++) {  a[i] = random(amins[i],amaxs[i]);   } }

//  =========== other utils

String vec2string(float [] a){
  String s = "";
  for(int i=0; i<a.length; i++) {     s+=a[i]+" ";   }
  return s;
}
