
float[][][] buff= new float[szImg][szImg][3];
int[][] depth= new int[szImg][szImg];


float expo = 0.0;

int ntry = 100000; // number of tries 
int ibmax = 5; 

//pure random
void MC(){
for (int n=0;n<ntry;n++){
float x = random(-0.5,0.5);      float y = random(-0.5,0.5); 

MCpoint( x,y);
}
}


// scan + delta_random
void SMC(){
int perpix = ntry / (szImg*szImg)+1;

for (int iix = 0;iix<szImg;iix++){
for (int iiy = 0;iiy<szImg;iiy++){
for (int n=0;n<perpix;n++){
float dx = random(-0.5,0.5);      
float dy = random(-0.5,0.5); 
float x = (iix + dx)/szImg - 0.5; 
float y = (iiy + dy)/szImg - 0.5;

MCpoint(x,y);
}}}
}



void MCpoint(float x,float y){
float[] ray = { x, y, 1.0};
gPoint = gOrigin;

int ib = 0; // iteration
float[] rgb = {1,1,1}; // decay;
while ((ib < ibmax)){
ib++;
raytrace(ray, gPoint);
if (gIntersect){                                    
    gPoint = mul3c(ray,gDist);  // point of intersection
    
    //hit light?
    //if (gType == 1 && gIndex == 1)
    if (gIndex == 3)
    //if (gType == 1)
    {
    int ix = int((x+0.5)*szImg); int iy = int((y+0.5)*szImg);
    if((ix>0)&&(ix<szImg)&&(iy>0)&&(iy<szImg))    
    buff[ix][iy][0]+=rgb[0]; 
    buff[ix][iy][1]+=rgb[1]; 
    buff[ix][iy][2]+=rgb[2];
    depth[ix][iy]=ib; 
    break;
    
    } else 
    
    //NOT LIGHT
    {
    
    //ray = reflect(ray,gPoint);
   
      if (gIndex == 6) {ray = reflect(ray,gPoint);} // hit chrome sphere?
      else{ 
      if (gIndex < 3) {rgb[0]=0.2;rgb[1]=0.2;rgb[2]=0.2;rgb[gIndex]=0.5;}
      ray = diffuse(ray,gPoint);
     }                   // hit diffusive material?

    }
}else{break;} //hit nothing    
}

};


void findexpo(){
for (int x = 0;x<szImg;x++){
for (int y = 0;y<szImg;y++){
//if (depth[x][y]>1){
expo = max(expo,buff[x][y][0]);
expo = max(expo,buff[x][y][1]);
expo = max(expo,buff[x][y][2]);
//}
}
}
println(expo);
};

void renderbuff(){
for (int x = 0;x<szImg;x++){
for (int y = 0;y<szImg;y++){
float[] rgb = buff[x][y];
rgb =  mul3c(rgb, 255.0/expo);
stroke(rgb[0],rgb[1],rgb[2]);
point(x,y);
}
}
};


