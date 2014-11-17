// Created by Reinder Nijhoff 2013
//
// based on: http://www.iquilezles.org/www/articles/simplepathtracing/simplepathtracing.htm
//


#ifdef GL_ES
precision highp float;
#endif

// Type of shader expected by Processing
#define PROCESSING_COLOR_SHADER

#define MOTIONBLUR
#define DEPTHOFFIELD

//#define USECUBEMAP
#define CUBEMAPSIZE 256

#define SAMPLES 8
#define PATHDEPTH 4
#define TARGETFPS 60.

#define FOCUSDISTANCE 18.
#define FOCUSBLUR 0.3

#define RAYCASTSTEPS 20
#define RAYCASTSTEPSRECURSIVE 2

#define EXPOSURE 0.7
#define EPSILON 0.001
#define MAXDISTANCE 180.
#define GRIDSIZE 8.
#define GRIDSIZESMALL 5.9
#define MAXHEIGHT 10.
#define SPEED 0.5


// Processing specific input
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;

//
// math functions
//

float hash( float n ) {
	return fract(sin(n)*43758.5453);
}
vec2 hash2( float n ) {
	return fract(sin(vec2(n,n+1.0))*vec2(2.1459123,3.3490423));
}
vec2 hash2( vec2 n ) {
	return fract(sin(vec2( n.x*n.y, n.x+n.y))*vec2(2.1459123,3.3490423));
}
vec3 hash3( vec2 n ) {
	return fract(sin(vec3(n.x, n.y, n+2.0))*vec3(3.5453123,4.1459123,1.3490423));
}
//
// intersection functions
//

bool intersectPlane(vec3 ro, vec3 rd, float height, out float dist) {	
	if (rd.y==0.0) {
		return false;
	}
	
	float d = -(ro.y - height)/rd.y;
	d = min(100000.0, d);
	if( d > 0. ) {
		dist = d;
		return true;
	}
	return false;
}

bool intersectUnitSphere ( in vec3 ro, in vec3 rd, in vec3 sph, out float dist, out vec3 normal ) {
	vec3  ds = ro - sph;
	float bs = dot( rd, ds );
	float cs = dot(  ds, ds ) - 1.0;
	float ts = bs*bs - cs;
	
	if( ts > 0.0 ) {
		ts = -bs - sqrt( ts );
		if( ts>0. ) {
			normal = normalize( (ro+ts*rd)-sph );
			dist = ts;
			return true;
		}
	}
	
	return false;
}

//
// Scene
//

void getSphereOffset( vec2 grid, inout vec2 center ) {
	center = (hash2( grid+vec2(43.12,1.23) ) - vec2(0.5) )*(GRIDSIZESMALL);
}
void getMovingSpherePosition( vec2 grid, vec2 sphereOffset, inout vec3 center ) {
	// falling?
	float s = 0.1+hash( grid.x*1.23114+5.342+754.324231*grid.y );
	float t = 14.*s + time/s;
	
	float y =  s * MAXHEIGHT * abs( cos( t ) );
	vec2 offset = grid + sphereOffset;
	
	center = vec3( offset.x, y, offset.y ) + 0.5*vec3( GRIDSIZE, 2., GRIDSIZE );
}
void getSpherePosition( vec2 grid, vec2 sphereOffset, inout vec3 center ) {
	vec2 offset = grid + sphereOffset;
	center = vec3( offset.x, 0., offset.y ) + 0.5*vec3( GRIDSIZE, 2., GRIDSIZE );
}
vec3 getSphereColor( vec2 grid ) {
	return normalize( hash3( grid+vec2(43.12*grid.y,12.23*grid.x) ) );
}

// http://the-witness.net/news/2012/02/seamless-cube-map-filtering/
vec3 cube(in vec3 v) {
   float M = max(max(abs(v.x), abs(v.y)), abs(v.z));
   float scale = (float(CUBEMAPSIZE) - 1.) / float(CUBEMAPSIZE);
   if (abs(v.x) != M) v.x *= scale;
   if (abs(v.y) != M) v.y *= scale;
   if (abs(v.z) != M) v.z *= scale;
   return textureCube(iChannel1, v).xyz;
}

