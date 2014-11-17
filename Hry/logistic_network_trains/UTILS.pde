

int index(int ix,int iy){
return ix*nGrid + iy;
};

void addRoadToGrid(ArrayList<City> cities, ArrayList<Road> roads, int ix1, int iy1,   int ix2, int iy2 ){
    City A = cities.get(index(ix1  ,iy1  ));
    City B = cities.get(index(ix2  ,iy2  ));
    Road temp = new Road( A, B, 100  );
    roads.add(temp);
}
