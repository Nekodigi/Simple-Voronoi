class Polygon {
  PVector origin;
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  color col;

  Polygon(PVector origin) {
    this.origin = origin;
    col = color(baseColor, random(0, 100), 100);
  }

  void resetVertex() {
    vertices = new ArrayList<PVector>();
  }

  void addVertex(PVector p) {
    vertices.add(p);
  }

  boolean isInScreenAll() {
    for (PVector p : vertices) {
      if (!isInScreen(p)) {
        return false;
      }
    }
    return true;
  }

  void mkLink(ArrayList<Node> nodes) {
    for (int i = 0; i < vertices.size(); i++) {
      Node na = getNodeByPos(vertices.get(i), nodes);
      Node nb = getNodeByPos(vertices.get((i+1)%vertices.size()), nodes);
      if (na != null && nb != null) {
        na.tryAddLink(nb);
        nb.tryAddLink(na);
      }
    }
  }

  void show() {
    fill(col);
    beginShape();
    for (int i = 0; i < vertices.size(); i++) {
      PVector p = vertices.get(i);
      vertex(p.x, p.y);
    }
    endShape();
  }
}