/* Write a predicate powers/3, which is called with as first argument a list of strictly
positive integers, as second argument a strictly positive integer N, and a free third
argument. Such a call must succeed exactly once and unify the third argument
with the list that contains the smallest N integers (in ascending order) that are
a positive (non-zero) power of one of the elements of the first argument.*/

powers(Factors,N,Powers) :-
      sort(Factors,SFactors),
      pair(SFactors,Pairs),
      first_powers(N,Pairs,Powers).
  
pair([],[]).
pair([X|R],[(X,X)|S]) :- pair(R,S).

first_powers(N,[(Power,Factor)|PFs],[Power|Powers]) :-
      ( N == 1 ->
          Powers = []
      ;
          N1 is N - 1,
          remove_power(Power,PFs,PFs1),
          Power1 is Power * Factor,
          sorted_insert(PFs1,(Power1,Factor),PFs2),
          first_powers(N1,PFs2,Powers)
        ).
        
remove_power(Power,PFsIn,PFsOut) :-
       ( PFsIn = [(Power,_)|RestPFsIn] ->
           remove_power(Power,RestPFsIn,PFsOut)
          ;
           PFsOut = PFsIn
          ).
  
sorted_insert([],X,[X]).
sorted_insert([A|R],X,Out) :-
        ( A @< X ->
            Out = [A|RestOut],
            sorted_insert(R,X,RestOut)
        ;
            Out = [X,A|R]
        ).
