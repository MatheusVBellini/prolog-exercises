/* List Exercises */

% (1)
% Last element of a list
% last(-List,?Last_element).
last([X|[]],X).

% (2)
% Second to last element of a list
% penultimate(-List,?Penultimate_element).
penultimate([X|[_|[]]],X).
penultimate([_|T],X) :- penultimate(T,X).

% (3)
% Kth element of a list
% find(-List,-Index,?Element).
find([X|_],0,X).
find([_|T],I,X) :-
  I > 0,
  J is I - 1,
  find(T,J,X).

% (4)
% Find size of list
% size(-List,?Size).
size([],0).
size([_|[]],1).
size([_|T],X) :-
  size(T,X1),
  X is X1 + 1.

% (5)
% Reverse a list
% reverse(-List,?Reversed_list).
reverse([],[]).
reverse([H|[]],[H|[]]).
reverse([H|T],[HR|_]) :- 
  reverse(T,[H,HR|_]).

% (6)
% Verify if a list is palindrome
% palindrome(-List).
palindrome(X) :- reverse(X,X).

% (7)
% Flatten nested list
% flatten(-List,+Flat_list).
flatten([],[]).
flatten([X],X).
flatten([H|T],[H,Y]) :-
  flatten(T,Y).

% (8)
% Eliminate consecutive duplicates
% compress(-List,+Compressed_list).
compress([],[]).
compress([X],[X]).
compress([X,X|T],Y) :-
  compress([X|T],Y).
compress([X,Z|T],[X|Y]) :-
  Z \= X,
  compress([Z|T],Y).

% (9)
% Pack consecutive duplicates into sublists
% pack(-List,+Packed_list).
pack([],[]).
pack([X],[X]).
pack([X,X|Xs],Zs) :-
  pack([[X,X]|Xs],Zs), !.
pack([[X|W],X|Xs],Zs) :-
  pack([[X,X|W]|Xs],Zs).
pack([X,Y|Xs],[X|Zs]) :-
  X \= Y,
  pack([Y|Xs],Zs).













