class Edge{
  Vertex A;
  Vertex B;
  
  Edge(Vertex A, Vertex B){
    this.A = A;
    this.B = B;
  }
  
  boolean isSameE(Edge e){
    return A.id == e.A.id && B.id == e.B.id || B.id == e.A.id && A.id == e.B.id;
  }
}