

void BoundaryInitialPos(){
  boundary_x0 = new double[ fix_x.length ];
  for (int i=0;i<fix_x.length; i++){  int ii = fix_x[i];  boundary_x0[i] = verticles[ii].x;  }
  boundary_y0 = new double[ fix_y.length ];
  for (int i=0;i<fix_y.length; i++){  int ii = fix_y[i];  boundary_y0[i] = verticles[ii].y;  }
  boundary_z0 = new double[ fix_z.length ];
  for (int i=0;i<fix_z.length; i++){  int ii = fix_z[i];  boundary_z0[i] = verticles[ii].z;  }
}


void setBoundaryPos( ){
  for (int i=0;i<fix_x.length; i++){  int ii = fix_x[i];   verticles[ii].x = boundary_x0[i]; }
  for (int i=0;i<fix_y.length; i++){  int ii = fix_y[i];   verticles[ii].y = boundary_y0[i]; }
  for (int i=0;i<fix_z.length; i++){  int ii = fix_z[i];   verticles[ii].z = boundary_z0[i]; }
}

void setBoundaryVF( ){
  for (int i=0;i<fix_x.length; i++){  int ii = fix_x[i];   verticles[ii].vx =0; verticles[ii].fx =0; }
  for (int i=0;i<fix_y.length; i++){  int ii = fix_y[i];   verticles[ii].vy =0; verticles[ii].fy =0; }
  for (int i=0;i<fix_z.length; i++){  int ii = fix_z[i];   verticles[ii].vz =0; verticles[ii].fz =0; }
}
