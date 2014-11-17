
final float getE(float x, float y){
nEvaluations++;

/*
float ca=cos((x+y)*4);
float cb=cos((x-y)*4);
float r2 = x*x+y*y;
return   -(ca*ca*ca*ca + cb*cb*cb*cb)*1  + 0.5   +    r2*4;
*/

/*
float a = x-y;
float b = x+y;
return a*a*6 + b*b*0.5;
*/

float  a = cos(x*6-3.0) - y*2;
return a*a*5 + x*x*5;


};

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

//float [][] Emap = new float [2*sz][2*sz];
PImage Emap;
final void initEmap(){
for (int ix=-sz;ix<sz;ix++){
  for (int iy=-sz;iy<sz;iy++){
    
    int cint = int(64*getE( ix*pixsz,iy*pixsz));
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


