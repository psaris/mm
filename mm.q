\d .mm
cache:()
perm:{{raze x{x,/:y except x}\:y}[;y]/[x-1;y]}
drop:{x _ x ? y}                / drop the first instance of y in x
score:{[c;g]("j"$sum e;count[w]-count drop/[c w;g w:where not e:c=g])}
dist:{[c;G]group c score/: G}
/ unused (C)odes, (G)uesses, (s)core, (g)uess
filt:{[C;G;g;s](drop[C;g];G where s~/:g score/:G)}
/ (f)unction, unused (C)odes, logical (G)uesses
/ filter all unpicked (c)odes for best split
/ guess a viable solution from (G) if possible
best:{[f;C;G]C idesc (C@: f C dist\: G) in G}
algo:{[f;CGgs] CG,1#best[f] . CG:filt . CGgs}
turn:{[a;c;CGgs] CGg,enlist score[c]last CGg:a CGgs}
game:{[a;C;g;c](not count[g]=first last@) turn[a;c]\ (C;C;g;score[c;g])}
summary:{[CGgs]`n`guess`score!(count CGgs 1),-2#CGgs}
hist:count each group asc@
/ algorithms
simple:{til count x}                        / simple case
mparts:{idesc count each x}                 / most parts
msize:{iasc (max count each) each x}        / min max size (knuth)
esize:{iasc ({x wavg x} count each) each x} / min expected size
entropy:{neg sum x*2 xlog x%:sum x}         / entropy
ment:{idesc (entropy count each) each x}    / max entropy

guess:{[C] -1"guess? HINT: ",-3!C;read0 0}
stdin:{[f;CGgs]show enlist summary CGgs;CG,enlist guess best[f] . CG:filt . CGgs}
