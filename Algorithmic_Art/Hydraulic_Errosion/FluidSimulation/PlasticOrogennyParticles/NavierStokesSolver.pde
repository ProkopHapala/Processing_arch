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
	final static int N  = 128;
	final static double N_INVERSE = (double)1.0 / (double)N;
        double dx, dy;
	double [][] vx     = new double[N+2][N+2];   double [][] vx_   = new double[N+2][N+2];
	double [][] vy     = new double[N+2][N+2];   double [][] vy_   = new double[N+2][N+2];
        double [][] dens   = new double[N+2][N+2];   double [][] dens_ = new double[N+2][N+2];
        double [][] source = new double[N+2][N+2]; 

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
                //add(dens, source, dt); 
		vel_step(vx, vy, vx_, vy_, visc, dt);              // all dynamics is solved here
		dens_step(dens, dens_, vx, vy, diff, dt);        // this just move mass acording to velocity
	}

	final void dens_step(double[][] dens, double[][] dens0, double[][] vx, double[][] vy, double diff,double dt) {
		//add (dens , dens0 , dt);
		//SWAP       (dens0, dens  );
		//diffuse    (dens  , dens0, diff, dt);
		set_bnd(0, dens);
		SWAP       (dens0, dens  );
		advect     ( dens, dens0, vx, vy, dt);
                set_bnd(0, dens);
	}

	final void vel_step(double[][] vx, double[][] vy, double[][] vx0, double[][] vy0, double visc, double dt) {
		add(vx, vx0, dt);                       add(vy, vy0, dt);
		SWAP(vx0, vx);                          SWAP(vy0, vy);
		diffuse(vx, vx0, visc, dt); 		diffuse(vy, vy0, visc, dt);
                set_bnd(1, vx);                         set_bnd(2, vy);
		project(vx, vy, vx0, vy0);
                SWAP(vx0, vx);      		        SWAP(vy0, vy);
		advect(vx, vx0,     vx0, vy0, dt);      advect(vy, vy0,     vx0, vy0, dt);  // unaseni rychlosti? coze?
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

	final void add(double[][] x, double[][] s, double dt) {      // general adding vector both velocity or density
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
				int i0 = (int) x;     int i1 = i0 + 1;
				int j0 = (int) y;     int j1 = j0 + 1;
				double s1 = x - i0;   double s0 = 1 - s1;
				double t1 = y - j0;   double t0 = 1 - t1;
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
                add( p, source, dt );
		for (int i = 1; i <= N; i++) {
			for (int j = 1; j <= N; j++) {
				vx[i][j] -= 0.5 * h_frac *     (p[i+1][ j ] - p[i-1][ j ]) ;         // accelerate mass
				vy[i][j] -= 0.5 * h_frac *     (p[ i ][j+1] - p[ i ][j-1]) ;
			}
		}
		set_bnd(1, vx); //  vx[:][] reflective
		set_bnd(2, vy); //  vx[:][] reflective
	}
// ========== Boundary conditions ===============

final void boundary_zero( double[][] x) {   // refflective boundary condition
  for (int i = 1; i <= N; i++) {                
      x[0][i] = 0; x[N+1][i] = 0;
      x[i][0] = 0; x[i][N+1] = 0;
  } 
}

// refflective boundary condition
final void boundary_reflect( double[][] x) {   
  for (int i = 1; i <= N; i++) {                
      x[0][i] = -x[1][i]; x[N+1][i] = -x[N][i];
      x[i][0] = -x[i][1]; x[i][N+1] = -x[i][N];
  } 
}

// absorbing boundary condition 
final void boundary_absorb( double[][] x) {   
  for (int i = 1; i <= N; i++) {                
      x[0][i] = x[1][i]; x[N+1][i] = x[N][i];
      x[i][0] = x[i][1]; x[i][N+1] = x[i][N]; 
  } 
}

 //======== periodic boundary condition
final void boundary_periodic( double[][] x) {  
  for (int i = 1; i <= N; i++) {                
      x[0][i] = x[N][i]; x[N+1][i] = x[1][i];
      x[i][0] = x[i][N]; x[i][N+1] = x[i][1]; 
  } 
}

//======== set corner points as average of line
final void corners(double[][] x){
  x[ 0 ][ 0 ] = 0.5 * (x[1][ 0 ] + x[ 0 ][1]);      
  x[ 0 ][N+1] = 0.5 * (x[1][N+1] + x[ 0 ][N]);
  x[N+1][ 0 ] = 0.5 * (x[N][ 0 ] + x[N+1][1]);
  x[N+1][N+1] = 0.5 * (x[N][N+1] + x[N+1][N]);
}

final void set_bnd( int b, double[][] x) {
 if (b==1) { boundary_reflect( x ); }
 else      { boundary_absorb(  x ); }
 //boundary_periodic( x  );
 corners(x); 
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

 void interpolatedMove(double x, double y) {
    x*=N;  y*=N;
    int ix = (int)( x + 10000) - 10000;  // fast floor
    int iy = (int)( y + 10000) - 10000;
    double wx = x - ix; double mx = 1.0 - wx;
    double wy = y - iy; double my = 1.0 - wy;
    //if((abs(ix-(N/2))>(N/2-2))||(abs(iy-(N/2))>(N/2-2))) println(  x+" "+y+" "+ix+" "+iy);
    //ix++; iy++;
    dx = my* (mx*vx[ix][iy]+ wx*vx[ix+1][iy]) + wy*(mx*vx[ix][iy+1]+ wx*vx[ix+1][iy+1])  ;
    dy = my* (mx*vy[ix][iy]+ wx*vy[ix+1][iy]) + wy*(mx*vy[ix][iy+1]+ wx*vy[ix+1][iy+1])  ;
  }
  
}

