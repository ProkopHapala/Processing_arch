

class Wing_input{

float span;
float c0  ;  
  
float  [] yChord      ={ 0.0, 0.6,   1.0  };
float  [] chord       ={ 0.15, 0.15,   0.05 };
float  [] yTwist      ={ 0.0, 0.5,   1.0  };
float  [] twist       ={ 0.0, 0.0,   0.0 };
//float  [] twist       ={ 0.0, 0.0,   0.0 };
float  [] yfoil       ={ 0.0,  1.0   };
//String [] foil_name   ={ "2304", "1302"   };
String [] foil_name   ={ "2304", "2304" };
Airfoil [] foils;

float getChord(float y){ /* print ("getChord: "); */  return interpolate( abs(y), yChord, chord   );   }
float getTwist(float y){ /* print ("getTwist: "); */  return interpolate( abs(y), yTwist, twist   )*PI/180.0;   }
float interpolate( float y, float [] ys, float [] fs ){
  if (y>=ys[ys.length-1]){
    return fs[ys.length-1];
  }else{
    int i;  for (i=0; i<ys.length;i++){ if (ys[i]>y) break;   }
   // print( "  "+i+"  "+"  "+y );
    float t =  (y- ys[i-1])/(ys[i]- ys[i-1]);
   // println( y+"  "+i+"  "+t );
    return  (1.0-t)*fs[i-1] + t*fs[i];
  }
}

Airfoil cFoil1,cFoil2;
float tFoil;
void interFoil(float y ){
  y=abs(y);
  if (y>=yfoil[yfoil.length-1]){
      cFoil1 = foils[yfoil.length-2];  cFoil2 = foils[yfoil.length-1];
      tFoil = 1.0;
  }else{
    int i; for (i=0; i<yfoil.length;i++){ if (yfoil[i]>y) break;   };   //   if(before)i--;
    cFoil1 = foils[i-1];  cFoil2 = foils[i];
    tFoil  = (y-yfoil[i-1])/(yfoil[i]-yfoil[i-1]);
  }
}

void updateGeom(){
  yChord[0]=0.0;
  span = yChord[yChord.length-1]*2;
  c0=0;  for(int i=0;i<chord.length;i++){if(chord[i]>c0)c0=chord[i];  if(chord[i]<0)chord[i]=0; }
};

void updateFoils(){
 foils = new Airfoil[foil_name.length];
 for (int i=0;i<foil_name.length; i++ ){
   Airfoil temp=AirfoilData.get( foil_name[i]); 
   if ( temp!=null ){ foils[i] = temp; 
   }else{   
      temp = new Airfoil(foil_name[i]);    
      foils[i] = temp;
      AirfoilData.put(foil_name[i],temp); 
   }   
 }
}


void plot(){

float ox=sx(-yChord[chord.length-1]); float oy=sx(0);  
for(int i=chord.length;i>0;i--){
  float x=sx(-yChord[i-1]); float y=sy(chord[i-1]);
  ellipse(x,y,5,5);
  text( nfc(evalRe(Vinf,chord[i-1]),0) ,x,y );
  if(i>0)line(ox,oy,x,y); ox=x;oy=y;
}


};



}
