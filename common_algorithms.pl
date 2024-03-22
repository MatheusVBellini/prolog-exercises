/* Prolog Implementation of Common Algorithms */

% test graph
connected(a,b). connected(b,d).
connected(d,i). connected(a,c).
connected(c,e). connected(e,g).
connected(e,h). connected(c,f).
end(i). end(f).

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

% concat(List1,List2,Result_list).
concat([],L,L).
concat([X|Xs],L,[X|Ys]) :-
  concat(Xs,L,Ys).

% extend(Current_path, Extended_path).
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
  
