class DelaunayTriangulation {
  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<Triangle> triangles = new ArrayList<Triangle>();
  Triangle canvas;

  DelaunayTriangulation() {
    canvas = getBiggestTriangle();
    triangles.add(canvas);
  }

  void addPoint(float x, float y) {
    addPoint(new PVector(x, y));
  }

  void addPoint(PVector p) {
    points.add(p);
    solve(p);
  }
  
  ArrayList<Triangle> getTriangles(){
    return getTriangles(false);
  }
  
  ArrayList<Triangle> getTriangles(boolean containCanvas){
    ArrayList<Triangle> result = new ArrayList<Triangle>();
    for(Triangle t : triangles){
      if(!t.isSharingPoint(canvas)){
        result.add(t);
      }
      else{
        if(containCanvas){
          result.add(t);
        }
      }
    }
    return result;
  }

  void solve(PVector p) {
    Triangle ABC = getTriangleContainsOf(p);
    triangles.remove(ABC);
    divide(ABC, p);
  }

  void divide(Triangle target, PVector p) {
    ArrayList<Triangle> dividing = new ArrayList<Triangle>();
    dividing.add(new Triangle(target.AB, p));
    dividing.add(new Triangle(target.BC, p));
    dividing.add(new Triangle(target.CA, p));
    ArrayList<Triangle> divided = new ArrayList<Triangle>();
    while (dividing.size()>0) {
      Triangle ABP = dividing.get(0);
      dividing.remove(ABP);
      Edge AB = ABP.getOppositeEdge(p);
      Triangle ADB = getTriangleSharingEdge(ABP, AB, true);
      if (ABP.isSameT(ADB)) {
        divided.add(ABP);
        continue;
      }
      triangles.remove(ADB);
      PVector D = ADB.getOppositeVertex(AB);
      if (ABP.isCircumContains(D)) {
        dividing.addAll(flip(ADB, AB, p));
      } else {
        divided.add(ADB);//isnt need
        divided.add(ABP);
      }
    }
    triangles.addAll(divided);//merge
  }
  
  ArrayList<Triangle> flip(Triangle ADB, Edge AB, PVector p){
    ArrayList<Triangle> result = new ArrayList<Triangle>();
    PVector D = ADB.getOppositeVertex(AB);
    result.add(new Triangle(AB.A, D, p));
    result.add(new Triangle(AB.B, D, p));
    return result;
  }

  void show() {
    for (Triangle t : triangles) {
      if(t.isCircumContains(new PVector(mouseX, mouseY))){
        //t.circum.show();
      }
      line(t.circum.center, getTriangleSharingEdge(t, t.AB, false).circum.center);
      line(t.circum.center, getTriangleSharingEdge(t, t.BC, false).circum.center);
      line(t.circum.center, getTriangleSharingEdge(t, t.CA, false).circum.center);
      t.show();
    }

    for (PVector p : points) {
      ellipse(p.x, p.y, 10, 10);
    }
  }
  
  Triangle getTriangleSharingEdge(Triangle ABC, Edge AB, boolean delete)//find triangle delete from triangles if delete is true
  {
    Triangle ADB = ABC;//仮置
    PVector A = AB.A;
    PVector B = AB.B;
    for(int i = 0; i < triangles.size(); i++)
    {
      Triangle checking = triangles.get(i);
      if (checking.isContains(AB) && !checking.isSameT(ABC))
      {
        PVector D = checking.getOppositeVertex(AB);
        if(delete){
          triangles.remove(i);
        }
        ADB = new Triangle(A, D, B);
        break;
      }
    }
    return ADB;
  }


  Triangle getTriangleContainsOf(PVector p) {
    for (Triangle t : triangles) {
      if(t.isContains(p)){
        return t;
      }
    }
    println("getTriangleConstainOf ERROR");
    return null;
  }

  Triangle getBiggestTriangle() {
    PVector center = new PVector(width/2, height/2);
    float d = PVector.dist(center, new PVector(width, height));
    return new Triangle(
      new PVector(center.x-d*sqrt(3), center.y-d), 
      new PVector(center.x+d*sqrt(3), center.y-d), 
      new PVector(center.x, center.y+d*2)
      );
  }
}