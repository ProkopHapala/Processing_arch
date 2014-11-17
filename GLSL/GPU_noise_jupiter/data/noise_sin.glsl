
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

