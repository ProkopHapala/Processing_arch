

final float [] xs = { -1, 0,+1,-0.5,+0.5,-1, 0, 1 };
final float [] ys = { -1,-1,-1,   0,   0, 1, 1, 1 };
final float [] Rs = { -1,+1,-1,  +1,  -1,+1,-1,+1 };
final float [] Gs = { -1,-1,+1,  +1,  -1,-1,+1,+1 };
final float [] Bs = { -1,-1,-1,  -1,  +1,+1,+1,+1 };
//                     0  1  2    3    4  5  6  7
final int [] tri1 =  {1,3,4,0,2,6};
final int [] tri2 =  {6,3,4,5,7,1};

void cubicTrinaglePoint( float  u, float v,  int [] i, float [] xs, float [] ys, float [] Rs, float [] Gs, float [] Bs ){
  float w = 1.0 - u - v;
  float uu=u*u;  float vv=v*v; float ww=w*w;
 // float uv=2*u*v;  float uw=2*u*w; float vw=2*v*w;
  float uv=u*v;  float uw=u*w; float vw=v*w;
  //float x = ww*xs[i[0]] + uu*xs[i[1]] + vv*xs[i[2]] + uv*xs[i[3]] + uw*xs[i[4]] + vw*xs[i[5]];
  //float y = ww*ys[i[0]] + uu*ys[i[1]] + vv*ys[i[2]] + uv*ys[i[3]] + uw*ys[i[4]] + vw*ys[i[5]];
  float x = w*xs[i[0]] + u*xs[i[1]] + v*xs[i[2]];
  float y = w*ys[i[0]] + u*ys[i[1]] + v*ys[i[2]]; 
  //float R = ww*Rs[i[0]] + uu*Rs[i[1]] + vv*Rs[i[2]] + uw*Rs[i[3]] + vw*Rs[i[4]] + uv*Rs[i[5]];
  //float G = ww*Gs[i[0]] + uu*Gs[i[1]] + vv*Gs[i[2]] + uw*Gs[i[3]] + vw*Gs[i[4]] + uv*Gs[i[5]];
  //float B = ww*Bs[i[0]] + uu*Bs[i[1]] + vv*Bs[i[2]] + uw*Bs[i[3]] + vw*Bs[i[4]] + uv*Bs[i[5]];
  float R = ww*Rs[i[0]] + uu*Rs[i[1]] + vv*Rs[i[2]] + uw*(Rs[i[3]]+Rs[i[2]] ) + vw*(Rs[i[4]]+Rs[i[1]]) + uv*(Rs[i[5]]+Rs[i[0]]);
  float G = ww*Gs[i[0]] + uu*Gs[i[1]] + vv*Gs[i[2]] + uw*(Gs[i[3]]+Gs[i[2]] ) + vw*(Gs[i[4]]+Gs[i[1]]) + uv*(Gs[i[5]]+Gs[i[0]]);
  float B = ww*Bs[i[0]] + uu*Bs[i[1]] + vv*Bs[i[2]] + uw*(Bs[i[3]]+Bs[i[2]] ) + vw*(Bs[i[4]]+Bs[i[1]]) + uv*(Bs[i[5]]+Bs[i[0]]);
  stroke(R*128+128,G*128+128,B*128+128); point ( 300+x*100,300+y*100 );
  float RR = w*Rs[i[0]] + u*Rs[i[1]] + v*Rs[i[2]];
  float GG = w*Gs[i[0]] + u*Gs[i[1]] + v*Gs[i[2]];
  float BB = w*Bs[i[0]] + u*Bs[i[1]] + v*Bs[i[2]];
  stroke(RR*128+128,GG*128+128,BB*128+128); point ( 500+x*100,500+y*100 );
}

void cubicTrinagle( int [] i, float [] xs, float [] ys, float [] Rs, float [] Gs, float [] Bs ){
for ( float u=0.; u<1.0; u+=0.005 ){  for ( float v=0.; (v+u)<1.0; v+=0.005 ){
    cubicTrinaglePoint( u,  v,  i, xs, ys, Rs,Gs,Bs );  }}
}

void setup(){
  size(800,800);
  cubicTrinagle( tri1  , xs, ys, Rs, Gs, Bs  );
  cubicTrinagle( tri2  , xs, ys, Rs, Gs, Bs  );
}
