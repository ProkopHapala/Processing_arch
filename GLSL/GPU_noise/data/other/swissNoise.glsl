/*

ref:
swiss noise: http://www.decarpentier.nl/scape-procedural-extensions

*/


#ifdef GL_ES
precision highp float;
#endif

// Type of shader expected by Processing
#define PROCESSING_COLOR_SHADER

// Processing specific input
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;

// Layer between Processing and Shadertoy uniforms
vec3 iResolution = vec3(resolution,0.0);
float iGlobalTime = time;
vec4 iMouse = vec4(mouse,0.0,0.0); // zw would normally be the click status

vec4 mymod  (vec4 x) {  return x - floor(x * (1.0 / 214013.0)) * 214013.0; }
vec4 rndFunc(vec4 x) {  return mymod(((x)+2531011)*x);                }

vec2 mymod(vec2 x)   {  return x - floor(x * (1.0 / 214013.0)) * 214013.0; }
vec2 rndFunc(vec2 x) {  return mymod(((x)+2531011)*x);                 }

float mymod  (float x) { return x - floor(x * (1.0 / 214013.0)) * 214013.0; }
float rndFunc(float x) { return mymod(((x)+2531011)*x);                 }





const float seed=15564;
const int   octaves=5;
const float lacunarity = 2.0;
const float gain = 0.5;
const float warp;


float swissTurbulence(vec2 p){
	float sum = 0;
	float freq = 1.0, amp = 1.0;
	vec2 dsum = float2(0,0);
	for(int i=0; i < octaves; i++) {
	vec3 n = noise_bilinear( (p + warp * dsum)*freq );
         sum += amp * ( 1 - abs(n.x) );
        dsum += amp * n.yz * -n.x;
        freq *= lacunarity;
         amp *= gain * saturate(sum);
    }
    return sum;
}




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
		mt.y*(mt.x*fs1.x+dt.x*fs1.y ) + dt.y*(mt.x*fs1.z+dt.x*fs1.w),
		mt.y*(mt.x*fs2.x+dt.x*fs2.y ) + dt.y*(mt.x*fs2.z+dt.x*fs2.w)
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


vec2 multiWarp(vec2 t){
	t += noise_bilinear2( t   );
	t += noise_bilinear2( t*2 )*0.8;
	t += noise_bilinear2( t*4 )*0.6;
	t += noise_bilinear2( t*8 )*0.4;
	return t;
}

void main(void){
	vec2 q  = (gl_FragCoord.xy / iResolution.xy); 
	q  += iMouse.xy*0.01;
	//float f = noise_bilinear( q*40);
	//float f = multiNoise( q*40);
	vec2 v2  = multiWarp(q*20);
	//	vec2 v2s = sin(v2);  float f = dot(v2s,v2s)*0.5;
	float f = multiNoise( v2 );
    gl_FragColor = vec4( f,f,f, 1.0 );
}
