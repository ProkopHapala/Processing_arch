
class Body{
Nod feet1,feet2, hip, shoulder, fist;
Rod leg1, leg2, torso, arm;
Rod legspan, shoulderfeet1, shoulderfeet2, fisthip;

VisualKink armKink, leg1Kink, leg2Kink,torsoKink; 

ArrayList<Nod> allNods;
ArrayList<Rod> allRods;
ArrayList<VisualKink> allKinks;

Body( float x, float y){
  allNods = new ArrayList(5);
  allRods = new ArrayList(8);
  allKinks = new ArrayList(4);

  feet1    = new Nod( -0.8+x, 0   +y, 5);   allNods.add( feet1    );
  feet2    = new Nod( +0.2+x, 0   +y, 5);   allNods.add( feet2    );
  hip      = new Nod(  0.0+x, 1.0 +y, 40);   allNods.add( hip      );
  shoulder = new Nod(  0.0+x, 2.0 +y, 40);   allNods.add( shoulder );
  fist     = new Nod(  0.5+x, 2.0 +y, 2);   allNods.add( fist     );
  
  leg1     = new Rod (feet1,    hip,      20000, 2000 , true, false);    allRods.add(leg1);
  leg2     = new Rod (feet2,    hip,      20000, 2000 , true, false);    allRods.add(leg2);
  torso    = new Rod (hip,      shoulder, 20000, 2000 , true, false);    allRods.add(torso);
  arm      = new Rod (shoulder, fist,      5000, 500 , true, false);    allRods.add(arm);
  
  legspan       = new Rod (feet1   ,  feet2,       4000, 400, false, false);    allRods.add(legspan );
  fisthip       = new Rod (fist    ,  hip,         1000, 500, false, false);    allRods.add(fisthip  );
  shoulderfeet1  = new Rod (shoulder,  feet1,      5000, 500, false, false);    allRods.add(shoulderfeet1);
  shoulderfeet2  = new Rod (shoulder,  feet2,      5000, 500, false, false);    allRods.add(shoulderfeet2);
  
  armKink   = new VisualKink ( fist, shoulder , 0.5, 0.5  ); allKinks.add(armKink);
  leg1Kink  = new VisualKink ( hip,  feet1    , 0.7, 0.6  ); allKinks.add(leg1Kink);
  leg2Kink  = new VisualKink ( hip,  feet2    , 0.7, 0.6  ); allKinks.add(leg2Kink);
  torsoKink = new VisualKink ( hip,  shoulder , 0.601, 0.4 ); allKinks.add(torsoKink);
}

void update(double dt){
  for (Rod a: allRods){ a.update();}
  for (Nod a: allNods){ a.update(dt);}
}

void view( World W ){
 strokeWeight(20);  stroke(0);
 for (VisualKink a: allKinks){a.update(); a.view(W);}
 stroke(255,0,0);
 for (Rod a: allRods) {a.view(W);}
 for (Nod a: allNods) {a.view(W);}
}

}


