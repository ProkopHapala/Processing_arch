/**
 * Java implementation of the Navier-Stokes-Solver from
 * http://www.dgp.toronto.edu/people/stam/reality/Research/pdf/GDC03.pdf
 * 
 */
public class NavierStokesSolver {
        //int ndiffuse  = 20;
        //int npressure = 20;
        int ndiffuse  = 5;
        int npressure = 5;
	final static int N = 160;
	final static double N_INVERSE = (double)1.0 / (double)N;
	double [][] vx    = new double[N+2][N+2];   double [][] vx_   = new double[N+2][N+2];
	double [][] vy    = new double[N+2][N+2];   double [][] vy_   = new double[N+2][N+2];
        double [][] dens  = new double[N+2][N+2];   double [][] dens_ = new double[N+2][N+2];

 //---------------------------------------------------------------
 // ---------------------- Interface  UTILS-----------------------
 //---------------------------------------------------------------
 
	public double getDx(int x, int y) {  return vx[x+1][y+1];   }
	public double getDy(int x, int y) {  return vy[x + 1][ y + 1]; 	}
	public void applyForce(int cellX, int cellY, double fx, double fy) {
	  vx[cellX][cellY] += fx * dt;
	  vy[cellX][cellY] += fy * dt;
	}

 //---------------------------------------------------------------
 // ---------------------- MAIN ALGORITHM ------------------------
  //---------------------------------------------------------------


	void tick(double dt, double visc, double diff) {
		vel_step(vx, vy, vx_, vy_, visc, dt);
		dens_step(dens, dens_, vx, vy, diff, dt);
	}

	final void dens_step(double[][] dens, double[][] dens0, double[][] vx, double[][] vy, double diff,double dt) {
		add_source (dens , dens0 , dt);
		SWAP       (dens0, dens  );
		diffuse    (dens  , dens0, diff, dt);
		set_bnd(0, dens);
		SWAP       (dens0, dens  );
		advect     ( dens, dens0, vx, vy, dt);
                set_bnd(0, dens);
	}

	final void vel_step(double[][] vx, double[][] vy, double[][] vx0, double[][] vy0, double visc, double dt) {
		add_source(vx, vx0, dt);                add_source(vy, vy0, dt);
		SWAP(vx0, vx);                          SWAP(vy0, vy);
		diffuse(vx, vx0, visc, dt); 		diffuse(vy, vy0, visc, dt);
                set_bnd(1, vx);                         set_bnd(2, vy);
		project(vx, vy, vx0, vy0);
                SWAP(vx0, vx);      		        SWAP(vy0, vy);
		advect(vx, vx0,     vx0, vy0, dt);      advect(vy, vy0,     vx0, vy0, dt);
                set_bnd(1, vx);                         set_bnd(2, vy);
		project(vx, vy, vx0, vy0);             // meaning of variables:      void project(vx, vy, p, diverg)
	}

	final void SWAP(double[][] A, double[][] B) {
                   for (int ix=0;ix<N;ix++){
                       for (int iy=0;iy<N;iy++){
                        double temp = A[ix][iy];
                        A[ix][iy] = B[ix][iy];
                        B[ix][iy] = temp;
                       }
                   }
	}

	final void add_source(double[][] x, double[][] s, double dt) {      // general adding vector both velocity or density
                   for (int ix=0;ix<N+1;ix++){
                       for (int iy=0;iy<N+1;iy++){
                          x[ix][iy] += dt * s[ix][iy];
                       }
                   }
			
	}

	final void diffuse( double[][] x, double[][] x0, double diff, double dt) {    // diffuse velocity
		double a = dt * diff * N * N;
                double a_frac = 1/(1 + 4 * a);
		for (int k = 0; k < ndiffuse; k++) {
			for (int i = 1; i <= N; i++) {
				for (int j = 1; j <= N; j++) {
					x[i][j] = a_frac*(x0[i][j] + a*(   x[i-1][j  ] 
                                                                         + x[i+1][j  ] 
                                                                         + x[i  ][j-1] 
                                                                         + x[i  ][j+1] ));
				}
			}
		}
	}

	final void advect(double[][] d, double[][] d0,         double[][] vx, double[][] vy, double dt) {
	//	int i0, j0, i1, j1;
	//	double x, y, s0, t0, s1, t1;
		double dt0 = dt * N;
		for (int i = 1; i <= N; i++) {
			for (int j = 1; j <= N; j++) {
				double x = i - dt0 * vx[i][j];
				double y = j - dt0 * vy[i][j];
				  if (x < 0.5)        x = 0.5;
				  if (x > N + 0.5)    x = N + 0.5;
				  if (y < 0.5)        y = 0.5;
				  if (y > N + 0.5)    y = N + 0.5;
				int i0 = (int) x;
				int i1 = i0 + 1;
				int j0 = (int) y;
				int j1 = j0 + 1;
				double s1 = x - i0;
				double s0 = 1 - s1;
				double t1 = y - j0;
				double t0 = 1 - t1;
				d[i][j] = s0 * (t0 * d0[i0][j0] + t1 * d0[i0][j1])
				        + s1 * (t0 * d0[i1][j0] + t1 * d0[i1][j1]);
			}
		}
	}

