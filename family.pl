%Write a Prolog program that defines a simple family tree and lets you query multiple family relationships like:
% parent
% father / mother
% sibling
% grandparent
% uncle / aunt
% cousin

%facts
male(john).
male(liam).
male(terry).
male(salmon).
female(cassie).
female(maddie).
female(rue).
female(jenny).

parent(john,cassie).
parent(maddie,liam).
parent(rue,john).
parent(salmon,maddie).
parent(salmon,jenny).
parent(maddie,cassie).

%relationship
father(X,Y):-male(X),parent(X,Y).
mother(X,Y):-female(X),parent(X,Y).

sibling(X,Y):-parent(Z,X),parent(Z,Y),X\=Y.
brother(X,Y):-male(X),sibling(X,Y).
sister(X,Y):-female(X),sibling(X,Y).

grandparent(X,Y):-parent(X,Z),parent(Z,Y).
grandpa(X,Y):-male(X),grandparent(X,Y).
grandma(X,Y):-female(X),grandparent(X,Y).

uncle(X,Y):-brother(X,Z),parent(Z,Y).
aunt(X,Y):-sister(X,Z),parent(Z,Y).
cousin(X,Y):-parent(M,X),parent(N,Y),sibling(M,N),X\=Y.