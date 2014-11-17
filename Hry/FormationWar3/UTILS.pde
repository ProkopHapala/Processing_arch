
float sX(float x){ return (x+cX)*zoom; }
float sY(float y){ return (y+cY)*zoom; }

float wX(float x){ return x/zoom-cX; }
float wY(float y){ return y/zoom-cY; }

void plotMap( Map M, int ns, PVector A, PVector B ){
  for (int ix=0; ix<ns; ix++){  for (int iy=0; iy<ns; iy++){
    float x = (ix*A.x + (ns-ix)*B.x)/ns; float y=(iy*A.y + (ns-iy)*B.y)/ns;
    //M.in(  x/mapScale + mapX0 ,    y/mapScale + mapY0    );
    float c = M.f(  x/mapScale + mapX0 ,    y/mapScale + mapY0    );
    stroke(c,c,c); point(x,y);
  }}    
}
