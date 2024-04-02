/* Prolog Implementation of Common Algorithms */

% (1)
% Depth-First Search

% belongs(-Node,-Path)
belongs(N,[N|_]) :- !.
belongs(N,[_|T]) :- belongs(N,T).

% dfs(-Initial_node, -Final_node, +Path).
dfs(I,F,Path) :-
  back_dfs(I,[F],Path).
  back_dfs(I,[I|CompletePath],[I|CompletePath]).
  back_dfs(I,[LastState|CurrentPath],Path) :-
    connected(State,LastState),
    \+ belongs(State,CurrentPath),
    back_dfs(I, [State,LastState|CurrentPath], Path).



% (2)
% Breadth-First Search

% concat(-List1,-List2,+Result_list).
concat([],L,L).
concat([X|Xs],L,[X|Ys]) :-
  concat(Xs,L,Ys).

% extend(-Current_path, +Extended_path).
extend([N|P],Ps) :-
  findall(
    [nN,N|P], 
    (connected(N,nN),\+ belongs(nN,[N|P])),
    Ps
  ).

% use_bfs(-List_of_paths, +Path).
use_bfs([[N|Path]|_],[N|Path]) :- end(N).
use_bfs([Path|OtherPaths],Ans) :-
  extend(Path,NewPaths),
  concat(OtherPaths,NewPaths,ConcatPaths),
  use_bfs(ConcatPaths,Ans).

% bfs(-Node,+Path)
bfs(N,Path) :-
  use_bfs([[N]],Path).
  


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
