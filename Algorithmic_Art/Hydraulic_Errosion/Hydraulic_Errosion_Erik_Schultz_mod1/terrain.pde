
//class that is each point of land
class zone{
  //-----------------------[fields]-----------------------------------------------------------------------
  //coordinates in array
  int x;
  int y;
  float z;
//upstream area
  int area;
  float slope;
//pathfinding
  int next_x;
  int next_y;
  
    
  //----------------------[erode]---------------------------------------------------------------
  
  void erode()  {
    //this.z += uplift - erodability * pow(this.area, area_exponent) * pow(this.slope, slope_exponent);
    this.z += uplift - erodability * sqrt(this.area) * this.slope;
    //this.z += uplift - erodability * this.area * this.slope;
    if (this.z < 0) this.z = 0;
    //F[int(x)][int(y)]=z;
    set((int)x,(int)y, color(z*20)+100 );
  }
   
  //----------------------[bound]---------------------------------------------------------
  
  //give it x y coords, it gives height, but deals with edges
  spot bound(int i, int j)  {
    spot s = new spot(i, j, 0);
    
    //dealing with sides
    if ((i  == -1) || (j  == -1) || (i == t_size) || (j == t_size))    {
      // side method
      return new spot(-1, -1, 0);              //  1 = zero height
      //return new spot(-1, -1, this.z);         //  2 = zero slope
      //return new spot(-1, -1, .99 *this.z);    //  4 = slightly lower      
    }
    else {      //not on edge, just returning height
      return new spot(i,j,landscape[i][j].z);
    }
  }
    
  //-----------------------[find next]-----------------------------------------------------------------------
  
  /*
  void find_next()  {
    spot low = new spot(-1,-1, z);
    
  //looking for lower point
    for (int i = x - 1; i < x + 2; i++) {
      for (int j = y - 1; j < y + 2; j++) {
        if (bound(i,j).z < low.z)       {
          low = bound(i,j);
        }
      }
    }
    
      
    //setting slope
    this.slope = landscape[x][y].z - low.z;
    if (0 != (low.x-x)*(low.y-y)){ //only returns true if both dx and dy are not zero
      this.slope = this.slope/1.4142; //diagonal distance
    }
        
    //giving flow
    if (low.x != -1){ //checking if in local min
      landscape[low.x][low.y].area += this.area;
    }
  }
  */
  
  
  void find_next()  {
    spot low = new spot(-1,-1, z);
    
  //looking for lower point
    for (int i = x - 1; i < x + 2; i++) {
      for (int j = y - 1; j < y + 2; j++) {
        if (bound(i,j).z < low.z)       {
          low = bound(i,j);
        }
      }
    }
    
      
    //setting slope
    this.slope = landscape[x][y].z - low.z;
    if (0 != (low.x-x)*(low.y-y)){ //only returns true if both dx and dy are not zero
      this.slope = this.slope/1.4142; //diagonal distance
    }
        
    //giving flow
    if (low.x != -1){ //checking if in local min
      landscape[low.x][low.y].area += this.area;
    }
  }
  
   //-----------------------[constructor]-----------------------------------------------------------------------
  zone(int nx, int ny) {
    x = nx;      y = ny;
    next_x = -1;     next_y = -1;
    //setting height
    z = x * global_slope + noise_scale * noise(noise_detail * x, noise_detail * y);
    area = 0;
    set((int)x,(int)y, color(z*20)+100 );
    //set((int)x,(int)y, color(z*255) );
    //println(x+" "+y+" "+z);
  }

}








    
