class Triangle{
  Vertex A;
  Vertex B;
  Vertex C;
  Edge AB;
  Edge BC;
  Edge CA;
  Vertex circumC;///CircumscribedCircle
  float circumR;
  
  Triangle(Vertex A, Vertex B, Vertex C){
    this.A = A;
    this.B = B;
    this.C = C;
    AB = new Edge(A, B);
    BC = new Edge(B, C);
    CA = new Edge(C, A);
    calcCircum();
  }
  
  Triangle(Edge AB, Vertex C){
    this(AB.A, AB.B, C);
  }
  
  void show(){
    triangle(A.x, A.y, B.x, B.y, C.x, C.y);
  }
  
  boolean isSameT(Triangle t){//The triangle is same if 2 edge is same 
    return (AB.isSameE(t.AB) || AB.isSameE(t.BC) || AB.isSameE(t.CA))&&
           (BC.isSameE(t.AB) || BC.isSameE(t.BC) || BC.isSameE(t.CA));
  }
  
  boolean isCircumContains(Vertex p){
    return PVector.dist(circumC.pv(), p.pv()) < circumR;
  }
  
  boolean isContains(Vertex p)
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
    return  A.id == t.A.id || A.id == t.B.id|| A.id == t.C.id||
            B.id == t.A.id || B.id == t.B.id|| B.id == t.C.id||
            C.id == t.A.id || C.id == t.B.id|| C.id == t.C.id;
  }
  
  Edge getOppositeEdge(Vertex p){
    if(p.id == A.id){
      return BC;
    }else if(p.id == B.id){
      return CA;
    }else if(p.id == C.id){
      return AB;
    }
    throw new IllegalArgumentException("getOppositeEdge ERROR");
  }
  
  Vertex getOppositeVertex(Edge e){
    if(e.isSameE(AB)){
      return C;
    }else if(e.isSameE(BC)){
      return A;
    }else if(e.isSameE(CA)){
      return B;
    }
    throw new IllegalArgumentException("getOppositeVertex ERROR");
  }
  
  Triangle copy(){
    return new Triangle(A, B, C);
  }
  
  void calcCircum(){
    float c = 2.0 * ((B.x - A.x) * (C.y - A.y) - (B.y - A.y) * (C.x - A.x));//temp Value
    float x = ((C.y - A.y) * (B.x * B.x - A.x * A.x + B.y * B.y - A.y * A.y)+(A.y - B.y) * (C.x * C.x - A.x * A.x + C.y * C.y - A.y * A.y))/c;
    float y = ((A.x - C.x) * (B.x * B.x - A.x * A.x + B.y * B.y - A.y * A.y)+(B.x - A.x) * (C.x * C.x - A.x * A.x + C.y * C.y - A.y * A.y))/c;

    circumC = new Vertex(x, y);
    circumR = PVector.dist(circumC.pv(), A.pv());
  }
}