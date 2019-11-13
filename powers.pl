%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Contest II: 1995 Portland, USA 
% 3. Powers 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
                                            % in a recursive way takes the head and tail of the list
                                            % and gets the pair and continues with the rest

first_powers(N,[(Power,Factor)|PFs],[Power|Powers]) :-
    /*
      In a pair (P,F), P is the smallest power of F that
      is not in the solution list yet.
    */      
      ( N == 1 ->  % condition for the program if N is set to 1 return an empty list
          Powers = []
      ; 
      
       N1 is N - 1,  
     /*
      In a pair (P,F), P is the smallest power of F that
      is not in the solution list yet.
    */  
     /* So the first component of the first element of the
         pair-list is the next element in the output we are constructing */
         
         
          remove_power(Power,PFs,PFs1),    % We remove this pair compute the next power of F (i.e. P*F)
          Power1 is Power * Factor,        % and insert the pair (P*F,F) into the pair-list respecting the invariants
          sorted_insert(PFs1,(Power1,Factor),PFs2), % sort again the elemetns 
          first_powers(N1,PFs2,Powers)  % compute the rest in a recursive form
        ).
        
remove_power(Power,PFsIn,PFsOut) :-  
     /* 
         Remove pairs without taking the F-component of the pairs.not generating
         duplicates in the output, and also without reducing the pair-list
         recursively
     */
     
       ( PFsIn = [(Power,_)|RestPFsIn] -> 
           remove_power(Power,RestPFsIn,PFsOut)
          ;
           PFsOut = PFsIn 
          ).
  
sorted_insert([],X,[X]).
sorted_insert([A|R],X,Out) :-       
        ( A @< X ->   % check if the head is smaller than the inserted element 
            Out = [A|RestOut],  % if that is the case take the head of the list 
            sorted_insert(R,X,RestOut) % continues with the algorith recursively
        ;    
            Out = [X,A|R]  % returns the list with the Power1 and factor as head and the rest of the tail.
        ).
  
  /* 
  Code retrieved from:
  The First 10 Prolog Programming Contests (2005), by Demoen, B; Nguyen, P; Schrijvers, T; Troncon R.
  */
