class DelaunayTriangulation {
  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<Triangle> triangles = new ArrayList<Triangle>();
  Triangle canvas;
  ArrayList<Node> nodes = new ArrayList<Node>();

  DelaunayTriangulation() {
    canvas = getBiggestTriangle();
    triangles.add(canvas);
  }

  void addPoint(float x, float y) {
    addPoint(new PVector(x, y));
  }

  void addPoint(PVector p) {
    nodes.add(new Node(p));
    points.add(p);
    solve(p);
  }

  ArrayList<Triangle> getTriangles() {
    return getTriangles(false);
  }

  ArrayList<Node> getNodes() {
    for (PVector p : points) {
      ArrayList<Node> Tnodes = getAroundNodes(p, triangles, nodes);
      Node node = getNodeByPos(p, nodes);
      node.replaceLinks(Tnodes);
    }
    return nodes;
  }

  ArrayList<PVector> getPoints(boolean containCanvas) {
    ArrayList<PVector> result = new ArrayList<PVector>();
    for (PVector p : points) {
      if (canvas.isVertexContains(p)) {
        if (containCanvas) {
          result.add(p);
        }
      } else {
        result.add(p);
      }
    }
    return result;
  }

  ArrayList<Triangle> getTriangles(boolean containCanvas) {
    ArrayList<Triangle> result = new ArrayList<Triangle>();
    for (Triangle t : triangles) {
      if (!t.isSharingPoint(canvas) || containCanvas) {
        result.add(t);
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
      Triangle ADB = getTriangleSharingEdge(ABP, AB, triangles, true);//remove found item from triangles
      if (ADB == null || ABP.isSameT(ADB)) {
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

  ArrayList<Triangle> flip(Triangle ADB, Edge AB, PVector p) {
    ArrayList<Triangle> result = new ArrayList<Triangle>();
    PVector D = ADB.getOppositeVertex(AB);
    result.add(new Triangle(AB.A, D, p));
    result.add(new Triangle(AB.B, D, p));
    return result;
  }

  void show(boolean containCanvas) {
    for (Triangle t : triangles) {
      if (!t.isSharingPoint(canvas) || containCanvas) {
        t.show();
      }
    }
  }

  Triangle getTriangleContainsOf(PVector p) {
    for (Triangle t : triangles) {
      if (t.isContains(p)) {
        return t;
      }
    }
    return null;
  }
}