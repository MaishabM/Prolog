sum(0,0).

sum(N,Finres):- N>0,
    N1 is N-1,
    sum(N1,Subres),
    Finres is Subres+N.