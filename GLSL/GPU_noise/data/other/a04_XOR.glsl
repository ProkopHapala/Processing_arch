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


void main(void){
	vec2 q  = gl_FragCoord.xy / iResolution.xy;
	int ix = int(q.x*2147483648.0);
	int iy = int(q.y*2147483648.0);
	//int ix = int(q.x<<10);
	//int iy = int(q.y<<10);
	//vec4 f = ix*0.1 + ix*0.01 + ix*0.001  + 1000.0*ix + 100.0*ix + 10.0*ix;
	//vec4 f = q.x;
	float f = (iy^ix) * (1.0 / 2147483648.0);
    gl_FragColor = vec4( f,f,f, 1.0 );
}
