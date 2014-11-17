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

vec2 lgmap( vec2 p ){
	//p = vec2( p.x-p.y, p.y+p.x); 
	//return 3.0*p*p*(1-p) + 1.0*dot(p,p) - mouse*0.01;
	//vec2 m = mouse*0.01;
	//return vec2(  p.x*p.x-p.y*p.y + m.x,  2*p.x*p.y +m.y );
	//return vec2(  p.x*(1-p.x)-p.y*(1-p.y) + m.x,  2*p.x*p.y +m.y );
	//return vec2(  p.x*(1-p.x)-p.y*p.y - 0.5 + m.x,  2*p.x*p.y +m.y -0.5 );
	//return vec2(  p.x*p.x-p.y*p.y - 0.5 + m.x,  2*p.x*(1-p.y) +m.y -0.5 );
	//return 2*vec2( p.x*p.x-p.y*p.y, 2.0*p.x*p.y )/(dot( p,p )+0.1);
	return vec2( p.x*p.x-p.y*p.y, 2.0*p.x*p.y );
}

vec2 lgmapWarp(vec2 p){
	for (int i=0; i<10; i++){
		p += lgmap(p);
		//p = lgmap(p);
	}
	return p;
}


void main(void){
	vec2 q  = (gl_FragCoord.xy / iResolution.xy); 
	//q  += iMouse.xy*0.01;
	//vec2 f = lgmap( q*2 );
	vec2 f = lgmapWarp( (q+ vec2(-0.5,-0.5)) * 4 )*1000000;
    gl_FragColor = vec4( 0.5+f.xy, 0.5, 1.0 );
}
