
double [][] ZBuff;
color  [][] CBuff;

float nbuff_average;

void Render( int offx, int offy, int dix, int diy  ){
  t1 = System.nanoTime();
  //println ( offx+"  "+ offy);
  atomEvals = 0;
  nbuff_average=0;
  for (int iy = offy; iy < height; iy+=dix) {
    for (int ix = offx; ix < width; ix+=diy) {
      color clr=0xffffffff;
      //println(" offx "+offx+" offy "+offy+" ix "+ix+" iy "+iy+" ZBuff "+ZBuff[iy][ix]+"   "+zmin  );
      int jy = iy/sups; int jx = ix/sups;
      int n = natomBuff[jy][jx]; 
      if( n>0 ){
        if( n>=natoms ){
           nbuff    = natoms;
           coefsPix = coefs;
           atomsPix = atoms;
        }else{
           makeBuff(jy,jx);
           nbuff    = n;          
           coefsPix = coefsBuff;
           atomsPix = atomsBuff;
        }
        nbuff_average+=nbuff;
       // println( jx+" "+jy+" "+nbuff  );
        if( ray( zoom*(ix-sz)/sz, zoom*(iy-sz)/sz, ZBuff[iy][ix]-dpos*2 ) ){
          ZBuff [iy][ix] = t;
          // lightning evaluation
          double lgrad    = Math.sqrt(grad.dot());
          double cosA     = grad.dot(lightDir)/lgrad;
          if(rho<0){cosA=-cosA;}
          double enlight1 = Math.max( 0, cosA );
          //float fclr = (float) (0.8*enlight1 + 1.5*Math.exp( -shine*shine  )+0.2);
          float fclr = (float) (c_diffuse*enlight1 + c_ambient + c_shine*shine_gauss(enlight1) );
          if( rho>0 ){   clr = color( fclr*0.3, fclr*0.4, fclr, 1);
          }else{         clr = color( fclr, fclr*0.4, fclr*0.3, 1);      }
          //println(" ix "+ix+" iy "+iy+" t "+t+"  "+clr  );
        }else{
          ZBuff [iy][ix] = zmax;        
        }
      }
      CBuff [iy][ix] = clr;
      set( ix,iy, clr);
    }
    
  }
  T = (System.nanoTime()-t1)*1e-9;
}

float shine_flat(double cosA){
  if(cosA>0.98){    return 1.0;
  }else{            return 0.0;  } 
}

float shine_lorenz(double cosA){
 final double sigma2 = 0.01;
 return (float)(sigma2/( sigma2+1.0-cosA*cosA));  
}

float shine_gauss(double cosA){
 double shine = ((cosA-1.0)/0.01);
 return (float)Math.exp(-shine*shine);  
}

