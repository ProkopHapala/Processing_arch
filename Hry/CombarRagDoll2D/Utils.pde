

class World{

float x0, y0, zoom;

int x(double xx){
 return int((float)( 0.5*width  - (xx+x0)*zoom));
};

int y(double yy){
 return int((float)(  0.5*height - (yy+y0)*zoom));
};

World( float x0, float y0, float zoom ){
  this.x0=x0; this.y0=y0; this.zoom=zoom;
}

}


final double sign(double v ){
if(v<0){return -1.0d;}else{return 1.0d;}
}

final double constrain( double v, double minv, double maxv ){
if(v<minv){ 
  return minv;
}else{ 
  if(v>maxv){ 
    return maxv;
  }else{return v;}
  }
};
