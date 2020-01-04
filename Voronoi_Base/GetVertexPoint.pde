public PVector GetVertexPoint(Triangle triangle, Edge edge)
{
    if(IsEqual(edge, triangle.AB))
    {
        return triangle.C;
    }
    else if(IsEqual(edge, triangle.BC))
    {
        return triangle.A;
    }
    else
    {
        return triangle.B;
    }
}