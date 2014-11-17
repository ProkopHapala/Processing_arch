
final static double  dot_SIMD( final double [] a, final double [] b ){ 
  double sum1 = 0; double sum2 = 0; double sum3 = 0; double sum4 = 0; double sum5 = 0; double sum6 = 0; double sum7 = 0; double sum8 = 0;
  int n8 = a.length&0xFFFFFFF8;
  for(int i=0; i<n8; i+=8) { 
    sum1+=a[i  ]*b[i  ];
    sum2+=a[i+1]*b[i+1];
    sum3+=a[i+2]*b[i+2];
    sum4+=a[i+3]*b[i+3];
    sum5+=a[i+4]*b[i+4];
    sum6+=a[i+5]*b[i+5];
    sum7+=a[i+6]*b[i+6];
    sum8+=a[i+7]*b[i+7];    
    //println( i+" "+i1+" "+i2+" "+i3+" "+i4+" "+i5+" "+i6+" "+i7  );
  }
  //println( " dot_SIMD "+n4 );
  double sumRest = 0; 
  for(int i=n8; i<a.length; i++) { 
    sumRest+=a[i]*b[i];  
    //println( i ); 
  };
  return sum1+sum2+sum3+sum4+sum5+sum6+sum7+sum8+sumRest;       
}


final static void fma_SIMD( final double [] a, final double [] b, double f, double [] c ){ 
  int n8 = a.length&0xFFFFFFF8;
  for(int i=0; i<n8; i+=8) { 
                       c[i ]=a[i ]+ f*b[i  ];
    final int i1 =i+1; c[i1]=a[i1]+ f*b[i1];
    final int i2 =i+2; c[i2]=a[i2]+ f*b[i2];
    final int i3 =i+3; c[i3]=a[i3]+ f*b[i3];
    final int i4 =i+4; c[i4]=a[i4]+ f*b[i4];
    final int i5 =i+5; c[i5]=a[i5]+ f*b[i5];
    final int i6 =i+6; c[i6]=a[i6]+ f*b[i6];
    final int i7 =i+7; c[i7]=a[i7]+ f*b[i7];
    //println( i+" "+(i+1)+" "+(i+2)+" "+(i+3)  );
  }
  //println( " dot_SIMD "+n4 );
  double sumRest = 0; 
  for(int i=n8; i<a.length; i++) { 
    c[i]=a[i]+ f*b[i];  
   // println( i ); 
  };
     
}
