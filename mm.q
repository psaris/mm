\d .mm
/ drop the first instance of y in x
drop:{x _ x ? y}
/ (c)ode, (g)uess
score:{[c;g]e,count[c]-(e:"j"$sum c=g)+count c drop/ g}
/ unused (C)odes, viable (G)uesses, next (g)uess, (s)core
filt:{[C;G;g;s](drop[C;g];G where s~/:g score/:G)}

/ algorithms
simple:{[CGgs]CG,1#last CG:filt . CGgs}

/ one step algos
dist:{[c;G]group c score/: G}
/ use (f)unction to filter all unpicked (C)odes for best split. pick a
/ viable solution from viable (G)uesses if possible
best:{[f;C;G]first $[3>count G;G;count G:G inter C@: where f C dist\: G;G;C]}
onestep:{[f;CGgs] CG,enlist best[f] . CG:filt . CGgs}
minimax:{x=min x:(max count each) each x}       / min max size (knuth)
irving:{x=min x:({x wavg x} count each) each x} / min expected size
entropy:{neg sum x*2 xlog x%:sum x}
maxent:{x=max x:(entropy count each) each x} / max entropy
maxparts:{x=max x:count each x}              / most parts

/ interactive
guess:{[g] -1"guess? HINT: ",g;read0 0}
stdin:{[a;CGgs]show enlist summary CGgs;@[a CGgs;2;guess]}

/ play
perm:{$[x>0;(cross/)x#enlist y;{raze x{x,/:y except x}\:y}[;y]/[-1-x;y]]}
turn:{[a;c;CGgs] CGg,enlist score[c]last CGg:a CGgs}
fgame:{[a;C;g;c](not count[g]=first last@) turn[a;c]\ (C;C;g;score[c;g])}

/ report
summary:{[CGgs]`n`guess`score!(count CGgs 1),-2#CGgs}
hist:count each group asc@
