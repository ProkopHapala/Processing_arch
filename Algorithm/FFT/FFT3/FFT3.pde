//int n,m;

int m = 6;
//int n = 64;   
int n = (1<<m);
 
float[] x  = new float[n]; 
float[] ix = new float[n]; 

int dim = 500;
float dpix = dim / n; 

void setup(){
size(dim,dim);

for (int i = 0; i<n;i++){
//x[i]=cos(5*TWO_PI*i/n)+cos(10*TWO_PI*i/n)+sin(6*TWO_PI*i/n);
//float f = cos(5*TWO_PI*i/n)*cos(6*TWO_PI*i/n);
//float f = i%6;
//float fi = 5*cos(3*TWO_PI*i/n);
//float f = 10*cos(12*TWO_PI*(i+fi)/n);
//x[i]=f;
float f = (3*i-n);
x[i]=200/sqrt(10+f*f);
ix[i]=0;
//ix[i]=sin(5*TWO_PI*i/n)+sin(10*TWO_PI*i/n);;
}

stroke(0);
for (int i = 0; i<n;i++){
 stroke(255,0,0);
line(i*dpix,100,i*dpix, x[i] +100);
 stroke(0,0,255);
line(i*dpix,100,i*dpix, ix[i]+100);
}

makeW(n);

fft(x,ix);

println(ops/float(n));

for (int i = 0; i<n;i++){
  stroke(255,0,0);
line(i*dpix,200,i*dpix, x[i] +200);
 stroke(0,0,255);
line(i*dpix,200,i*dpix, ix[i]+200);
}

for (int i = 0; i<n;i++){ ix[i] = - ix[i];} // invert phase
fft(x,ix); // inverse fourier transform
//for (int i = 0; i<n;i++){ x[i]/=n;} // scale 

for (int i = 0; i<n;i++){
  stroke(255,0,0);
line(i*dpix,300,i*dpix, x[i] +300);
 stroke(0,0,255);
line(i*dpix,300,i*dpix, ix[i]+300);
}

println();
}

 
                       
 
 
 
 



