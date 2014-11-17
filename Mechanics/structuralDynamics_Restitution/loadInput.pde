

void loadMaterials( String fname){
  Table table = loadTable(fname, "header");
  println(table.getRowCount() + " rows in "+fname);
  materials = new HashMap<String,StructuralMatrial>();
  for (TableRow row : table.rows()) { 
    materials.put( row.getString("name").trim(), new StructuralMatrial(
        row.getFloat("density"), row.getFloat("Ytens"), row.getFloat("Ycomp"), row.getFloat("Stens"), row.getFloat("Scomp") 
      ));
  }
}

void loadLinks( String fname){
  Table table = loadTable(fname, "header");
  println(table.getRowCount() + " rows in "+fname);
  links = new Link[ table.getRowCount() ];
  int i=0;
  for (TableRow row : table.rows()) {
    links[i]=new Link( 
      bodies[int(row.getString("ia").trim())], bodies[int(row.getString("ib").trim())], materials.get(row.getString("material").trim())
      , row.getFloat("area"), row.getFloat("r0"), row.getFloat("restitution")
    );
    i++;
  }
}

void loadBodies( String fname){
  Table table = loadTable(fname, "header");
  println(table.getRowCount() + " rows in "+fname);
  bodies = new BasicBody2D[ table.getRowCount() ];
  int i=0;
  for (TableRow row : table.rows()) {
    boolean fixed = false;
    //if( row.getString("fixed").trim().charAt(0)=='T' ) fixed = true;
    if( row.getFloat("fixed")>0 ) fixed = true;
    bodies[i]=new BasicBody2D( 
      row.getFloat("mass"), new double2(row.getFloat("x"), row.getFloat("y")), fixed,
      new double2(row.getFloat("vx"), row.getFloat("vy"))
    );
    i++;
  }
}
