
Nod fillTree( Nod A){
Nod E = genFilled( new Nod()  ); 
Nod D = addSubs( new Nod(), E ); 
Nod C = addSubs( new Nod(), D ); 
Nod B = addSubs( new Nod(), C ); 
        addSubs( A, B );
//addSubs( A, E );
return A;
}


Nod addSubs( Nod A, Nod Sub){  
A.subs = new Nod[n][n][n];
for (int ix=0;ix<n;ix++){
   for (int iy=0;iy<n;iy++){
       for (int iz=0;iz<n;iz++){
        if(random(1)>0.7){
          A.subs[ix][iy][iz] = Sub;
        }
     }
  }
}
return A;
}

Nod genFilled( Nod A){  
A.subs = new Nod[n][n][n];
for (int ix=0;ix<n;ix++){
   for (int iy=0;iy<n;iy++){
      for (int iz=0;iz<n;iz++){
        A.subs[ix][iy][iz] = new Nod();
        if(random(1)>0.5){
          A.subs[ix][iy][iz].filled = true;
          nFilled++;
        } 
    }
  }
}
return A;
}

void render(float ox, float oy){
  for (int ix = 0; ix < width; ix++) {
    for (int iy = 0; iy < height; iy++) {
      int c;
       // buff[ix][iy]*=0.9;
      //  if (A.isIn(   toTree(ix+random(1.0)  +ox)   ,  toTree(iy+random(1.0)+oy)  ) ){}
        buff[ix][iy]=(float)A.isIn(   toTree(ix+random(1.0)  +ox)   ,  toTree(iy+random(1.0)+oy)  ) / (float)Integer.MAX_VALUE;
        c = int(buff[ix][iy]*0xFF);
     
   //  if (A.isIn(  ix*sz2int ,  iy*sz2int  ) ){ c=0xFF;}else{c=0x00;}
     //   buff[ix][iy]*=toTree(ix+random(1.0)  +ox)*toTree(iy+random(1.0)  +ox);
        set(ix,iy,color(c,c,c));
    }
  }
}



final int toTree( float x){
 //print( x+"  ");
 return int( abs( x/height * Integer.MAX_VALUE ) );
}; 

final int toInt(float x){
 return int ( x*Integer.MAX_VALUE  );
};

String toBin(int ii){
 String s = "";
 for (int i=0; i<32; i++){
  if((ii&0x01)==0){s="0"+s;}else{s="1"+s;}
  ii=ii>>1;
 };
 return s;
};
