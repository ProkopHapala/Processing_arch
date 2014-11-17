class RigidBody_points extends  RigidBody {

  // this is specific for this implementation with 
  double  [] masses;
  double  [] areas ;
  double3 [] points ;  // positions of points
  // temporary variables
  double3 fpoint,xpoint, vpoint,tqpoint;
  
  RigidBody_points( double [][] points, double [] masses, double [] areas ){
    // allocate everything
    super();
    this.masses = masses;
    this.areas  = areas;
    this.points = new double3[ points.length ];
    fpoint  = new double3();
    xpoint  = new double3();
    vpoint  = new double3();
    tqpoint = new double3();
    // find centre of mass
    double mass=0;
    double cx=0,cy=0,cz=0;
    for(int i=0; i<points.length; i++){
      double dm = masses[i];
      double [] point = points[i];
      cx   += dm*point[0]; cy += dm*point[1]; cz += dm*point[2];
      mass += dm;
    }
    //println( " mass  :" + mass ); 
    imass = 1.0d/mass; 
    //println( " imass :" + imass );     
    cx*=imass; cy*=imass; cz*=imass;
    pos.x=cx; pos.y=cy; pos.z=cz;    
    //println( "centre of mass:" + pos );  
    Matrix3x3 Ibody = new Matrix3x3();
    // evaluate points in body-coordiantes and inertia tensor
    for (int i=0; i<points.length; i++){
      double  [] point  =     points[i];
     // println( "i,point:" + i +" "+ point[0]+" "+point[1]+" "+point[2] ); 
      double3 thispoint = new double3(); 
      double x  = point[0] - cx; thispoint.x = x;
      double y  = point[1] - cy; thispoint.y = y;
      double z  = point[2] - cz; thispoint.z = z;
      this.points[i] = thispoint;  
      double  mi        = masses[i];
      double xx = x*x; double yy = y*y;  double zz = z*z; 
      double xy = x*y; double xz = x*z;  double yz = y*z; 
      Ibody.m00 += mi*( yy + zz );
      Ibody.m01 += mi*( -xy );
      Ibody.m02 += mi*( -xz );
      Ibody.m10 += mi*( -xy );
      Ibody.m11 += mi*(  xx + zz );
      Ibody.m12 += mi*( -yz );
      Ibody.m20 += mi*( -xz );
      Ibody.m21 += mi*( -yz  );
      Ibody.m22 += mi*( xx + yy  );      
    }
    // check centre of mass 
    /*
    cx=cy=cz=0;
    for (int i=0; i<points.length; i++){
      cx += masses[i]*this.points[i].x;
      cy += masses[i]*this.points[i].y;
      cz += masses[i]*this.points[i].z;
    } 
    */ 
    println( "check centre of mass: "+cx+" "+cy+" "+cz );
    println( " Ibody  :" );
    println(   Ibody     );
    Ibody.inversion( invIbody );
    println( " invIbody  :" );
    println(   invIbody     );
    // check_inversion
    //invIbody.mmul( Ibody , temp );
    //println( "check invIbody * Ibody" );
    //println( temp );
    //R.similarityTransform_T  ( invIbody, invI );
    
    //R.mmul_T ( invIbody, invI ); R.mmul   ( invI    , invI );
    
    /*
    println( " zpusob_1:  mmul  " );
    R.mmul_T ( invIbody, invI ); 
    println(" invIbody*trnaspose(R): " );
    println(  invI    );
    R.mmul ( invI    , invI );
    println( " invI :" );
    println(  invI    );
    */
    
    println( " R :" );
    println( R      );
    
    println( " Test R orthogonality  " );
    testOrthogonality( R );
    
    println( " zpusob_2:  Similarity  " );
    R.similarityTransform_T  ( invIbody, invI );
    println( " invI :" );
    println( invI      );
    
    //R.mmul ( invIbody, invI ); R.mmul_T   ( invI    , invI );
    //println( " invI :" );
    //println(   invI    );
  }
 
  void evalForce(){
    /*
    println( " R: " );
    println(   R );
    println( " invI: " );
    println(   invI );
    */
    force  .set (  0   );
    torque .set (  0   );
    for (int i=0; i<points.length; i++){
      R.transform      ( points[i], xpoint );
      //R.transform_T      ( points[i], xpoint );
      vpoint.set_cross ( omega, xpoint );
      stroke(255,0,0); plotLineInRotation( 
        pos.x + xpoint.x,                   pos.y + xpoint.y,                   pos.z + xpoint.z,    
        pos.x + xpoint.x + vscale*vpoint.x, pos.y + xpoint.y + vscale*vpoint.y, pos.z + xpoint.z + vscale*vpoint.z, camera );
      //vpoint.set(0);
      vpoint.add       ( v             );
      vpoint.sub       ( vWind         );
      fpoint.set_mul   ( vpoint , -airDrag*areas[i] );  // friction / vicosity
      //double vmag = vpoint.norm2();            // magnitude of point velocity
      //fpoint.set_mul  ( vpoint , -airDrag*areas[i]*vmag );  // air drag
      //fpoint.z    += gravity*masses[i];                     // gravity
      tqpoint.set_cross( xpoint, fpoint  );
      //tqpoint.set_cross( fpoint, xpoint  );
      // acum to global variables
      force .add (  fpoint   );
      stroke(0,0,255); plotLineInRotation( 
        pos.x + xpoint.x,                   pos.y + xpoint.y,                   pos.z + xpoint.z,    
        pos.x + xpoint.x + fscale*fpoint.x, pos.y + xpoint.y + fscale*fpoint.y, pos.z + xpoint.z + fscale*fpoint.z, camera );
      torque.add (  tqpoint  );
    }
   // println( " force  :"+force );
   // println( " torque :"+torque );
  }
  
  void plotPoints(){
    for ( int i=0; i<points.length; i++ ){
      //R.transform_T( points[i], tmpVec );
      R.transform( points[i], tmpVec );
      plotLineInRotation( pos.x, pos.y, pos.z,    pos.x + tmpVec.x, pos.y + tmpVec.y, pos.z + tmpVec.z, camera );
      fill(128,128,128);  plotCircleInRotation( pos.x + tmpVec.x, pos.y + tmpVec.y, pos.z + tmpVec.z, camera,  1*(float)masses[i] );
      noFill();           plotCircleInRotation( pos.x + tmpVec.x, pos.y + tmpVec.y, pos.z + tmpVec.z, camera, 10*(float)areas [i] );
      // plotPointInRotation( pos.x + R.m20, pos.y + R.m21, pos.z + R.m22, camera );
    }
  }
    
}
