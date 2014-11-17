
class Nod{
  PVector pos;
  PVector dir;
  float d, r;   // distacne to target
  Nod( PVector pos){ this.pos = pos; }
  void move( float speed ){
    if ((dir!=null)&&(d > 0)){
      // getTerrainSpeed( pos );
      float cslope = altitude.slope(  pos.x/mapScale + mapX0 ,    pos.y/mapScale + mapY0,   dir.x, dir.y );
      speed *= constrain( (1.0-cslope*slopeEffect), 0.1 , 2.0  );   // downhill speed can be up to 2x higher than normal speed, uphill speed can be 0.1x lower 
      float dL = dt*speed; p1.set(dir);  p1.mult( dL ); pos.add( p1 ); d -= dL; 
    }
  }
  void setDir(PVector to){
    if(dir==null){dir = new PVector(); } 
    dir.set(to);     
    // ????  FIXME: shouild there by    dir = to; ??????   
    dir.sub(pos);  d = dir.mag(); dir.mult(1.0/d);
  }  
  void paint(){
    point( pos.x, pos.y );
    //if (dir!=null){   point( sX(dir.x), sY(dir.y) );   }
  } 
}
