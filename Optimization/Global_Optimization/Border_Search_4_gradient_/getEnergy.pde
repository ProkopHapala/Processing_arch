
float Efreq = 1.5;



float [][] ccos = {
{ 0.0, 0.0, 0.0,   0.0,  0.0, 0.0, 0.0  },
{ 0.0, 0.0, 0.0,   0.0,  0.0, 0.0, 0.0  },
{ 0.5, 0.0, 1.0,   1.0,  1.0, 0.0, 0.0  },

{ 0.0, 0.0, 1.0,   0.0,  1.0, 0.0, 0.0  },

{ 0.0, 0.0, 1.0,   1.0,  1.0, 0.0, 0.0  },
{ 0.0, 1.0, 0.0,   0.0,  0.0, 0.0, 0.5  },
{ -0.0, 0.0, 0.0,   0.0,  0.0, 0.0, -0.0  },
};


float fx,fy;

final float getEnergy(float x, float y){
x*=Efreq*TWO_PI;  
y*=Efreq*TWO_PI;  
nEvaluations++;
float E=0;  fx=0; fy=0;
for (int ix=-3;ix<=3;ix++){
  float cx = cos(ix*x);  float sx = sin(ix*x);
  for (int iy=-3;iy<=3;iy++){
    float ccc = ccos[iy+3][ix+3];
    if(ccc!=0){
      float cy = cos(iy*y);  float sy = sin(iy*y);
      float cc= cx*cy - sx*sy;
      float ss= cx*sy + sx*cy;  
      E +=    cc*ccc;
      fx+= ix*ss*ccc;
      fy+= iy*ss*ccc;
    }
  }
}
return E*0.5;
};







//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

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
tint(255,255,255,50);
image(Emap, 0, 0);
}


