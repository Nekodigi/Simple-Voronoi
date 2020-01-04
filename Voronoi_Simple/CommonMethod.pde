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