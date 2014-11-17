//int n,m;

int m = 8;
//int n = 64;   
int n = (1<<m);

int dim = n;
float dpix = dim / n;  
  
float[][] R  = new float[n][n]; 
float[][] iR = new float[n][n]; 

float[][] M  = new float[n][n]; 
float[][] iM = new float[n][n]; 

void setup(){
size(dim*3,dim*2,P2D);
colorMode(RGB,1.0);

FillPict(R,iR);
PaintPict(0,0,R);
PaintPict(0,dim,iR);

FillMask(M,iM);
PaintPict(0,dim,M);
//PaintPict(0,dim,iM);

initFFT(n);

fft2D(R,iR);
//PaintPict(dim,0,R);
//PaintPict(dim,dim,iR);

fft2D(M,iM);
//PaintPict(dim,0,M);
//PaintPict(dim,dim,iM);

// convolution in fourier space
for (int ix = 0; ix<n;ix++){for (int iy = 0; iy<n;iy++){
R[ix][iy]*=M[ix][iy];
iR[ix][iy]*=iM[ix][iy];
}}
PaintPict(dim,0,R);
PaintPict(dim,dim,iR);

ifft2D(R,iR);
PaintPict(2*dim,0,R);
PaintPict(2*dim,dim,iR);

/*
ifft2D(M,iM);
PaintPict(2*dim,0,M);
PaintPict(2*dim,dim,iM);
*/
}


void FillMask(float[][] R, float [][] iR){
for (int ix = 0; ix<n;ix++){
for (int iy = 0; iy<n;iy++){
float fx = (2*ix-n);
float fy = (2*iy-n);
R[ix][iy]=200/(10+fx*fx+fy*fy);
iR[ix][iy]=0;
}
}
}

void FillPict(float[][] R, float [][] iR){
float f;
for (int ix = 0; ix<n;ix++){
for (int iy = 0; iy<n;iy++){

R[ix][iy]=0;
if((ix%32==0)&&(iy%32==0))
R[ix][iy]=1;

/*
f = abs(n*sin(5*TWO_PI*ix/float(n))-iy);
R[ix][iy]=10/(100+f*f);
*/

if((ix==iy)||(ix==iy/2))
R[ix][iy]=1;

if((ix+8)==iy)
R[ix][iy]=1;

iR[ix][iy]=0;
}
}
}

float PaintPict(int x,int y,float[][] Img){
float Top=0;
for (int ix = 0; ix<n;ix++){ for (int iy = 0; iy<n;iy++){
Top = max(Top,Img[ix][iy]);
}}
for (int ix = 0; ix<n;ix++){ for (int iy = 0; iy<n;iy++){
stroke(Img[ix][iy]/Top);
point(ix+x,iy+y);
}}
return Top;
}

