public boolean IsSharingPoint(Triangle A, Triangle B)
{
    return  IsEqual(A.A, B.A) || IsEqual(A.A, B.B)|| IsEqual(A.A, B.C)||
            IsEqual(A.B, B.A) || IsEqual(A.B, B.B)|| IsEqual(A.B, B.C)||
            IsEqual(A.C, B.A) || IsEqual(A.C, B.B)|| IsEqual(A.C, B.C);
}