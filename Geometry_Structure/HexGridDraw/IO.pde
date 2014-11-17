
void saveLines( List<GridLine> lines, String fname ){
  println("saved to "+fname );
  PrintWriter  output = createWriter(fname);
  for( GridLine line : lines){ output.println( line );  }
  output.flush(); output.close();
}

List<GridLine> loadLines( String fname ){
  println("loaded from "+fname );
  List<GridLine> lines = new LinkedList<GridLine>();
  String [] slines = loadStrings("lines.txt");
  for ( String sline : slines ){
    GridLine line = new GridLine( sline );
    lines.add(line);
  }
  return lines;
}
