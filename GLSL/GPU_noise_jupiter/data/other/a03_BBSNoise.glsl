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

// Layer between Processing and Shadertoy uniforms
vec3 iResolution = vec3(resolution,0.0);
float iGlobalTime = time;
vec4 iMouse = vec4(mouse,0.0,0.0); // zw would normally be the click status



mat3 m = mat3( 0.00,  0.80,  0.60,
              -0.80,  0.36, -0.48,
              -0.60, -0.48,  0.64 );

// implementation of the blumblumshub hash
// as described in MNoise paper http://www.cs.umbc.edu/~olano/papers/mNoise.pdf
vec4 BBS_coord_prepare(vec4 x) {
// return mod( x, 61.0 );  // unoptimized reference
return x - floor(x * ( 1.0 / 61.0 )) * 61.0;
}

vec4 BBS_permute(vec4 x) {
// return mod( x * x, 61.0 );  // unoptimized reference
return fract( x * x * ( 1.0 / 61.0 )) * 61.0;
}

vec4 BBS_permute_and_resolve(vec4 x) {
// return mod( x * x, 61.0 ) / 61.0;  // unoptimized reference
return fract( x * x * ( 1.0 / 61.0 ) );
}

vec4 BBS_hash( vec2 gridcell ) {
//    gridcell is assumed to be an integer coordinate
vec4 hash_coord = BBS_coord_prepare( vec4( gridcell.xy, gridcell.xy + 1.0.xx ) );
vec4 hash = BBS_permute( hash_coord.xzxz /* * 7.0 */ ); // * 7.0 will increase variance close to origin
return BBS_permute_and_resolve( hash + hash_coord.yyww );
}

void main(void){
	vec2 q  = gl_FragCoord.xy / iResolution.xy;
	vec4 f = BBS_hash( q + vec2(iMouse.x,-iMouse.y)*0.1 );
    gl_FragColor = vec4( f.x,f.y,f.z, 1.0 );
}
