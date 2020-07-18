public PVector Cross(Vertex A, Vertex B, Vertex C)
{
    //return ABxBC
    PVector AB = PVector.sub(A.pv(), B.pv());
    PVector BC = PVector.sub(B.pv(), C.pv());
    return AB.cross(BC);
}