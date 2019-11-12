% Contest II: 1995 Portland, USA 
% 3. Powers 

/* Write a predicate powers/3, which is called with as first argument a list of strictly
positive integers, as second argument a strictly positive integer N, and a free third
argument. Such a call must succeed exactly once and unify the third argument
with the list that contains the smallest N integers (in ascending order) that are
a positive (non-zero) power of one of the elements of the first argument.*/

powers(Factors,N,Powers) :-
      sort(Factors,SFactors), % sorts the list of factors from the smallest to the largest
      % construct the list of pairs which are sorted  
      pair(SFactors,Pairs),              % return example [(2,2),(3,3),(5,5)] 
      first_powers(N,Pairs,Powers).
  
pair([],[]).
pair([X|R],[(X,X)|S]) :- pair(R,S).         % return example [(2,2),(3,3),(5,5)]
                                            % which is sorted and which has no two pairs

first_powers(N,[(Power,Factor)|PFs],[Power|Powers]) :-
    /*
      In a pair (P,F), P is the smallest power of F that
      is not in the solution list yet. So, the first component of the first element of the
      pair-list is the next element in the output we are constructing.
    */
            
      ( N == 1 ->
          Powers = []
      ;
          N1 is N - 1,
          remove_power(Power,PFs,PFs1),  % We remove this pair, compute the next power of F (i.e. P*F)
          Power1 is Power * Factor,  % and insert the pair (P*F,F) into the pair-list, respecting the invariants.
          sorted_insert(PFs1,(Power1,Factor),PFs2),
          first_powers(N1,PFs2,Powers)
        ).
        
remove_power(Power,PFsIn,PFsOut) :-  
     /* 
         Remove pairs without taking the F-component of the pairs.not generating
         duplicates in the output, and also without reducing the pair-list
     */
     
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
