class Edge{
  PVector A;
  PVector B;
  
  Edge(PVector A, PVector B){
    this.A = A;
    this.B = B;
  }
  
  boolean isSameE(Edge e){
    return isSame(A, e.A) && isSame(B, e.B) || isSame(B, e.A) && isSame(A, e.B);
  }
}