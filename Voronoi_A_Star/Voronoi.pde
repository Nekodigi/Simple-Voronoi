class Voronoi {
  ArrayList<Triangle> triangles;
  ArrayList<PVector> points;
  ArrayList<PVector> selectedPoints = new ArrayList<PVector>();
  ArrayList<Polygon> polygons = new ArrayList<Polygon>();
  ArrayList<Node> nodes = new ArrayList<Node>();
  Triangle canvas;


  Voronoi() {
    canvas = getBiggestTriangle();
  }

  ArrayList<Node> getNodes() {
    return nodes;
  }

  void setDatas(ArrayList<Triangle> triangles, ArrayList<PVector> points) {
    this.triangles = triangles;
    this.points = points;
  }

  void solve() {
    nodes = new ArrayList<Node>();
    for (Triangle t : triangles) {
      if (isInScreen(t.circum.center)) {
        nodes.add(new Node(t.circum.center));
      }
    }
    for (PVector p : points) {
      Polygon poly = joinCircumAroundPoint(p);
      if (poly != null) {
        //if(poly.isInScreenAll()){
        //  tryAddNodeAll(nodes, poly.vertices);
        //}
        polygons.add(poly);
        poly.mkLink(nodes);
      }
    }
    //for (Triangle t : triangles) {
    //  Node node = getNodeByPos(t.circum.center, nodes);
    //  if(node != null){
    //    Triangle ta = getTriangleSharingEdge(t, t.AB, triangles, false);
    //    if (ta != null) {
    //      Node na = getNodeByPos(ta.circum.center, nodes);
    //      if(na != null){
    //        node.tryAddLink(na);
    //        na.tryAddLink(node);
    //      }
    //    }
    //    Triangle tb = getTriangleSharingEdge(t, t.BC, triangles, false);
    //    if (tb != null) {
    //      Node nb = getNodeByPos(tb.circum.center, nodes);
    //      if(nb != null){
    //        node.tryAddLink(nb);
    //        nb.tryAddLink(node);
    //      }
    //    }
    //    Triangle tc = getTriangleSharingEdge(t, t.CA, triangles, false);
    //    if (tc != null) {
    //      Node nc = getNodeByPos(tc.circum.center, nodes);
    //      if(nc != null){
    //        node.tryAddLink(nc);
    //        nc.tryAddLink(node);
    //      }
    //    }
    //  }
    //}
  }

  Polygon joinCircumAroundPoint(PVector p) {
    ArrayList<Triangle> containTriangles = getTrianglesContainPoint(p);
    Polygon poly = findLinkedPolygon(p);
    if (poly == null) {
      poly = new Polygon(p);
    } else {
      poly.resetVertex();
    }
    Triangle start = containTriangles.get(0);
    Edge prevEdge = start.getEdgeContainPoint(p).get(0);
    Triangle current = getTriangleSharingEdge(start, prevEdge, containTriangles, true);
    poly.addVertex(start.circum.center);
    while (current != null && !current.isSameT(start)) {//find triangle around point
      poly.addVertex(current.circum.center);
      Edge e = current.getEdgeContainPointOppositeEdge(p, prevEdge);
      current = getTriangleSharingEdge(current, e, containTriangles, true);
    }
    return poly;
  }

  void show(boolean full) {
    for (Polygon poly : polygons) {
      if (poly.isInScreenAll() || full) {
        poly.show();
      }
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
}