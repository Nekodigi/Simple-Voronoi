float baseColor = 0;

int heurType = 1;
int dispType = 1;
boolean full = true;
DelaunayTriangulation delaunay;
Voronoi voronoi;
Node current;
Node end;
ArrayList<Node> openSet = new ArrayList<Node>();
ArrayList<Node> closedSet = new ArrayList<Node>();
ArrayList<Node> path = new ArrayList<Node>();
boolean solving = false;

void setup(){
  //size(600, 600, P3D);//because P3D is fast
  fullScreen(P3D);
  colorMode(HSB, 360, 100, 100, 100);
  baseColor = random(0, 360);
  delaunay = new DelaunayTriangulation();
  voronoi = new Voronoi();
}

void draw(){
  background(360);
  //noFill();
  //stroke(255);
  strokeWeight(1);
  noStroke();
  ArrayList<Triangle> triangles = delaunay.getTriangles(true);
  ArrayList<PVector> points = delaunay.getPoints(false);
  if(dispType == 0){
    delaunay.show(full);
    if(points.size()>0){
      ArrayList<Node> nodes = delaunay.getNodes();
      if(solving == true){
        A_Star();
        current.show(color(0, 100, 100));
        end.show(color(150, 100, 100));
      }else{
        strokeWeight(5);
        current = nodes.get(0);
        end = nodes.get(nodes.size()-1);
        current.show(color(0, 100, 100));
        end.show(color(150, 100, 100));
        strokeWeight(1);
      }
      showPath();
    }
  }
  if(dispType == 1){
    voronoi.setDatas(triangles, points);
    voronoi.solve();
    voronoi.show(full);//slow
    ArrayList<Node> nodes = voronoi.getNodes();
    for(Node node : nodes){
      node.show();
    }
    if(nodes.size()>0){
      if(solving == true){
        A_Star();
        current.show(color(0, 100, 100));
        end.show(color(150, 100, 100));
      }else{
        strokeWeight(5);
        current = nodes.get(0);
        end = nodes.get(nodes.size()-1);
        current.show(color(0, 100, 100));
        end.show(color(150, 100, 100));
        strokeWeight(1);
      }
    }
    showPath();
  }
  if(dispType == 2){
    fill(0);
    for(PVector p : points){
      ellipse(p.x, p.y, 10, 10);
    }
  }
}

void mousePressed(){
  if(mouseButton == LEFT){
    delaunay.addPoint(mouseX, mouseY);
  }
}

void keyPressed(){
  if(key == 'r'){
    path = new ArrayList<Node>();
    baseColor = random(0, 360);
    delaunay = new DelaunayTriangulation();
    voronoi = new Voronoi();
  }
  if (key == 'd'){
    dispType++;
    if(dispType >= 2){
      dispType = 0;
    }
  }
  if(key == 's'){
    openSet = new ArrayList<Node>();
    closedSet = new ArrayList<Node>();
    openSet.add(current);
    solving = true;
  }
  if(key == 'f'){
    full = !full;
  }
}