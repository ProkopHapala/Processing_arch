int sz = 500;
float zoom= 10*149598261/float(sz);
float zoom2 = 100;
float dt=1.0;

HashMap Bodys = new HashMap();

Satelite viewcentre;

void setup(){
  size(2*sz,2*sz);
  smooth();
  frameRate(30);
  
  addMouseWheelListener(new java.awt.event.MouseWheelListener() { 
    public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) { 
      mouseWheel(evt.getWheelRotation());
  }}); 
  
  // Sun
  Satelite temp;
  temp = new Satelite(1.9891e+30, 695500.0);
  temp.name = "Sun";
  viewcentre = temp;
  Bodys.put("Sun", temp);
  
  // Mercury
  temp = new Satelite(3.3022e+23, 2439.7);
  temp.name = "Mercury";
  temp.R_orbit = 57909100.0;
  temp.period = 87.969;
  temp.centre = (Satelite) Bodys.get("Sun");
  Bodys.put("Mercury", temp);
  
  // Venus
  temp = new Satelite(4.8685e+24, 6051.8);
  temp.name = "Venus";
  temp.R_orbit = 108208930.0;
  temp.period = 224.70069;
  temp.centre = (Satelite) Bodys.get("Sun");
  Bodys.put("Venus", temp);
  
  // Earth
  temp = new Satelite(5.9736e+24, 6378.1);
  temp.name = "Earth";
  temp.R_orbit = 149598261.0;
  temp.period = 365.256363004;
  temp.centre = (Satelite) Bodys.get("Sun");
  Bodys.put("Earth", temp);
  
  // Mars
  temp = new Satelite(6.4185e+23, 3396.2);
  temp.name = "Mars";
  temp.R_orbit = 227939100.0;
  temp.period = 779.96;
  temp.centre = (Satelite) Bodys.get("Sun");
  Bodys.put("Mars", temp);
  
  // Jupiter
  temp = new Satelite(1.8986e+27, 66854.0);
  temp.name = "Jupiter";
  temp.R_orbit = 778547200.0;
  temp.period = 4331.572;
  temp.centre = (Satelite) Bodys.get("Sun");
  Bodys.put("Jupiter", temp);

  // Saturn
  temp = new Satelite(5.6846+26, 54364);
  temp.name = "Saturn";
  temp.R_orbit = 1433449370.0;
  temp.period = 10759.22;
  temp.centre = (Satelite) Bodys.get("Sun");
  Bodys.put("Saturn", temp);
  
  // Uran
  temp = new Satelite(8.6810e+25, 24973);
  temp.name = "Uran";
  temp.R_orbit = 2876679082.0;
  temp.period = 30799.095;
  temp.centre = (Satelite) Bodys.get("Sun");
  Bodys.put("Uran", temp);
  
  // Neptune
  temp = new Satelite(1.0243+26, 24764);
  temp.name = "Neptune";
  temp.R_orbit = 4503443661.0;
  temp.period = 60190;
  temp.centre = (Satelite) Bodys.get("Sun");
  Bodys.put("Neptune", temp);
  
  
  
  // Moon
  temp = new Satelite(7.3477e+22, 1737.10);
  temp.name = "Moon";
  temp.R_orbit = 384399;
  temp.period = 27.321582;
  temp.centre = (Satelite) Bodys.get("Earth");
  Bodys.put("Moon", temp);
  
  //Jupiter moons
  
  temp = new Satelite(8931900e+16, 3660.0/2);
  temp.name = "Io";
  temp.R_orbit = 421700;
  temp.period = 1.76913778;
  temp.centre = (Satelite) Bodys.get("Jupiter");
  Bodys.put("Io", temp);
  
  temp = new Satelite(4800000e+16, 3121.6/2);
  temp.name = "Europa";
  temp.R_orbit = 671034;
  temp.period = 3.551181041;
  temp.centre = (Satelite) Bodys.get("Jupiter");
  Bodys.put("Europa", temp);
  
  temp = new Satelite(14819000e+16, 5262.4/2);
  temp.name = "Ganymede";
  temp.R_orbit = 1070412;
  temp.period = 7.15455296;
  temp.centre = (Satelite) Bodys.get("Jupiter");
  Bodys.put("Ganymede", temp);
  
  temp = new Satelite(10759000e+16, 5262.4/2);
  temp.name = "Callisto";
  temp.R_orbit = 1882709;
  temp.period = 16.6890184;
  temp.centre = (Satelite) Bodys.get("Jupiter");
  Bodys.put("Callisto", temp);
  
}

void draw(){
  background(200);
/*
((Satelite) Bodys.get("Sun")).paint();
((Satelite) Bodys.get("Earth")).orbit();
((Satelite) Bodys.get("Earth")).paint();
*/

Satelite temp;
Iterator i = Bodys.values().iterator();
while (i.hasNext()) {
temp = (Satelite)i.next();
temp.orbit();
temp.paint();
}
};

void mouseWheel(int delta) {
if(delta==1) {zoom*=2;}
if(delta==-1){zoom/=2;}
}

void keyPressed(){
if(key=='+'){dt*=2; println( "time step "+(30*dt)+" day / s");}
if(key=='-'){dt/=2; println( "time step "+(30*dt)+" day / s");}
}

void mousePressed(){
if(mouseButton == LEFT){
//println(viewcentre.name);
float rmin = 1e+29; 
Satelite temp;
Satelite best=viewcentre;
Iterator i = Bodys.values().iterator();
while (i.hasNext()) {
temp = (Satelite)i.next();
float dx= (temp.X.x - viewcentre.X.x)/zoom - (mouseX-sz);
float dy= (temp.X.y - viewcentre.X.y)/zoom - (mouseY-sz);
float r=sqrt(dx*dx+dy*dy);
//println(temp.name+" "+dx+dy+" "+" "+r+" "+rmin);
if(r<rmin){rmin=r; best=temp;}
}
viewcentre=best;
println(viewcentre.name);
}
}


