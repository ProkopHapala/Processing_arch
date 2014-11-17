import java.util.Arrays;

/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/46451*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */

//erosion constants
public float uplift = .06;
public float erodability = .1;
public float area_exponent = .5;
public float slope_exponent = 1;

//map generation
final int t_size = 512;
float boxBase = 10;
float speed = .01;

//METHODS
public int color_method = 2;     //1 = height, 2 = area, 3 = slope, 4 = rgb
public int routing_method = 1;   //1 = steepest descent, 2 = distributed
public int side_method = 1;      //1 = zero height, 2 = zero slope, 3 = wrap around

//control variables
public float noise_detail = .04;
public float noise_scale = 10;
public float global_slope = .01;
public boolean eroding = false;

int len = t_size * t_size;
float max_height = 1;
float min_height = 0;

//viewing
public boolean spin = false;
public float zoom = -700;
public float angle = PI /4;
public float tilt = -PI /4;

//time
float t_frame;
float t_old;

//data
boolean[] key_array = new boolean[256];
zone[][] landscape;
spot[] sorted_spots;

float [][] F;
float [][] ounderterrain;

int iter=0;
int sortEach = 5;

void setup()
{
  size (t_size, t_size, P2D);

  landscape = new zone[t_size][t_size];
  sorted_spots = new spot[t_size*t_size];

  //GUI
  generate();
}

void draw()
{
  float h;
  float xd = boxBase * t_size / 2;
  float yd = boxBase * t_size / 2;

  //timing
  t_frame = millis() - t_old;
  t_old = millis();
 // println("bound: " + side_method);
  erode_all(true);

}

