final int sz = 512;
void setup(){
 size(sz,sz);
 smooth();
  for (int ix=0;ix<sz;ix++){
    for (int iy=0;iy<sz;iy++){
      float V = 0;
      for (int i=0;i<12;i++){
        V+=VWire(ix,iy,i*sz/4 - sz,150);
        V-=VWire(ix,iy,(i+0.5)*sz/4 - sz,sz-150);
      }
      if(abs(V)>0.2){
        set(ix,iy, color(0) );
      }else{ 
        V=10*( int(V*250));
        float c1 = max(+V,0); 
        float c2 = max(-V,0); 
        set(ix,iy, color(255-c1,255-c1-c2,255-c2) );
      }
    }
  }
save("field.png");
}


float VWire( float x, float y, float x0, float y0 ){
        float dx = x-x0;
        float dy = y-y0;
        float r2 = dx*dx+dy*dy;
        return 1.0/sqrt(r2); 
}


