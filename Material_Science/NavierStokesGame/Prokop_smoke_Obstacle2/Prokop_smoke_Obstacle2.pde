	

        NavierStokesSolver fluidSolver;


	//double	visc = 0.001;
	//double	diff = 3.0;
	double	visc = 0.0000001;
	double	diff = 0.0001;
	double	sc = 1.0;
	double limitVelocity = 200;

        double TunelVelocity = 0.5; 

        double dt = 0.1;

	int oldMouseX = 1, oldMouseY = 1;
	private int bordercolor;
	PImage buffer;
        PImage iao;
        
        int timeMark, timeSolve, timeView;

	int rainbow = 0;

	void setup() {
		fluidSolver = new NavierStokesSolver();
		frameRate(60);
		size(NavierStokesSolver.N, NavierStokesSolver.N, P2D);

		buffer = new PImage(width, height);
		//iao = loadImage("IAO.jpg");
		//background(iao);
		colorMode(HSB, 255);
		bordercolor = color(0,255,255);
		strokeWeight(2);
/*
        // apply external boundary condition
        for (int ix=1;ix<fluidSolver.N;ix++){
         fluidSolver.vx[1][ix] = 5.10;
        }
*/
        
	}

	void draw() {
       
	handleMouseMotion();
        
        timeMark = millis();
	fluidSolver.tick(dt, visc, diff);
        timeSolve = millis() - timeMark;

         // apply external boundary condition
        for (int ix=1;ix<fluidSolver.N;ix++){
         fluidSolver.vx[0][ix] = TunelVelocity;
         fluidSolver.vx[1][ix] = TunelVelocity;
         fluidSolver.vx[2][ix] = TunelVelocity;
         fluidSolver.vy[0][ix] = 0;
         fluidSolver.vy[1][ix] = 0;
         fluidSolver.vy[2][ix] = 0;
        }
        
        for (int ix=80;ix<120;ix++){
         fluidSolver.vx[(ix-80)*2+10][ix] = 0;
         fluidSolver.vx[(ix-80)*2+11][ix] = 0;
         fluidSolver.vx[(ix-80)*2+12][ix] = 0;
         fluidSolver.vx[(ix-80)*2+13][ix] = 0;
         
         fluidSolver.vy[(ix-80)*2+10][ix]   = 0;
         fluidSolver.vy[(ix-80)*2+11][ix] = 0;
         fluidSolver.vy[(ix-80)*2+12][ix] = 0;
         fluidSolver.vy[(ix-80)*2+13][ix] = 0;
        }
       
        timeMark = millis();
	fluidCanvasStep();
        timeView = millis() - timeMark;

	colorMode(HSB, 255);
	bordercolor = color(rainbow, 255,255);
	rainbow+=16;
	rainbow = (rainbow > 255) ? 0 : rainbow;
	drawBorders();

        println("time to Solve: "+timeSolve+" time to view: "+timeView );

	} // end draw

	void drawBorders() {
		stroke(bordercolor);
		line(0,0,width-1,0);
		line(0,0,0,height-1);
		line(width-1,0,width-1,height-1);
		line(0,height-1,width-1,height-1);
		fill(bordercolor);
	}

	void handleMouseMotion() {
		int n = NavierStokesSolver.N;
		float cellHeight = height / n;
		float cellWidth = width / n;
		double mouseDx = mouseX - oldMouseX;
		double mouseDy = mouseY - oldMouseY;
		int cellX = (int) Math.floor(mouseX / cellWidth);
		int cellY = (int) Math.floor(mouseY / cellHeight);
		mouseDx = (abs((float) mouseDx) > limitVelocity) ? Math.signum(mouseDx)
				* limitVelocity : mouseDx;
		mouseDy = (abs((float) mouseDy) > limitVelocity) ? Math.signum(mouseDy)
				* limitVelocity : mouseDy;
		fluidSolver.applyForce(cellX, cellY, mouseDx, mouseDy);

		oldMouseX = mouseX;
		oldMouseY = mouseY;
	}








	void fluidCanvasStep() {
		int n = NavierStokesSolver.N;
		double widthInverse = 1.0 / width;
		double heightInverse = 1.0 / height;
		loadPixels();
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {
				double u = x * widthInverse;        double v = y * heightInverse;
				double warpedPosition[] = fluidSolver.getInverseWarpPosition(u, v,	sc);
				double warpX = warpedPosition[0];   double warpY = warpedPosition[1];
				warpX *= width;   		    warpY *= height;
                                int collor = getSubPixel(warpX, warpY);
				buffer.set(x, y, collor);
			}
		}
		background(buffer);
	}

	int getSubPixel(double warpX, double warpY) {
		if (warpX < 0 || warpY < 0 || warpX > width - 1 || warpY > height - 1) {
			return bordercolor;
		}
		int x = (int) Math.floor(warpX);
		int y = (int) Math.floor(warpY);
		double u = warpX - x;
		double v = warpY - y;

		y = constrain(y, 0, height - 2);
		x = constrain(x, 0, width - 2);

		int indexTopLeft = x + y * width;
		int indexTopRight = x + 1 + y * width;
		int indexBottomLeft = x + (y + 1) * width;
		int indexBottomRight = x + 1 + (y + 1) * width;

		try {
			return lerpColor(lerpColor(pixels[indexTopLeft], pixels[indexTopRight],
					(float) u), lerpColor(pixels[indexBottomLeft],
					pixels[indexBottomRight], (float) u), (float) v);
		} catch (Exception e) {
			System.out.println("error caught trying to get color for pixel position "
					+ x + ", " + y);
			return bordercolor;
		}
	}

	int lerpColor(int c1, int c2, float l){
		colorMode(RGB,255);
		float r1 = red(c1);      float g1 = green(c1);  float b1 = blue(c1);
		float r2 = red(c2);      float g2 = green(c2);  float b2 = blue(c2);
		return color( lerp(r1, r2, l)+0.5, lerp(g1, g2, l)+0.5, lerp(b1, b2, l)+0.5);
	}


