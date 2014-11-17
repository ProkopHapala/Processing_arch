
final int randFunc( int r ){
  r = 1664525*r ^ 1013904223;
  r = 1664525*r ^ 1013904223;
  return r; 
}

final float randomParabola( float x, float y, int seed ){
  final float isc  = 0.25/float(0x8FFFFFFF);
  float x0 = ( randFunc( seed           ) - 0x8FFFFFFF ) *isc;
  float y0 = ( randFunc( seed ^ 136578  ) - 0x8FFFFFFF ) *isc;
  //float y0 = 0;
  float dx = x - x0;
  float dy = y - y0;
  //println( isc+" | "+x0+" "+y0+" | "+x+" "+y+" | "+dx+" "+dy);
  return dx*dx + dy*dy;
  //return sqrt( dx*dx + dy*dy );
  //return 1.0-0.1/( 0.1 + dx*dx + dy*dy );
};

final float VoronoiNoise( float x, float y ){
  int iy = int( y +10000.0 ) - 10000; // fast floor
  int ix = int( x +10000.0 ) - 10000;
  float dx = x - ix; float dy = y - iy;
  //println( "--- "+dx+" "+dy);
  float f,fmin = 100000; 
  f = randomParabola( dx  , dy  , ( ix   <<8) +  iy    ); if(f<fmin) fmin=f;
  f = randomParabola( dx  , dy-1, ( ix   <<8) + (iy+1) ); if(f<fmin) fmin=f;
  f = randomParabola( dx-1, dy  , ((ix+1)<<8) +  iy    ); if(f<fmin) fmin=f;
  f = randomParabola( dx-1, dy-1, ((ix+1)<<8) + (iy+1) ); if(f<fmin) fmin=f;
  return fmin;
}



