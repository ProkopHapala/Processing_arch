
class OptProblem{
  float evaluate        ( float [] xs, float [] fs              ){ return 0; }
  void genInitialState  ( float [] xs                           ){  };
  
  void plotState        ( float sx0, float sy0, float [] xs, float [] fs, float [] vs ){  }
  void plotState        ( float sx0, float sy0, OptMD optimizer ){  }

}

class Problem_Argon2D extends OptProblem{
  
  void genInitialState  ( float [] xs ){  
    int n = xs.length/2;
    int m = (int)sqrt(n)+1;
    //println( n+" "+m );
    int itot=0; 
    for (int ix=0; ix<m; ix++){ 
      for (int iy=0; iy<m; iy++){
        //println( " ix "+ix+" iy "+iy+" itot "+itot );
        if( itot>=n ) break; 
        xs[2*itot  ]=1.5*(ix-m/2) + random(-0.5,0.5);
        xs[2*itot+1]=1.5*(iy-m/2) + random(-0.5,0.5);
        itot++;
      }
    }
  };
  
  void plotState(  float sx0, float sy0, float [] xs, float [] vs, float [] fs ){  
    int n = xs.length/2;
    for (int i=0; i<n; i++){ 
      int i2 = i*2;
      ellipse( sx0+x2s(xs[i2]),sy0+x2s(xs[i2+1]) ,zoom,zoom);
      line( sx0+x2s(xs[i2]),sy0+x2s(xs[i2+1]), sx0+x2s(xs[i2]+fscale*fs[i2]),sy0+x2s(xs[i2+1]+fscale*fs[i2+1]) );
      //line( sx0+x2s(xs[i2]),sy0+x2s(xs[i2+1]), sx0+x2s(xs[i2]+vscale*vs[i2]),sy0+x2s(xs[i2+1]+vscale*vs[i2+1]) );
    }
  }
  
  void plotState ( float sx0, float sy0, OptMD optimizer ){  
    stroke(optimizer.clr);
    plotState( sx0, sy0, optimizer.xs, optimizer.vs, optimizer.fs );
  }

  float evaluate( float [] xs, float [] fs  ){
    int n = xs.length;
    //println( " n: "+n );
    float E = 0;
    for (int i=0; i<n; i++){ fs[i]=0; }
    for (int i=2; i<n; i+=2){
      float xi = xs[i+0];
      float yi = xs[i+1];
      //println( " >> i "+i );
      for (int j=0; j<i; j+=2){
        float dx  = xs[j+0] - xi;
        float dy  = xs[j+1] - yi;
        float ir2 = 1.0/(dx*dx+dy*dy+0.000001);
              E  +=     ir2*ir2  -   2*ir2         ; 
        float f   =  ( 4*ir2*ir2 -   4*ir2 )*ir2   ;
        //println( " i "+i+" j "+j+" f "+f+" dx "+dx+" dy "+dy );
        float fx  = -dx*f;
        float fy  = -dy*f;
        fs[i   ] +=  fx;
        fs[i+1 ] +=  fy; 
        fs[j   ] += -fx;
        fs[j+1 ] += -fy; 
      }
    }  
    return E;   
  }
  
  
}



