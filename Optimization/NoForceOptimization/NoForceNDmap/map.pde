

PImage Eimage;
final int sz = 300;
final int sz2 = 2*sz;
final float pixsz = 1.0/(float)sz;

float sx( float [] X ){ return X[0]*sz+sz; }
float sy( float [] X ){ return X[1]*sz+sz; }

//float [][] Emap = new float [2*sz][2*sz];
//float [] Xmap;
final float [] Xmap = {0,0,0,0,0};


PImage Emap;
  final void initEmap(){
  for (int ix=-sz;ix<sz;ix++){
    for (int iy=-sz;iy<sz;iy++){
      Xmap[0]=ix*pixsz;
      Xmap[1]=iy*pixsz;
      int cint = int(64*getE( Xmap ));
      color c = color(cint, cint, cint);
      set(ix+sz,iy+sz, c);
    } 
  }   
    Emap=get(0, 0, width, height);
}

final void paintEmap(){
  tint(255,255,255,50);
  image(Emap, 0, 0);
}

