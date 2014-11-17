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



//parameters
const int iterations=20;
const float scale=1.3;
const vec2 fold=vec2(.5);
const vec2 translate=vec2(1.5);
const float zoom=.25;
const float brightness=7.;
const float saturation=.65;
const float texturescale=.15;
const float rotspeed=.1;
const float colspeed=.05;
const float antialias=2.;


vec2 rotate(vec2 p, float angle) {
return vec2(p.x*cos(angle)-p.y*sin(angle),
		   p.y*cos(angle)+p.x*sin(angle));
}

void main(void)
{
	vec3 aacolor=vec3(0.);
	vec2 pos=gl_FragCoord.xy / iResolution.xy-.5;
	float aspect=iResolution.y/iResolution.x;
	pos.y*=aspect;
	pos/=zoom; 
	vec2 pixsize=max(1./zoom,100.-iGlobalTime*50.)/iResolution.xy;
	pixsize.y*=aspect;
	for (float aa=0.; aa<25.; aa++) {
		if (aa+1.>antialias*antialias) break;
		vec2 aacoord=floor(vec2(aa/antialias,mod(aa,antialias)));
		vec2 p=pos+aacoord*pixsize/antialias;
		p+=fold;
		float expsmooth=0.;
		vec2 average=vec2(0.);
		float l=length(p);
		for (int i=0; i<iterations; i++) {
			p=abs(p-fold)+fold;
			p=p*scale-translate;
			if (length(p)>20.) break;
			p=rotate(p,iGlobalTime*rotspeed);
			average+=p;
		}
		average/=float(iterations);
		vec2 coord=average+vec2(iGlobalTime*colspeed);
		//vec3 color=texture2D(iChannel0,coord*texturescale).xyz;
		vec3 color = vec3(0.5,0.5,0.5); 
		color*=min(1.1,length(average)*brightness);
		color=mix(vec3(length(color)),color,saturation);
		aacolor+=color;
	}
	gl_FragColor = vec4(aacolor/(antialias*antialias),1.0);
}
