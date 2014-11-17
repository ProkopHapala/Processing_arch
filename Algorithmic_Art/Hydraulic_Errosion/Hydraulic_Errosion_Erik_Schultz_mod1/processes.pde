
// basic class to store x,y,z variables of each point
class spot implements Comparable<spot> {
  int x;
  int y;
  float z;
  
  void reset()   {      z = landscape[x][y].z;     }
  spot(int xi, int yi, float zi)   {  x = xi;  y = yi;  z = zi;   }
  
  int compareTo( spot ref ){
    //if (z > ref.z ){ return 1; }else{ return -1;  }
    if (z > ref.z ){ return 1; }else if (z < ref.z){ return -1;  } else { return 0; }
  };
}



//-----------------------[erode all]-----------------------------------------------------------------------
//finds the run off area for each node
void erode_all(boolean remove){
  iter++;
  
  float t1,t2,tt1,tt2;
  // give everything area 1 [done]
  // sort from highest to lowest [done]
  // starting from highest point, distribute its area to lower neighbors additively [done]
  // store slopes as my location -> where my flow is going (edges have height 0) [done]
  // edges take all flow [done]
  // sorting array
  
  tt1=millis();
  
  //updating spots
  if(iter%sortEach==0){
  t1=millis();
  for (int i = len - 1; i >= 0; i--) {
    sorted_spots[i].reset();
  } 
  t2=millis();
  println( (t2-t1)+"    sorted_spots[i].reset()"  );
  
  //sorting locations from shortest to tallest
  //quick sort
  t1=millis();
    Arrays.sort(sorted_spots);
  t2=millis();
  println( (t2-t1)+"    sorting"  );
  }
    
 // println("done sorting");
  //recording highest and lowest points for coloring
  t1=millis(); 
  max_height = sorted_spots[len -1].z;
  min_height = sorted_spots[0].z;
  //setting all areas to 1
  for (int x = 0; x < t_size; x++) {    for (int y = 0; y < t_size; y++) { landscape[x][y].area = 1; } }
  t2=millis();
  println( (t2-t1)+"    setting areas to 1"  );
  
 // println("done setting all areas to 1");
  
  //distributing flow and finding slope
  t1=millis();
  for (int i = len - 1; i >= 0; i--) { landscape[sorted_spots[i].x][sorted_spots[i].y].find_next(); } 
  t2=millis();
  println( (t2-t1)+"    distributing flow and finding slope"  );
  
 // println("done routing flow");
  
  if (remove) {
  t1=millis();
  //now that area and slope has been found, we can erode
    for (int x = 0; x < t_size; x++) {  for (int y = 0; y < t_size; y++) { landscape[x][y].erode(); } }
  t2=millis();
  println( (t2-t1)+"    done individual eroding"  );
  }
  tt2=millis();
  println( (tt2-tt1)+" -------------   erode done"  );
}




//-----------------------[generate]-----------------------------------------------------------------------

public void generate(){
  noiseSeed(millis());
  
  //setting permanent variables to control variables
  max_height = 2 * global_slope * t_size + noise_scale;
  len = t_size * t_size;
  //initializing all cells
  int i = 0;
  for (int x = 0; x < t_size; x++) {
    for (int y = 0; y < t_size; y++) { 
      landscape   [x][y] = new zone(x,y);
      sorted_spots[i]    = new spot(x,y,landscape[x][y].z);
      i++;
    }
  }
  for (int x = 0; x < t_size; x++) { landscape   [x][0].z = -1000; landscape [x][t_size-1].z = -1000;  };
  for (int y = 0; y < t_size; y++) { landscape   [y][0].z = -1000; landscape [y][t_size-1].z = -1000;  };
  
  
  erode_all(false);
}

