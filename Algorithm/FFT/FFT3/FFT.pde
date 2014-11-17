   ///////////////////////////
   //                       //
   //      weights          //
   //   sin(k) cos(k)        //
   /////////////////////////// 
   
float[] cosk;
float[] sink;
   
      void makeW(int n) {
     //n = n;
     //m = (int)(log(n) / log(2));
 
     // Make sure n is a power of 2
     if(n != (1<<m))
       throw new RuntimeException("FFT length must be power of 2 "+n+" "+(1<<m));
 
     // precompute tables
     cosk = new float[n/2];
     sink = new float[n/2]; 
     for(int i=0; i<n/2; i++) {
       cosk[i] = cos(-2*PI*i/n);
       sink[i] = sin(-2*PI*i/n);
     }
 
   }
   
    
   ///////////////////////////
   //                       //
   //          FFT          //
   //                       //
   ///////////////////////////
   int ops = 0;
   
   void fft(float[] x, float[] y)
   {
     int i,j,k,n1,n2,a;
     float c,s,e,t1,t2;
    //ops =0;
   
     // Bit-reverse
     j = 0;
     n2 = n/2;
     for (i=1; i < n - 1; i++) {
       n1 = n2;
       while ( j >= n1 ) {
         j = j - n1;
         n1 = n1/2;
       }
       j = j + n1;
     
       if (i < j) {
         t1 = x[i];
         x[i] = x[j];
         x[j] = t1;
         t1 = y[i];
         y[i] = y[j];
         y[j] = t1;
       }
     }
 
     // FFT
     n1 = 0;
     n2 = 1;
   
     for (i=0; i < m; i++) {
       n1 = n2;
       n2 = n2 + n2;
       a = 0;
     
       for (j=0; j < n1; j++) {
         c = cosk[a];
         s = sink[a];
         a +=  1 << (m-i-1);
 
         for (k=j; k < n; k=k+n2) {
           
           //ops++; // debug - number of operations
           
           t1 = c*x[k+n1] - s*y[k+n1];
           t2 = s*x[k+n1] + c*y[k+n1];
           x[k+n1] = x[k] - t1;
           y[k+n1] = y[k] - t2;
           x[k] = x[k] + t1;
           y[k] = y[k] + t2;
         }
       }
     }
     
      // Normalization
      float Nroot=(1/sqrt(float(n)));
      for (i=0; i < n; i++) {
      x[i]*=Nroot;
      y[i]*=Nroot;
      }
     
   }   
   
   
   ///////////////////////////
   //                       //
   //      inverse FFT      //
   //                       //
   ///////////////////////////
   
   void ifft(float[] x, float[] y){
   for (int i = 0; i<n;i++){ ix[i] = - ix[i];} // invert phase
   fft(x,y);
   }
   
   
