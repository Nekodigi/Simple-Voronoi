float heuristic(Node a, Node b){
  switch(heurType){
    case 0:
      return (a.pos.x-b.pos.x) * (a.pos.x-b.pos.x) + (a.pos.y-b.pos.y) * (a.pos.y-b.pos.y);
    case 1:
      return dist(a.pos.x, a.pos.y, b.pos.x, b.pos.y);
    case 2:
      return abs(a.pos.x-b.pos.x) + abs(a.pos.y-b.pos.y);
    default:
      return 1;
  }
}

boolean isInScreen(PVector p){
  return p.x>0 && p.x<width && p.y>0 && p.y<height;
}

void showPath(){
  stroke(0, 100, 100, 100);
  strokeWeight(20);
  noFill();
  beginShape();
  for(Node node : path){
    vertex(node.pos.x, node.pos.y);
  }
  endShape();
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

public PVector Cross(PVector A, PVector B, PVector C)
{
    //return ABxBC
    PVector AB = PVector.sub(A, B);
    PVector BC = PVector.sub(B, C);
    return AB.cross(BC);
}

public boolean isSame(PVector A, PVector B){
  return A.x==B.x&&A.y==B.y;
}

public boolean isAboutSame(PVector A, PVector B){
  return abs((A.x-B.x)+(A.y-B.y))<0.01;
}

Node getNodeByPos(PVector p, ArrayList<Node> nodes){
  for(Node node : nodes){
    if(isAboutSame(p, node.pos)){
      return node;
    }
  }
  return null;
}

Triangle getTriangleSharingEdge(Triangle ABC, Edge AB, ArrayList<Triangle> triangles, boolean remove)//similar Delaunay's method
{
  Triangle ADB = null;//仮置
  PVector A = AB.A;
  PVector B = AB.B;
  for (int i = 0; i < triangles.size(); i++)
  {
    Triangle t = triangles.get(i);
    if (t.isContains(AB) && !t.isSameT(ABC))
    {
      PVector D = t.getOppositeVertex(AB);
      if(remove){
        triangles.remove(i);
      }
      ADB = new Triangle(A, D, B);
      break;
    }
  }
  return ADB;
}

ArrayList<Node> getAroundNodes(PVector p, ArrayList<Triangle> triangles, ArrayList<Node> nodes){
  ArrayList<Node> result = new ArrayList<Node>();
  for(Triangle t : triangles){
    if(t.isVertexContains(p)){
      Edge AB = t.getOppositeEdge(p);
      if(isInScreen(AB.A)){
        tryAddList(result, getNodeByPos(AB.A, nodes));
      }
      if(isInScreen(AB.B)){
        tryAddList(result, getNodeByPos(AB.B, nodes));
      }
    }
  }
  return result;
}

void tryAddNodeAll(ArrayList<Node> list, ArrayList<PVector> target){
  for(PVector n : target){
    tryAddList(list, new Node(n));
  }
}

void tryAddList(ArrayList<Node> list, Node n){
  boolean contain = false;
  for(Node item : list){
    if(isSame(item.pos, n.pos)){
      contain = true;
    }
  }
  if(contain == false){
    list.add(n);
  }
}