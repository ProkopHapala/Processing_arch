

void testplot( float x, float f, float ref, color c ){
  stroke(c);
  point ( x     ,   f     *yzoom  + y0  );
  point ( x     ,  (f-ref)*yzoom*restZoom + y0   );
  float ref2 = sin(ref);
  float f2   = sin(f); 
  point ( x+400 ,   f2      *yzoom         + y0  );
  point ( x+400 ,  (f2-ref2)*yzoom*restZoom + y0 );
}
