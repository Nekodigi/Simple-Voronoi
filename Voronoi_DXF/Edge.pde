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
  
  boolean isContain(PVector p){
    return isSame(A, p) || isSame(B, p);
  }
  
  PVector getOppositeVertex(PVector p){
    if(isSame(A, p)){
      return B;
    } else if(isSame(B, p)){
      return A;
    }
    return null;
  }
  
  void getEdgeSharingPoint(){
    
  }
  
  void show(){
    line(A.x, A.y, B.x, B.y);
  }
}