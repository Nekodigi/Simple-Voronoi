class Voronoi {
  ArrayList<Triangle> triangles;
  ArrayList<PVector> points;
  ArrayList<Polygon> polygons = new ArrayList<Polygon>();

  Voronoi() {
  }

  void setDatas(ArrayList<Triangle> triangles, ArrayList<PVector> points) {
    this.triangles = triangles;
    this.points = points;
    for (PVector p : points) {
      ArrayList<Triangle> containTriangles = getTrianglesContainPoint(p);
      Polygon poly = findLinkedPolygon(p);
      if (poly == null) {
        poly = new Polygon(p);
      } else {
        poly.resetVertex();
      }
      Triangle start = containTriangles.get(0);
      Edge prevEdge = start.getEdgeContainPoint(p).get(0);
      Triangle current = getTriangleSharingEdge(start, prevEdge, containTriangles);
      poly.addVertex(start.circum.center);
      while (!current.isSameT(start)) {//find triangle around point
        poly.addVertex(current.circum.center);
        Edge e = current.getEdgeContainPointOppositeEdge(p, prevEdge);
        current = getTriangleSharingEdge(current, e, containTriangles);
      }
      polygons.add(poly);
    }
  }
  
  void show(){
    for(Polygon poly : polygons){
      poly.show();
    }
  }

  Polygon findLinkedPolygon(PVector p) {
    for (Polygon poly : polygons) {
      if (isSame(poly.origin, p)) {
        return poly;
      }
    }
    return null;
  }

  ArrayList<Triangle> getTrianglesContainPoint(PVector p)//similar Delaunay's method
  {
    ArrayList<Triangle> result = new ArrayList<Triangle>();
    for (Triangle t : triangles)
    {
      if (t.isVertexContains(p))
      {
        result.add(t);
      }
    }
    return result;
  }

  Triangle getTriangleSharingEdge(Triangle ABC, Edge AB, ArrayList<Triangle> searchTarget)//similar Delaunay's method
  {
    Triangle ADB = null;//仮置
    PVector A = AB.A;
    PVector B = AB.B;
    for (Triangle t : searchTarget)
    {
      if (t.isContains(AB) && !t.isSameT(ABC))
      {
        PVector D = t.getOppositeVertex(AB);
        ADB = new Triangle(A, D, B);
        break;
      }
    }
    return ADB;
  }
}