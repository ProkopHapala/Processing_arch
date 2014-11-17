// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

#ifdef GL_ES
precision highp float;
#endif

// Type of shader expected by Processing
#define PROCESSING_COLOR_SHADER

// Processing specific input
uniform float time;
uniform vec2  resolution;
uniform vec2  mouse;
uniform int   niter;
uniform float scaleFactor;
uniform float amplitudeFactor;
uniform float amplitude0;
uniform float distRange2;
uniform float ColorAmp;
uniform float rescale;



// =============== NOISE SIN

float hash( float n ){ return fract(sin(n)*43758.5453); }
vec2  hash( in vec2 n ) { return fract(sin(n)*43758.5453); }
vec4  hash( in vec4 n ) { return fract(sin(n)*43758.5453); }


// ================= 2D

float noise_func( in vec2 x ){
    vec2 p = floor(x);
    vec2 f = fract(x);
    f = f*f*(3.0-2.0*f);
    float n = p.x + p.y*57.0;
    return mix(mix( hash(n+  0.0), hash(n+  1.0),f.x),
               mix( hash(n+ 57.0), hash(n+ 58.0),f.x),f.y);
}

const vec2 v01  = vec2( 1,1   );
const vec2 v10  = vec2( 57,57 );
const vec2 v11  = vec2( 58,58 );
const vec4 voff = vec4(0,1,57,58);

vec2 noise_map( in vec2 x ){
    vec2 p = floor(x);
    vec2 f = fract(x);
    f = f*f*(3.0-2.0*f);
    float fn = p.x + p.y*57.0;
	vec2   n = vec2( fn, fn+1545 ); 
    return mix(mix( hash(n     ), hash(n+ v01),f.x),
               mix( hash(n+ v10), hash(n+ v11),f.x),f.y) - vec2(0.5,0.5);
}

// ================== Warping

vec2 multiWarpRot2(in vec2 t, in vec2 dtseed){
	float sc=1, amp=amplitude0;
	vec2 dt = dtseed;
	//vec2 dt = noise_map( t*sc );
	//t+=dt;
	for (int i=0; i<niter; i++){
		vec2 n = noise_map( t*sc )*amp;
		mat2 m = mat2( 1+n.x, -n.y, n.y, 1+n.x   );
		dt = m*dt;
		t += dt;
		sc*=scaleFactor;amp*=amplitudeFactor;
	}
	return t;
}

vec2 grid( in vec2 t ){  return fract(t); };

float dist( in vec2 v, in vec2 q ){ vec2 d=v-q; return distRange2/(distRange2+dot(d,d)); };

// ========================== MAIN

void main(void){
	vec2 q  = (gl_FragCoord.xy / resolution); 
	q  += mouse*0.01;
	q = (q - vec2(0.5,0.5))*rescale;
	vec2 dtseed = vec2( cos(time),sin(time) );
	vec2 v  = multiWarpRot2( q, dtseed );
	gl_FragColor = vec4( sin(v*ColorAmp)*0.5 + vec2(0.5,0.5) ,0,1);
	
}
