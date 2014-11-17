
int     [][]      natomBuff;
int     [][] []   iatomBuff;
//double3 [][] []   atomsBuff;
//double  [][] [][] coefsBuff;

void findRelevantAtoms( ){
  nbuff_average=0;
  for (int jy = 0; jy < height/sups; jy++) {  for (int jx = 0; jx < width/sups; jx++) {
    int ix=jx*sups; int iy=jy*sups; 
    int n=0;
    if( ZBuff[iy][ix]<(zmax-dpos) ){
      pos.set( zoom*(ix-sz)/sz, zoom*(iy-sz)/sz, ZBuff[iy][ix] );
      for (int i=0;i<atoms.length;i++){
        double rho = evalAtom( pos, atoms[i], coefs[i] );
        //println ( " "+rho+" "+(isolevel / natoms)+"  "+pos.z );
        //if( Math.abs(rho) > (isolevel / (natoms*10)) ){
        if( Math.abs(rho) > (isolevel / 100 ) ){
          //println ( " "+rho+" "+(isolevel / natoms)+"  "+pos.z );
          iatomBuff[jy][jx][n] = i;
          n++;
        } 
      }
      //println(" jx "+jy+" jy "+jx+"  "+natomBuff[jy][jx]  );
    }
    nbuff_average += n;
    natomBuff[jy][jx] = n;
    //println(" jx "+jy+" jy "+jx+"  "+natomBuff[jy][jx]  );
  }}
}

void relevantAtomsInclusion( ){
  nbuff_average=0;
  for (int jy = 0; jy < height/sups-1; jy++) {  for (int jx = 0; jx < width/sups-1; jx++) {
    int [] templist = new int[natoms];
    int n =0;
    int i1=0,i2=0,i3=0,i4=0; 
    for (int i=0;i<atoms.length;i++){
      boolean in = false; 
      if  (( i1<natomBuff[jy  ][jx  ] )&&( iatomBuff[jy  ][jx  ][i1]==i )){  i1++; in=true; }
      if  (( i2<natomBuff[jy  ][jx+1] )&&( iatomBuff[jy  ][jx+1][i2]==i )){  i2++; in=true; }
      if  (( i3<natomBuff[jy+1][jx  ] )&&( iatomBuff[jy+1][jx  ][i3]==i )){  i3++; in=true; }
      if  (( i4<natomBuff[jy+1][jx+1] )&&( iatomBuff[jy+1][jx+1][i4]==i )){  i4++; in=true; }
      if (in){ templist[n]=i; n++; }
    }
    nbuff_average+=n;
    natomBuff[jy][jx] = n;
    iatomBuff[jy][jx] = templist;
    //if(natomBuff[jy][jx]>0) println(" jx "+jy+" jy "+jx+"  "+natomBuff[jy][jx]  );
  }}
}

int nbuff;
void makeBuff( int jy, int jx ){
  int n = natomBuff[jy][jx];
  for (int j=0; j<n; j++){
    int i = iatomBuff[jy][jx][j];
    atomsBuff[j] = atoms[i];
    coefsBuff[j] = coefs[i];
  }
}
