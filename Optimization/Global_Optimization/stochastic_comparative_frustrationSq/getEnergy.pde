
float Efreq = 4;

final float getEnergy(float x, float y){
nEvaluations++;

/*
// krizici se parabolicke brazdy
float a =  x+y*y;
float b = -x+y*y;
float cx =cos(3.14159265*a*Efreq);
float cy =cos(3.14159265*b*Efreq);
float valey = 3* ( x*x + y*y);
cx*=cx; cy*=cy;
return valey - cx*cx - cy*cy;
*/


// Sklonany koncentricky sinus
//float R2 = (x*x + y*y);
//return R2+cos(R2*20)+x+1;

/*
float cx = cos(x*20);
float cy = cos(y*20);
return (-cx-cy + 2*(x*x+y*y));
*/


float cx = cos(x*10);
float cy = cos(y*10);
return -cx*cx*cx*cx-cy*cy*cy*cy + 2*(x*x+y*y)+1;


// parabola
//return (x*x + y*y);

};







//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
final void evalFitness(Gen mygen){
  mygen.fitness = -getEnergy(mygen.DNA[0],mygen.DNA[1]);
};

//float [][] Emap = new float [2*sz][2*sz];
PImage Emap;
final void initEmap(){
for (int ix=-sz;ix<sz;ix++){
  for (int iy=-sz;iy<sz;iy++){
    
    int cint = int(128+60*getEnergy( ix*pixsz,iy*pixsz));
    color c = color(cint, cint, cint);
    set(ix+sz,iy+sz, c);
  } 
}   
    Emap=get(0, 0, width, height);
}

final void paintEmap(){
tint(255,255,255,255);
image(Emap, 0, 0);
}


