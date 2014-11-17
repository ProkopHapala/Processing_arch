
void LoadMesh(){  //(Nod Nods[],Stick Sticks[]){
  String[] lines;
  lines = loadStrings("mesh.txt");
  int n=0;
  int i=0;
  
  // Nods
  println(" ** Nods ** "+lines[i]);
  String[] pieces = splitTokens(lines[i]);
  n=int(pieces[0]); i++;
  Nods = new Nod[n];  
  for ( int ii=0;ii<n;ii++ ){
    println(lines[i]);
      pieces = splitTokens(lines[i]);
      Nods[ii] = new Nod(float(pieces[0]),float(pieces[1]),false); i++;
      if(pieces[2].equals("T")){Nods[ii].fixed=true;}
      //println(Nods[ii].x);
  }
  
  // Rods
  println(" ** Rods ** "+lines[i]);
  pieces = splitTokens(lines[i]);
  n=int(pieces[0]); i++;
  Rods = new Rod[n];  
  for ( int ii=0;ii<n;ii++ ){
    println(lines[i]);
      pieces = splitTokens(lines[i]);
      Rods[ii] = new Rod(int(pieces[0])-1,int(pieces[1])-1,float(pieces[2]),float(pieces[3])); i++;
    //  Nods[Rods[ii].a].nrod++;    Nods[Rods[ii].b].nrod++;
  }
 /*  
  // Create back reference Nods -> Rods
  for ( int ii=0;ii<Nods.length;ii++ ){ Nods[ii].Rodsi = new int[Nods[ii].nrod];}
  int [] counters = new int[Nods.length];
  for ( int ii=0;ii<Rods.length;ii++ ){
    int iii = Rods[ii].a; Nods[iii].Rodsi[counters[iii]] = ii; counters[iii]++;
        iii = Rods[ii].b; Nods[iii].Rodsi[counters[iii]] = ii; counters[iii]++;
  }
  counters = null;
 */ 
  // Forces
  println(" ** Forces ** "+lines[i]);
  pieces = splitTokens(lines[i]);
  n=int(pieces[0]); i++;
  for ( int ii=0;ii<n;ii++ ){
      println(lines[i]);
      pieces = splitTokens(lines[i]);
      Nods[int(pieces[0])-1].F0x+= float(pieces[1]);
      Nods[int(pieces[0])-1].F0y+= float(pieces[2]);
      i++;
  }
}
