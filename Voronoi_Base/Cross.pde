public PVector Cross(PVector A, PVector B, PVector C)
{
    //return ABxBC
    PVector AB = PVector.sub(A, B);
    PVector BC = PVector.sub(B, C);
    return AB.cross(BC);
}