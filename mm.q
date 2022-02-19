\d .mm
/ drop the first instance of y in x
drop:{x _ x ? y}
/ vectorize an atomic function
veca:{[f;x;y]$[type x;$[type y;f[x;y];f[x] peach y];type y;f[;y] peach x;f/:[;y] peach x]}
/ (g)uess, (c)ode
scr:{[g;c](e;count[c]-(e:"j"$sum c=g)+count c drop/ g)}
score:veca scr

/ unused (G)uesses, viable (C)odes, next (g)uess, (s)core
filt:{[G;C;g;s](drop[G;g];C where s~/:score[g;C])}

freq:count each group::         / frequency distribution
hist:freq asc::                 / histogram

/ compute the frequency distribution of x with (c)olumn names
freqdist:{[c;x]([]x:u)!flip c!freq'[x]@\:u:asc (union/) x}
/ generate a frequency table
freqt:{[G;C]`score xcol freqdist[`$G] score[G;C]}

/ algorithms
simple:{[GCgs]GC,1#last GC:filt . GCgs}

/ one step algos
/ use (f)unction to analyze all unused (G)uesses for best distribution.
/ pick from viable (C)odes (if possible)
best:{[f;G;C]first $[3>count C;C;count C:C inter G@:where f freq each score[G;C];C;G]}
entropy:{neg sum x*log x%:sum x}
gini:{1f-sum x*x%:sum x}
onestep:{[f;GCgs] GC,enlist best[f] . GC:filt . GCgs}
minimax:{x=min x:max each x}       / min max size (knuth)
irving:{x=min x:{x wavg x} each x} / min expected size
maxent:{x=max x:entropy each x}    / max entropy
maxgini:{x=max x:gini each x}      / max gini
maxparts:{x=max x:count each x}    / most parts

/ interactive
guess:{[g] 1"guess (HINT ",g,"): ";read0 0}
stdin:{[a;GCgs]show enlist summary GCgs;@[a GCgs;2;guess]}

/ play
perm:{$[x>0;(cross/)x#enlist y;{raze x{x,/:y except x}\:y}[;y]/[-1-x;y]]}
turn:{[a;c;GCgs] GCg,enlist score[;c]last GCg:a GCgs}
/ (a)lgorithm, valid (G)uesses, (C)odes, (g)uess, (c)ode
game:{[a;G;C;g;c](not score[c;c]~last::) turn[a;c]\ (G;C;g;score[g;c])}

/ report
summary:{[GCgs]`n`guess`score!(count (inter/) 2#GCgs),-2#GCgs}
