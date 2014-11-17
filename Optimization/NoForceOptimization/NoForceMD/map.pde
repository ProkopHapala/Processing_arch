
float sx( float x ){ return x*zoom+sz; }
float sy( float y ){ return y*zoom+sz; }

float isx( float x ){ return (x-sz)/zoom; }
float isy( float y ){ return (y-sz)/zoom; }

PImage makeEmap( Func_vec2float func ){
  float [] Xmap = new float[2];
  for (int ix=0;ix<width;ix++){
     Xmap[0]=isx(ix);
    for (int iy=0;iy<height;iy++){
      Xmap[1]=isy(iy);
      int cint = int(64 * func.eval( Xmap ) );
      color c = color(cint, cint, cint);
      set(ix,iy, c);
    } 
  }   
  return get(0, 0, width, height);
}


final void paintEmap(){
  //tint(255,255,255,50);
  image( Eimage, 0, 0);
}