// code duplication because the for-loop requires a const
vec3 traceRec(vec3 ro, vec3 rd, out vec3 intersection, out vec3 normal, out float dist, out int material) {
	dist = MAXDISTANCE;
	float distcheck;
	
	vec3 sphereCenter, col, normalcheck;
	
	if( intersectPlane( ro,  rd, 0., distcheck) && distcheck < MAXDISTANCE ) {
		dist = distcheck;
		material = 1;
		normal = vec3( 0., 1., 0. );
		col = vec3( 0.5 );
	} else {
		material = 0; // sky
#ifdef USECUBEMAP
		col = 3.0*cube(rd);
#else
		col = vec3( 0.8, 0.9, 1.0 ) * (1.8 * (rd.y+0.5) );
#endif
	}
	
	// trace grid
	vec2 map = floor( ro.xz / GRIDSIZE ) * GRIDSIZE;
	float deltaDistX = GRIDSIZE*sqrt(1. + (rd.z * rd.z) / (rd.x * rd.x));
	float deltaDistY = GRIDSIZE*sqrt(1. + (rd.x * rd.x) / (rd.z * rd.z));
	float stepX, stepY, sideDistX, sideDistY;
	
	//calculate step and initial sideDist
	if (rd.x < 0.) {
		stepX = -GRIDSIZE;
		sideDistX = (ro.x - map.x) * deltaDistX / GRIDSIZE;
	} else {
		stepX = GRIDSIZE;
		sideDistX = (map.x + GRIDSIZE - ro.x) * deltaDistX / GRIDSIZE;
	}
	if (rd.z < 0.) {
		stepY = -GRIDSIZE;
		sideDistY = (ro.z - map.y) * deltaDistY / GRIDSIZE;
	} else {
		stepY = GRIDSIZE;
		sideDistY = (map.y + GRIDSIZE - ro.z) * deltaDistY / GRIDSIZE;
	}
	
	bool hit = false; 
	vec2 offset;
	
	for( int i=0; i<RAYCASTSTEPSRECURSIVE; i++ ) {
		if( hit ) continue;
		
		getSphereOffset( map, offset );
		
		getMovingSpherePosition( map, -offset, sphereCenter );
		
		if( intersectUnitSphere( ro, rd, sphereCenter, distcheck, normalcheck ) && distcheck < dist ) {
			dist = distcheck;
			normal = normalcheck;
			col = getSphereColor(map);
			material = 1;
			hit = true;
		}
		
		getSpherePosition( map, offset, sphereCenter );
		if( intersectUnitSphere( ro, rd, sphereCenter, distcheck, normalcheck ) && distcheck < dist ) {
			dist = distcheck;
			normal = normalcheck;
			col = getSphereColor(map+vec2(1.,2.));
			material = 1;
			hit = true;
		}
						
		if (sideDistX < sideDistY) {
			sideDistX += deltaDistX;
			map.x += stepX;
		} else {
			sideDistY += deltaDistY;
			map.y += stepY;
		}		
	}
	
	intersection = ro+rd*dist;
	
	return col;
}


vec3 trace(vec3 ro, vec3 rd, out vec3 intersection, out vec3 normal, out float dist, out int material) {
	dist = MAXDISTANCE;
	float distcheck;
	
	vec3 sphereCenter, col, normalcheck;
	
	if( intersectPlane( ro,  rd, 0., distcheck) && distcheck < MAXDISTANCE ) {
		dist = distcheck;
		material = 1;
		normal = vec3( 0., 1., 0. );
		col = vec3( 0.5 );
	} else {
		material = 0; // sky
#ifdef USECUBEMAP
		col = 3.0*cube(rd);
#else
		col = vec3( 0.8, 0.9, 1.0 ) * (1.8 * (rd.y+0.5) );
#endif
	}
	
	// trace grid
	vec2 map = floor( ro.xz / GRIDSIZE ) * GRIDSIZE;
	float deltaDistX = GRIDSIZE*sqrt(1. + (rd.z * rd.z) / (rd.x * rd.x));
	float deltaDistY = GRIDSIZE*sqrt(1. + (rd.x * rd.x) / (rd.z * rd.z));
	float stepX, stepY, sideDistX, sideDistY;
	
	//calculate step and initial sideDist
	if (rd.x < 0.) {
		stepX = -GRIDSIZE;
		sideDistX = (ro.x - map.x) * deltaDistX / GRIDSIZE;
	} else {
		stepX = GRIDSIZE;
		sideDistX = (map.x + GRIDSIZE - ro.x) * deltaDistX / GRIDSIZE;
	}
	if (rd.z < 0.) {
		stepY = -GRIDSIZE;
		sideDistY = (ro.z - map.y) * deltaDistY / GRIDSIZE;
	} else {
		stepY = GRIDSIZE;
		sideDistY = (map.y + GRIDSIZE - ro.z) * deltaDistY / GRIDSIZE;
	}
	
	bool hit = false; 
	vec2 offset;
	
	for( int i=0; i<RAYCASTSTEPS; i++ ) {
		if( hit ) continue;
		if(  distance( ro.xz, map ) > dist+GRIDSIZE ) {
			hit = true;
			continue;
		}
		
		getSphereOffset( map, offset );
		
		getMovingSpherePosition( map, -offset, sphereCenter );
		
		if( intersectUnitSphere( ro, rd, sphereCenter, distcheck, normalcheck ) && distcheck < dist ) {
			dist = distcheck;
			normal = normalcheck;
			col = getSphereColor(map);
			material = 1;
			hit = true;
		}
		
		getSpherePosition( map, offset, sphereCenter );
		if( intersectUnitSphere( ro, rd, sphereCenter, distcheck, normalcheck ) && distcheck < dist ) {
			dist = distcheck;
			normal = normalcheck;
			col = getSphereColor(map+vec2(1.,2.));
			material = 1;
			hit = true;
		}
						
		if (sideDistX < sideDistY) {
			sideDistX += deltaDistX;
			map.x += stepX;
		} else {
			sideDistY += deltaDistY;
			map.y += stepY;
		}		
	}
	
	intersection = ro+rd*dist;
	
	return col;
}

