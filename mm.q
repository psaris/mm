\d .mm
/ drop the first instance of y in x
drop:{x _ x ? y}
/ vectorize an atomic function
veca:{[f;x;y]$[type x;$[type y;f[x;y];x f/: y];type y;x f\: y;x f/:\: y]}
/ x,y = score,guess in any order
scr:{(e;count[x]-(e:"j"$sum x=y)+count x drop/ y)}
score:veca scr

/ unused (C)odes, viable (G)uesses, next (g)uess, (s)core
filt:{[C;G;g;s](drop[C;g];G where s~/:score[g;G])}
/ frequency distribution
freq:count each group@
hist:freq asc@

/ distribution of (S)cores over all (C)odes for each (G)uess
scoredist:{[S;C;G]([]score:S)!flip (`$G)!(freq each score[G;C])@\:S}

/ algorithms
simple:{[CGgs]CG,1#last CG:filt . CGgs}

/ one step algos
/ use (f)unction to filter all unpicked (C)odes for best split
/ pick a solution from viable (G)uesses (if possible)
best:{[f;C;G]first $[3>count G;G;count G:G inter C@:where f freq each score[C;G];G;C]}
entropy:{neg sum x*2 xlog x%:sum x}
onestep:{[f;CGgs] CG,enlist best[f] . CG:filt . CGgs}
minimax:{x=min x:max each x}       / min max size (knuth)
irving:{x=min x:{x wavg x} each x} / min expected size
maxent:{x=max x:entropy each x}    / max entropy
maxparts:{x=max x:count each x}    / most parts

/ interactive
guess:{[g] 1"guess (HINT ",g,"): ";read0 0}
stdin:{[a;CGgs]show enlist summary CGgs;@[a CGgs;2;guess]}

/ play
perm:{$[x>0;(cross/)x#enlist y;{raze x{x,/:y except x}\:y}[;y]/[-1-x;y]]}
turn:{[a;c;CGgs] CGg,enlist score[c]last CGg:a CGgs}
game:{[a;C;g;c](not count[g]=first last@) turn[a;c]\ (C;C;g;score[c;g])}

/ report
summary:{[CGgs]`n`guess`score!(count CGgs 1),-2#CGgs}