	final void project(double[][] vx, double[][] vy, double[][] p, double[][] diverg) {
		double h = 1.0 / N;
                double h_frac = 1.0/h;
		for (int i = 1; i <= N; i++) {
			for (int j = 1; j <= N; j++) {
				diverg[i][ j] = -0.5 * h * (                                        // compute velocity divergence
                                                    vx[i+1][j  ]   - vx[i-1][j  ] 
                                              +     vy[i  ][j+1]   - vy[i  ][j-1]   );
				p[i][j] = 0;
			}
		}
		set_bnd(0, diverg);
		set_bnd(0, p);
		for (int k = 0; k < npressure; k++) {                  
			for (int i = 1; i <= N; i++) {
				for (int j = 1; j <= N; j++) {
					p[i][ j] = 0.25*(  diverg[i][ j]                             // evaluate pressure from velocity divergence
                                                     + p[i-1][ j ] + p[i+1][j  ]                     // average pressure, to blur
                                                     + p[i  ][j-1] + p[i  ][j+1]      ); 
				}
			}
		set_bnd(0, p);
		}
		for (int i = 1; i <= N; i++) {
			for (int j = 1; j <= N; j++) {
				vx[i][j] -= 0.5 * h_frac *     (p[i+1][ j ] - p[i-1][ j ]) ;         // accelerate mass
				vy[i][j] -= 0.5 * h_frac *     (p[ i ][j+1] - p[ i ][j-1]) ;
			}
		}
		set_bnd(1, vx); //  vx[:][] reflective
		set_bnd(2, vy); //  vx[:][] reflective
	}


	final void set_bnd(int b, double[][] x) {
                  // set boundary x
                if (b==1){
                  for (int i = 1; i <= N; i++) {                // refflective boundary condition
			x[0  ][i] = -x[1][ i];
			x[N+1][i] = -x[N][ i];
                }}else{                                         // absorbing boundary condition
                  for (int i = 1; i <= N; i++) { 
                       	x[ 0 ][i] = x[1][ i];
			x[N+1][i] = x[N][ i];
                  }}
                // set boundary y
                if (b==1){
                  for ( int i = 1; i <= N; i++) {
                        x[i][ 0 ] = -x[i][1];
		        x[i][N+1] = -x[i][N];
                }}else{
                  for (int i = 1; i <= N; i++) {
                        x[i][ 0 ] = x[i][1];
		        x[i][N+1] = x[i][N];  
                }}
                
		x[ 0 ][ 0 ] = 0.5 * (x[1][ 0 ] + x[ 0 ][1]);      // set corner points as average of line
		x[ 0 ][N+1] = 0.5 * (x[1][N+1] + x[ 0 ][N]);
		x[N+1][ 0 ] = 0.5 * (x[N][ 0 ] + x[N+1][1]);
		x[N+1][N+1] = 0.5 * (x[N][N+1] + x[N+1][N]);
	}



///---------------------------------------------------------------------
//             WARP Iterpolator 
//-----------------------------------------------------------------

/*
     All parameters and return values are in normalized form 0.0 - 1.0
       @param x     original horizontal position
       @param y     original vertical position
     return warped position, inverse to the motion direction
*/
	double[] getInverseWarpPosition(double x, double y, double scale) {
		double result[] = new double[2];

		int cellX = (int) Math.floor(x * N);
		int cellY = (int) Math.floor(y * N);

		double cellU = (x * N - (cellX)) * N_INVERSE;
		double cellV = (y * N - (cellY)) * N_INVERSE;
		
		cellX += 1;
		cellY += 2;

		result[0] = (cellU > 0.5) 
                          ? lerp(vx[cellX    ][cellY], vx[cellX + 1][cellY],    cellU - 0.5) 
                          : lerp(vx[cellX - 1][cellY], vx[cellX    ][cellY],    0.5 - cellU);
		result[1] = (cellV > 0.5) 
                          ? lerp(vy[cellX][cellY], vy[cellX][cellY + 1],       cellU) 
                          : lerp(vy[cellX][cellY], vy[cellX][cellY - 1], 0.5 - cellV);

		result[0] *= -scale;   result[1] *= -scale;
		result[0] += x;        result[1] += y;

		return result;
	}

	final double lerp(double x0, double x1, double l) {
		l *= 1;
		return (1 - l) * x0 + l * x1;
	}


}