vec2 rv2;

vec3 cosWeightedRandomHemisphereDirection2( vec3 n ) {
    float  theta = acos(sqrt(1.0-rv2.x));
    float  phi = 2.0 * 3.1415926535897932384626433832795 * rv2.y;

    float xs = sin(theta) * cos(phi);
    float ys = cos(theta);
    float zs = sin(theta) * sin(phi);

	vec3 h = n;
    if (abs(n.x)<=abs(n.y) && abs(n.x)<=abs(n.z))
        h.x= 1.0;
    else if (abs(n.y)<=abs(n.x) && abs(n.y)<=abs(n.z))
        h.y= 1.0;
    else
        h.z= 1.0;


    vec3 x = normalize( cross( h, n ) );
    vec3 z = cross( x, n );

    vec3 direction = xs * x + ys * n + zs * z;
    return normalize( direction );
}

void main(void) {
	vec2 q = gl_FragCoord.xy/resolution.xy;
	vec2 p = -1.0+2.0*q;
	p.x *= resolution.x/resolution.y;
	
	vec3 col = vec3( 0. );
	
	// raytrace
	int material;
	vec3 normal, intersection;
	float dist;
	
	for( int j=0; j<SAMPLES; j++ ) {
		float fj = float(j);
		
#ifdef MOTIONBLUR
		time = iGlobalTime + fj/(float(SAMPLES)*TARGETFPS);
#endif
		
		rv2 = hash2( fj+time+texture2D( iChannel0, p*0.8 ).r );
		
		vec2 pt = p+rv2/(0.5*resolution.xy);
				
		// camera	
		vec3 ro = vec3( cos( 0.232*time) * 10., 7.+3.*cos(0.3*time), GRIDSIZE*(time/SPEED) );
		vec3 ta = ro + vec3( -sin( 0.232*time) * 10., -2.0+cos(0.23*time), 10.0 );
		
		float roll = -0.15*sin(0.5*time);
		
		// camera tx
		vec3 cw = normalize( ta-ro );
		vec3 cp = vec3( sin(roll), cos(roll),0.0 );
		vec3 cu = normalize( cross(cw,cp) );
		vec3 cv = normalize( cross(cu,cw) );
	
#ifdef DEPTHOFFIELD
    // create ray with depth of field
		const float fov = 3.0;
		
        vec3 er = normalize( vec3( pt.xy, fov ) );
        vec3 rd = er.x*cu + er.y*cv + er.z*cw;

        vec3 go = FOCUSBLUR*vec3( (rv2-vec2(0.5))*2., 0.0 );
        vec3 gd = normalize( er*FOCUSDISTANCE - go );
		
        ro += go.x*cu + go.y*cv;
        rd += gd.x*cu + gd.y*cv;
		rd = normalize(rd);
#else
		vec3 rd = normalize( pt.x*cu + pt.y*cv + 1.5*cw );		
#endif		
						
		bool bghit = false;		
		vec3 colsample = vec3( 1. );
		
		for( int i=0; i<PATHDEPTH; i++ ) {
			if( bghit ) continue;
			
			rv2 = hash2( rv2.x*2.4543263+rv2.y*time+(float(i)*.23) );
			
			if( i == 0 ) {
				colsample *= trace(ro, rd, intersection, normal, dist, material);
			} else {
				colsample *= traceRec(ro, rd, intersection, normal, dist, material);
			}
			
			if( material == 0 ) {
				bghit = true;
			} else {
				rd = cosWeightedRandomHemisphereDirection2( normal );
				ro = intersection + EPSILON*rd;
			}
		}
	
		if( bghit ) {
			col += colsample;
		}
	}
	col  /= float(SAMPLES);
	
	col = pow( col, vec3(EXPOSURE, EXPOSURE, EXPOSURE) );	
	col = clamp(col, 0.0, 1.0);
	
	// vigneting
	col *= 0.25+0.75*pow( 16.0*q.x*q.y*(1.0-q.x)*(1.0-q.y), 0.15 );
	
	gl_FragColor = vec4( col,1.0);
}
