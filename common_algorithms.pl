/* Prolog Implementation of Common Algorithms */

% (1)
% Depth-First Search

% belongs(-Node,-Path)
belongs(N,[N|_]) :- !.
belongs(N,[_|T]) :- belongs(N,T).

% dfs(-InitialNode,-FinalNode,+Path).
dfs(I,F,Path) :-
  use_dfs(I,[F],Path).
  use_dfs(I,[I|CompletePath],[I|CompletePath]).
  use_dfs(I,[N|CurrentPath],Path) :-
    connected(NewN,N),
    \+ belongs(NewN,CurrentPath),
    use_dfs(I,[NewN,N|CurrentPath],Path).



% (2)
% Breadth-First Search

% concat(-List1,-List2,+Result_list).
concat([],L,L).
concat([X|Xs],L,[X|Ys]) :-
  concat(Xs,L,Ys).

% extend(-Current_path,+Extended_path).
extend([N|Path],ExtendedPaths) :-
  findall([Ns,N|Path], connected(N,Ns), ExtendedPaths).

% use_bfs(-Final_node,-List_of_paths,+Path).
use_bfs(F,[[F|CompletePath]|_],[F|CompletePath]).
use_bfs(F,[CurrPath|OtherPaths],Path) :-
  extend(CurrPath,ExtendedPaths),
  concat(OtherPaths,ExtendedPaths,NewList),
  use_bfs(F,NewList,Path).

% bfs(-Initial_node,-Final_node,+Path).
bfs(I,F,Path) :-
  use_bfs(F,[[I]],Path).
  


% (3)
% Quick-Sort (first element as pivot)

% partition(-Pivot,-List_without_pivot,+Left_partition,+Right_partition).
partition(_,[],[],[]).
partition(Pivot,[X|Xs],[X|Left],Right) :-
  X =< Pivot,
  partition(Pivot,Xs,Left,Right).
partition(Pivot,[X|Xs],Left,[X|Right]) :-
  X > Pivot,
  partition(Pivot,Xs,Left,Right).

% quicksort(-List,+Sorted_list).
quicksort([],[]).
quicksort([Pivot|Rest],Sorted) :-
  partition(Pivot,Rest,Left,Right),
  quicksort(Right,RightSorted),
  quicksort(Left,LeftSorted),
  concat(LeftSorted,[Pivot|RightSorted],Sorted).



% (4)
% Merge-Sort

% split(-List,+First,+Second).
split([],[],[]).
split([X],[X],[]).
split([HeadFirst,HeadSecond|Tail],[HeadFirst|First],[HeadSecond|Second]) :-
  split(Tail,First,Second).

% ordered_assemble(-First,-Second,+OrderedList)
ordered_assemble(L,[],L).
ordered_assemble([],L,L).
ordered_assemble([Head1|Tail1],[Head2|Tail2],[Head1|OrderedList]) :-
  Head1 =< Head2,
  ordered_assemble(Tail1,[Head2|Tail2],OrderedList).
ordered_assemble([Head1|Tail1],[Head2|Tail2],[Head2|OrderedList]) :-
  Head1 > Head2,
  ordered_assemble([Head1|Tail1],Tail2,OrderedList).

% mergesort(-List,+SortedList).
mergesort([],[]) :- !.
mergesort([X],[X]) :- !.
mergesort(List,SortedList) :-
  split(List,First,Second),
  mergesort(First,SortedFirst),
  mergesort(Second,SortedSecond),
  ordered_assemble(SortedFirst,SortedSecond,SortedList).
