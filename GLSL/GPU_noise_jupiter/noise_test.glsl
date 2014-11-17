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

/*
vec2 noise_map( in vec2 x ){
    vec2 p = floor(x);
    vec2 f = fract(x);
    f = f*f*(3.0-2.0*f);
    float fn1 = p.x + p.y*57.0;
	float fn2 = fn1+1545;
	//vec4  h1 = hash( fn1.xxxx + voff );
	//vec4  h2 = hash( fn2.xxxx + voff );
	vec4  h1 = hash( vec4(fn1,fn1,fn1,fn1) + voff );
	vec4  h2 = hash( vec4(fn2,fn2,fn2,fn2) + voff );
    return mix(mix( vec2(h1.x,h2.x), vec2(h1.y,h2.y),f.x),
               mix( vec2(h1.z,h2.z), vec2(h1.w,h2.w),f.x),f.y);
}
*/

// ================= 3D
/*
const vec2 v1 = vec2( 113,114);
const vec2 v1 = vec2( 170,171);

float noise_func( in vec3 x ){
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = f*f*(3.0-2.0*f);
    float n = p.x + p.y*57.0 + 113.0*p.z;
    float res = mix(mix(mix( hash(n+  0.0), hash(n+  1.0),f.x),
                        mix( hash(n+ 57.0), hash(n+ 58.0),f.x),f.y),
                    mix(mix( hash(n+113.0), hash(n+114.0),f.x),
                        mix( hash(n+170.0), hash(n+171.0),f.x),f.y),f.z);
    return res;
}

float noise_map( in vec3 x ){
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = f*f*(3.0-2.0*f);
    float fn = p.x + p.y*57.0 + 113.0*p.z;
	vec2 n = vec2( fn, fn+1545.54  ); 
    vec2 res = mix(mix(mix( hash(n+  0.0), hash(n+  1.0),f.x),
                        mix( hash(n+ 57.0), hash(n+ 58.0),f.x),f.y),
                    mix(mix( hash(n+113.0), hash(n+114.0),f.x),
                        mix( hash(n+170.0), hash(n+171.0),f.x),f.y),f.z);
    return res;
}
*/



// ========================== FRACTALIZE FUNCTIONS

const float sc1 = 1.1;      const float amp1 = 0.8;
const float sc2 = sc1*sc1; const float amp2 = amp1*amp1;
const float sc3 = sc2*sc1; const float amp3 = amp2*amp1;
const float sc4 = sc3*sc1; const float amp4 = amp3*amp1;
const float sc5 = sc4*sc1; const float amp5 = amp4*amp1;
const float sc6 = sc5*sc1; const float amp6 = amp5*amp1;

float multiNoise(vec2 t){
	return 
	0.5   * noise_func( t)   +
	0.25  * noise_func( t*2) +
	0.125 * noise_func( t*4) +
	0.125 * noise_func( t*8)
	;
}

/*
const int      n = 100;
const float resc = (1.0/(1<<n));
*/

float multiNoise_logmap(in vec2 t){
	float amp=1;
	float f = noise_func( t );
	float sum = f;
	for (int i=0; i<niter; i++){
		f+= 4*f*(1-f);
		sum+=f*amp;
		amp*=amplitudeFactor;
	}
	return sum/10;
}


vec2 multiWarp(in vec2 t){
	float sc=1, amp=1;
	for (int i=0; i<niter; i++){
		t+= noise_map( t*sc )*amp;
		sc*=scaleFactor;amp*=amplitudeFactor;
	}
	return t;
}

vec2 multiWarpRot(in vec2 t){
	float sc=1, amp=amplitude0;
	vec2 dt = vec2(1,0);
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

vec2 multiWarp_logmap(in vec2 t){
	float amp=1;
	vec2 f = noise_map( t ) + vec2(0.5,0.5);
	t += f;
	for (int i=0; i<niter; i++){
		f = 4*f*(1-f);
		t+=f*amp;
		amp*=amplitudeFactor;
	}
	return t;
}



vec2 Warp3( vec2 t ){
  float amp=1.0;
  for (int i=0; i<niter; i++){
    t  += noise_map( t )*amp;
	t  *= scaleFactor;
    amp*= amplitudeFactor;
  };
  return t;
};


vec2 grid( in vec2 t ){  return fract(t); };

float dist( in vec2 v, in vec2 q ){ vec2 d=v-q; return distRange2/(distRange2+dot(d,d)); };

// ========================== MAIN

void main(void){
	vec2 q  = (gl_FragCoord.xy / resolution); 
	q  += mouse*0.01;
	//float f = noise_bilinear( q*40);
	//float f = multiNoise( q*40);
	q = (q - vec2(0.5,0.5))*rescale;
	//vec2 v  = multiWarp( q );
	//vec2 v  = multiWarp_logmap( q );
	//vec2 v  = multiWarp(q);
	//vec2 v  = multiWarpRot(q);
	vec2 dtseed = vec2( cos(time),sin(time) );
	//float r = 1+noise_func( q )*0.5;  dtseed*=r;
	vec2 v  = multiWarpRot2( q, dtseed );
	//vec2 v  = Warp3( q );
	//vec2 v  = Warp3( multiWarp(q) );
	//float f = multiNoise( v );
	//float f = noise_func( v );
	//float f = multiNoise_logmap( (q - vec2(0.5,0.5))*10 );
	//float f = dist(v,q);
    //gl_FragColor = vec4( f,f,f, 1.0 );
	//gl_FragColor = vec4( v,0, 1.0 );
	//gl_FragColor = vec4( grid(q) ,0,1);
	//gl_FragColor = vec4( grid(v)*ColorAmp ,0,1);
	gl_FragColor = vec4( sin(v*ColorAmp)*0.5 + vec2(0.5,0.5) ,0,1);
	//float f = noise_func( v ); gl_FragColor = vec4( f,f,f, 1.0 );
	//float f = dist(v,q); gl_FragColor = vec4( f,f,f, 1.0 );
	//gl_FragColor = vec4( (v-q)*ColorAmp ,0,1);
	
}
