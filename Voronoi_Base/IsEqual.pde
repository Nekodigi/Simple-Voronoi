public boolean IsEqual(Triangle A, Triangle B)
{
    return  (IsEqual(A.AB, B.AB) || IsEqual(A.AB, B.BC) || IsEqual(A.AB, B.CA))&&
            (IsEqual(A.BC, B.AB) || IsEqual(A.BC, B.BC) || IsEqual(A.BC, B.CA));
}


public boolean IsEqual(Edge A,Edge B)
{
    return  (IsEqual(A.start, B.start) && IsEqual(A.end, B.end))||
            (IsEqual(A.start, B.end) && IsEqual(A.end, B.start));
}

public boolean IsEqual(PVector A,PVector B)
{
    return (A.x == B.x)&&(A.y == B.y);
}