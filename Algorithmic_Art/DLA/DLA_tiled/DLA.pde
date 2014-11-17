
final int [] mdx = {-1, 0, 1, -1,  1,  -1, 0, 1}; 
final int [] mdy = {-1,-1,-1,  0,  0,   1, 1, 1};

/*
final int [] mdx = {-1, +1, 0,  0 }; 
final int [] mdy = {0,  0, -1, +1 };
*/
 
boolean trace( int y0, int x0 ){
int x=x0; int y=y0;
if( F[x0][y0]>0 ){return false;}
for (int i=0; i<diffmax; i++){
  int rnd = int( random(mdx.length) );
  int ny=(y+mdy[rnd])%n;
  int nx=(x+mdx[rnd])%n;
  if (ny<0)ny=n-1; if (nx<0)nx=n-1;
  if (F[nx][ny]>0){  
    F[x][y]=nparticles; nparticles++;
    update_tiles( x,y );
    return true; 
  }
  x=nx;y=ny; 
}
return false;
};

void update_tiles(int x, int y){
  int i = (x>>pn) + 2; int j = (y>>pn) + 2;
  //println( i+" "+j);
  int [] FFi = FF[i];
  if(FFi[j]!=2){ 
    FFi[j]=2;
    if (FFi[j-1]  ==0) FFi[j-1]  =1;
    if (FFi[j+1]  ==0) FFi[j+1]  =1;
    if (FF[i+1][j]==0) FF[i+1][j]=1;
    if (FF[i-1][j]==0) FF[i-1][j]=1;
    /*
    FFi = FF[i+1];
    if (FFi[j-1]==0)FFi[j-1]==1;
    if (FFi[j  ]==0)FFi[j  ]==1;
    if (FFi[j+1]==0)FFi[j+1]==1;
    FFi = FF[i-1];
    if (FFi[j-1]==0)FFi[j-1]==1;
    if (FFi[j  ]==0)FFi[j  ]==1;
    if (FFi[j+1]==0)FFi[j+1]==1;
    */
  }
}

void enlistTiles(){
  nlisted = 0;
  for (int i=2;i<FF.length-2;i++){ for (int j=2;j<FF[0].length-2;j++){
    if( FF[i][j]==1 ){ tilelist[nlisted][0]=i-2; tilelist[nlisted][1]=j-2; nlisted++; }
  } }
 // println( " nlisted  " + nlisted );
}
