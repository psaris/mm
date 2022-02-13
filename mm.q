\d .mm
/ drop the first instance of y in x
drop:{x _ x ? y}
/ vectorize an atomic function
veca:{[f;x;y]$[type x;$[type y;f[x;y];f[x] peach y];type y;f[;y] peach x;(x f\:) peach y]}
/ (c)ode, (g)uess
scr:{[c;g](e;count[c]-(e:"j"$sum c=g)+count c drop/ g)}
score:veca scr

/ unused (C)odes, viable (G)uesses, next (g)uess, (s)core
filt:{[C;G;g;s](drop[C;g];G where s~/:score[G;g])}

freq:count each group::         / frequency distribution
hist:freq asc::                 / histogram

/ compute the frequency distribution of x with (c)olumn names
freqdist:{[c;x]([]x:u)!flip c!freq'[x]@\:u:asc (union/) x}
/ generate a frequency table
freqt:{[C;G]`score xcol freqdist[`$G] score[C;G]}

/ algorithms
simple:{[CGgs]CG,1#last CG:filt . CGgs}

/ one step algos
/ use (f)unction to filter all unpicked (C)odes for best split
/ pick a solution from viable (G)uesses (if possible)
best:{[f;C;G]first $[3>count G;G;count G:G inter C@:where f (freq score[;G]::) peach C;G;C]}
entropy:{neg sum x*log x%:sum x}
gini:{1f-sum x*x%:sum x}
onestep:{[f;CGgs] CG,enlist best[f] . CG:filt . CGgs}
minimax:{x=min x:max each x}       / min max size (knuth)
irving:{x=min x:{x wavg x} each x} / min expected size
maxent:{x=max x:entropy each x}    / max entropy
maxgini:{x=max x:gini each x}      / max gini
maxparts:{x=max x:count each x}    / most parts

/ interactive
guess:{[g] 1"guess (HINT ",g,"): ";read0 0}
stdin:{[a;CGgs]show enlist summary CGgs;@[a CGgs;2;guess]}

/ play
perm:{$[x>0;(cross/)x#enlist y;{raze x{x,/:y except x}\:y}[;y]/[-1-x;y]]}
turn:{[a;c;CGgs] CGg,enlist score[c]last CGg:a CGgs}
/ (a)lgorithm, (C)odes, valid (G)uesses, (g)uess, (c)ode
game:{[a;C;G;g;c](not score[c;c]~last::) turn[a;c]\ (C;G;g;score[c;g])}

/ report
summary:{[CGgs]`n`guess`score!(count (inter/) 2#CGgs),-2#CGgs}
