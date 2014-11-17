// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.


#ifdef GL_ES
precision highp float;
#endif

// Type of shader expected by Processing
#define PROCESSING_COLOR_SHADER

// Processing specific input
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;

vec4 mymod  (vec4 x) {  return x - floor(x * (1.0 / 214013.0)) * 214013.0; }
vec4 rndFunc(vec4 x) {  return mymod(((x)+2531011)*x);                }

vec2 mymod(vec2 x)   {  return x - floor(x * (1.0 / 214013.0)) * 214013.0; }
vec2 rndFunc(vec2 x) {  return mymod(((x)+2531011)*x);                 }

float mymod  (float x) { return x - floor(x * (1.0 / 214013.0)) * 214013.0; }
float rndFunc(float x) { return mymod(((x)+2531011)*x);                 }

float noise_bilinear( vec2 t){
	vec2 it = floor(t);
	vec2 dt = t - it;
	vec2 mt = 1.0 - dt; 
	vec4 xs = it.xxxx + vec4(0,1,0,1);
	vec4 ys = it.yyyy + vec4(0,0,1,1);
	vec4 fs = rndFunc( rndFunc( xs*110 + ys ) )*(1.0/327670.0);
	return mt.y*(mt.x*fs.x+dt.x*fs.y ) + dt.y*(mt.x*fs.z+dt.x*fs.w);
}

vec2 noise_bilinear2( vec2 t){
	vec2 it = floor(t);
	vec2 dt = t - it;
	vec2 mt = 1.0 - dt; 
	vec4 xs = it.xxxx + vec4(0,1,0,1);
	vec4 ys = it.yyyy + vec4(0,0,1,1);
	vec4 fs1 = rndFunc( rndFunc( xs*110 + ys ) )         *(1.0/327670.0);
	vec4 fs2 = rndFunc( rndFunc( xs*110 + ys + 100 ) )   *(1.0/327670.0);
	return vec2( 
		mt.y*(mt.x*fs1.x+dt.x*fs1.y ) + dt.y*(mt.x*fs1.z+dt.x*fs1.w) - 0.2,
		mt.y*(mt.x*fs2.x+dt.x*fs2.y ) + dt.y*(mt.x*fs2.z+dt.x*fs2.w) - 0.5
	);
}

float multiNoise(vec2 t){
	return 
	0.5   * noise_bilinear( t)   +
	0.25  * noise_bilinear( t*2) +
	0.125 * noise_bilinear( t*4) +
	0.125 * noise_bilinear( t*8) 
	;
}

const int      n = 5;
const float resc = (1.0/(1<<n));

/*
vec2 multiWarp(vec2 t){
	for (int i=0; i<n; i++){
		//t *=2;
		t += noise_bilinear2( t*2 ) ;
	};
	//return t*resc;
	return t;
}
*/

const float sc1 = 2.0;      const float amp1 = 0.6;
const float sc2 = sc1*sc1; const float amp2 = amp1*amp1;
const float sc3 = sc2*sc1; const float amp3 = amp2*amp1;
const float sc4 = sc3*sc1; const float amp4 = amp3*amp1;
const float sc5 = sc4*sc1; const float amp5 = amp4*amp1;
const float sc6 = sc5*sc1; const float amp6 = amp5*amp1;


vec2 multiWarp(vec2 t){
	t += noise_bilinear2( t   );
	t += noise_bilinear2( t*sc1 )*amp1;
	t += noise_bilinear2( t*sc2 )*amp2;
	t += noise_bilinear2( t*sc3 )*amp3;
	t += noise_bilinear2( t*sc4 )*amp4;
	t += noise_bilinear2( t*sc5 )*amp5;
	return t;
}

float bellFunc(vec2 t) {
	float r2 = dot(t,t);
	if(r2<1.0){
		float mr2 = 1 - r2;
		return mr2*mr2;
	}else{
		return 0;
	}
}


void main(void){
	vec2 q  = (gl_FragCoord.xy / resolution); 
	//q  += iMouse.xy*0.01;
	//float f = noise_bilinear( q*40);
	//float f = multiNoise( q*40);
	vec2 v  = multiWarp( (q - vec2(0.5,0.5))*5 );
	//float f = multiNoise( v );
	float f = bellFunc(v - vec2(0.5,0.5));
    gl_FragColor = vec4( f,f,f, 1.0 );
}
