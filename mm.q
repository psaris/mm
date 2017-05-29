\d .mm
cache:()
perm:{{raze x{x,/:y except x}\:y}[;y]/[x-1;y]}
drop:{x _ x ? y}                / drop the first instance of y in x
score:{[c;g](e;count[c]-(e:"j"$sum c=g)+count c drop/ g)}
dist:{[c;G]group c score/: G}
/ unused (C)odes, (G)uesses, (s)core, (g)uess
filt:{[C;G;g;s](drop[C;g];G where s~/:g score/:G)}
/ (f)unction, unused (C)odes, logical (G)uesses
/ filter all unpicked (c)odes for best split
/ guess a viable solution from (G) if possible
best:{[f;C;G]$[3>count G;G;count G:G inter C@: where f C dist\: G;G;C]}
algo:{[f;CGgs] CG,1#best[f] . CG:filt . CGgs}
turn:{[a;c;CGgs] CGg,enlist score[c]last CGg:a CGgs}
game:{[a;C;g;c](not count[g]=first last@) turn[a;c]\ (C;C;g;score[c;g])}
summary:{[CGgs]`n`guess`score!(count CGgs 1),-2#CGgs}
hist:count each group asc@
/ algorithms
simple:{enlist 1b}                             / simple case
maxparts:{x=max x:count each x}                / most parts
minimax:{x=min x:(max count each) each x}      / min max size (knuth)
irving:{x=min x:({x wavg x} count each) each x} / min expected size
entropy:{neg sum x*2 xlog x%:sum x}
maxent:{x=max x:(entropy count each) each x} / max entropy

guess:{[g] -1"guess? HINT: ",g;read0 0}
stdin:{[f;CGgs]show enlist summary CGgs;@[algo[f] CGgs;2;guess]}
