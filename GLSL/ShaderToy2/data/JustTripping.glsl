

#ifdef GL_ES
precision highp float;
#endif

// Type of shader expected by Processing
#define PROCESSING_COLOR_SHADER

// Processing specific input
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;



// http://www.fractalforums.com/new-theories-and-research/very-simple-formula-for-fractal-patterns/

const int iterations=23;

void main(void)
{
	vec2 p=gl_FragCoord.xy / resolution.xy-.5;
	p.y*=resolution.y/resolution.x;
	p*=.6+pow(sin(time*.15),4.)*10.;
	p+=vec2(sin(time*.2),cos(time*.1));
	p=vec2(p.x*cos(time*.2)-p.y*sin(time*.2),
		   p.y*cos(time*.2)+p.x*sin(time*.2));
	vec2 j=(1.-mouse.xy/resolution.xy)*1.3+vec2(.1);
	float expsmooth=0.;
	float average=0.;
	float l=length(p);
	float prevl;
	for (int i=0; i<iterations; i++) {
		p=abs(p*(1.5+cos(time*.1)*.5))/dot(p,p)-j;
		prevl=l;
		l=length(p);
		expsmooth+=exp(-1.2/abs(l-prevl));
		average+=abs(l-prevl);
	}
	float brightness=expsmooth*.1;
	average/=float(iterations)*15.;
	average+=time*.2;
	vec3 c=vec3(1.,.4,.3);
	vec3 color;
	color.r=mod(average,c.r*2.)-c.r;
	color.g=mod(average,c.g*2.)-c.g;
	color.b=mod(average,c.b*2.)-c.b;
	color=normalize(abs(color)+vec3(.3));
	gl_FragColor = vec4(color*brightness,1.0);
}
