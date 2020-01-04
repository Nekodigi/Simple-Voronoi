class Triangle{
  PVector A;
  PVector B;
  PVector C;
  Edge AB;
  Edge BC;
  Edge CA;
  Circle circum;///CircumscribedCircle
  color col;
  
  Triangle(PVector A, PVector B, PVector C){
    this.A = A;
    this.B = B;
    this.C = C;
    AB = new Edge(A, B);
    BC = new Edge(B, C);
    CA = new Edge(C, A);
    col = color(baseColor, random(0, 100), 100);
    getCircum();
  }
  
  Triangle(Edge AB, PVector C){
    this(AB.A, AB.B, C);
  }
  
  void show(){
    show(col);
  }
  
  void show(color col){
    fill(col);
    triangle(A.x, A.y, B.x, B.y, C.x, C.y);
  }
  
  boolean isInScreenAll(){
    return isInScreen(A) && isInScreen(B) && isInScreen(C);
  }
  
  boolean isSameT(Triangle t){//The triangle is same if 2 edge is same 
    return (AB.isSameE(t.AB) || AB.isSameE(t.BC) || AB.isSameE(t.CA))&&
           (BC.isSameE(t.AB) || BC.isSameE(t.BC) || BC.isSameE(t.CA));
  }
  
  boolean isCircumContains(PVector p){
    return circum.isContain(p);
  }
  
  boolean isVertexContains(PVector p){
    return isSame(A, p) || isSame(B, p) || isSame(C, p);
  }
  
  boolean isContains(PVector p)
  {
      //AB x BP, BC x CP, CA x AP
      PVector ABxBP = Cross(A, B , p);
      PVector BCxCP = Cross(B, C , p);
      PVector CAxAP = Cross(C, A , p);
  
      return (ABxBP.z >=0 && BCxCP.z >=0 && CAxAP.z>=0) || (ABxBP.z <=0 && BCxCP.z <=0 && CAxAP.z<=0);
  }
  
  boolean isContains(Edge e){
    return e.isSameE(AB) || e.isSameE(BC) || e.isSameE(CA);
  }
  
  public boolean isSharingPoint(Triangle t)
  {
    return  isSame(A, t.A) || isSame(A, t.B)|| isSame(A, t.C)||
            isSame(B, t.A) || isSame(B, t.B)|| isSame(B, t.C)||
            isSame(C, t.A) || isSame(C, t.B)|| isSame(C, t.C);
  }
  
  boolean isSharingEdge(Triangle t)
  {
    return  AB.isSameE(t.AB) || AB.isSameE(t.BC)|| AB.isSameE(t.CA)||
            BC.isSameE(t.AB) || BC.isSameE(t.BC)|| BC.isSameE(t.CA)||
            CA.isSameE(t.AB) || CA.isSameE(t.BC)|| CA.isSameE(t.CA);
  }
  
  ArrayList<Edge> getEdgeContainPoint(PVector p){
    ArrayList<Edge> result = new ArrayList<Edge>();
    if(AB.isContain(p)){
      result.add(AB);
    }
    if(BC.isContain(p)){
      result.add(BC);
    }
    if(CA.isContain(p)){
      result.add(CA);
    }
    return result;
  }
  
  Edge getEdgeContainPointOppositeEdge(PVector p, Edge e){
    if(!e.isSameE(AB) && AB.isContain(p)){
      return AB;
    }
    if(!e.isSameE(BC) && BC.isContain(p)){
      return BC;
    }
    if(!e.isSameE(CA) && CA.isContain(p)){
      return CA;
    }
    return null;
  }
  
  Edge getOppositeEdge(PVector p){
    if(isSame(p, A)){
      return BC;
    }else if(isSame(p, B)){
      return CA;
    }else if(isSame(p, C)){
      return AB;
    }
    return null;
  }
  
  PVector getOppositeVertex(Edge e){
    if(e.isSameE(AB)){
      return C;
    }else if(e.isSameE(BC)){
      return A;
    }else if(e.isSameE(CA)){
      return B;
    }
    return null;
  }
  
  Triangle copy(){
    return new Triangle(A, B, C);
  }
  
  Circle getCircum(){
    float c = 2.0 * ((B.x - A.x) * (C.y - A.y) - (B.y - A.y) * (C.x - A.x));//temp Value
    float x = ((C.y - A.y) * (B.x * B.x - A.x * A.x + B.y * B.y - A.y * A.y)+(A.y - B.y) * (C.x * C.x - A.x * A.x + C.y * C.y - A.y * A.y))/c;
    float y = ((A.x - C.x) * (B.x * B.x - A.x * A.x + B.y * B.y - A.y * A.y)+(B.x - A.x) * (C.x * C.x - A.x * A.x + C.y * C.y - A.y * A.y))/c;

    PVector center = new PVector(x, y);
    float r = PVector.dist(center, A);
    circum = new Circle(center, r);
    return circum;
  }
}