void savefoil(String name){
  int ii=0;
  String[] lines = new String[pupx.length+pdownx.length+1];
  lines[ii]=name; ii++;
    for(int i=pupx.length-1; i>=0; i--){
    lines[ii]=pupx[i]+"     "+pupy[i];
      ii++;
    }
    for(int i=0; i<pdownx.length; i++){
      lines[ii]=" "+pdownx[i]+"     "+pdowny[i];
      ii++;
    }
  saveStrings(name+".dat", lines);
  println("Output to file: "+name+".dat");
}
