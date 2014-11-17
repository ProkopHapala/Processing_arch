class Satelite{
String name;
// body parametersi
double mass;
float R_body;

// orbital parameters
float R_orbit;
float period;
Satelite centre=null;

// orbital variables
float v;
float omega;
float fi;
PVector X;

Satelite(double mass_, float R_body_ ){
X = new PVector(0,0);
mass=mass_;
R_body = R_body_;
}

void orbit(){
if(centre!=null){
omega = 2*PI/period;
v=omega*R_orbit;
fi+=omega*dt;
X.x = centre.X.x + R_orbit*cos(fi);
X.y = centre.X.y + R_orbit*sin(fi);
//println(X.x+" "+X.y);
}
}

void paint(){
noFill();
stroke(0);
point(  (X.x - viewcentre.X.x)/zoom+sz,(X.y - viewcentre.X.y)/zoom+sz);
stroke(0,16);
if(centre!=null){
ellipse((centre.X.x - viewcentre.X.x)/zoom+sz,(centre.X.y - viewcentre.X.y)/zoom+sz,     2*R_orbit/zoom, 2*R_orbit/zoom);
line((centre.X.x - viewcentre.X.x)/zoom+sz,(centre.X.y - viewcentre.X.y)/zoom+sz, (X.x - viewcentre.X.x)/zoom+sz,(X.y - viewcentre.X.y)/zoom+sz );
}


//fill(0,16);noStroke();
//ellipse(X.x/zoom+sz,X.y/zoom+sz,    zoom2*2*R_body/zoom,zoom2*2*R_body/zoom);
fill(0);noStroke();
ellipse((X.x-viewcentre.X.x)/zoom+sz,(X.y-viewcentre.X.y)/zoom+sz,    2*R_body/zoom,2*R_body/zoom);

}

}
