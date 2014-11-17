
class Model{
  String [] names;
  String prefix, postfix;
  OBJModel [] meshs;

  Model( String [] names, String prefix, String postfix){
    this.names = names; this.prefix = prefix; this.postfix = postfix;
    load();
  }
 
  void load(){
    meshs = new OBJModel[names.length];
    import saito.objloader.OBJModel;
    for(int i=0; i<names.length; i++){
        meshs[i] = new OBJModel(main,(prefix+names[i]+postfix), "relative", QUADS);
        //meshs[i].scale(30);
    } 
  }
  
  void draw(){
      for(int i=0; i<meshs.length; i++){
          meshs[i].disableMaterial();
          int imask = 127; int cmin = 20; int seet = 911445;
          fill( (randFunc(i*100+10515 + seet)&imask) + cmin,  (randFunc(i*200+10150 + seet )&imask) + cmin, (randFunc(i*300+4100 + seet)&imask) + cmin);
        meshs[i].draw();
        if (i<2){  pushMatrix();  scale(-1,1,1); meshs[i].draw();  popMatrix(); }
      }
  }
  
}
