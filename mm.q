\d .mm

perm:{{raze x{x,/:y except x}\:y}[;y]/[x-1;y]}
drop:{x _ x ? y}                / drop the first instance of y in x
score:{[c;g]("j"$sum e;count[w]-count drop/[c w;g w:where not e:c=g])}
dist:{[c;G]group c score/: G}
/ (S)et, (G)uesses, (s)core, (g)uess
filt:{[S;G;g;s](drop[S;g];G where s~/:g score/:G)}
/ (f)unction, (S)et of unused records, logical (G)uesses
/ filter all unpicked codes (S) for best split
/ guess a viable solution from (G) if possible
pick:{[f;S;G]first $[1=count G;G;count G:G inter S@:where f S dist\: G;G;S]}
algo:{[f;SGgs] SG,enlist pick[f] . SG:filt . SGgs}
turn:{[a;c;SGgs] SGg,enlist score[c]last SGg:a SGgs}
game:{[a;S;g;c](not count[g]=first last@) turn[a;c]\ (S;S;g;score[c;g])}
summary:{[SGgs]`n`guess`score!(count SGgs 1),-2#SGgs}
hist:count each group asc@
/ algorithms
simple:{enlist 1b}                             / simple case
mparts:{x=max x:count each x}                  / most parts
msize:{x=min x:(max count each) each x}        / min max size (knuth)
esize:{x=min x:({x wavg x} count each) each x} / min expected size
entropy:{x=min x:({sum x*2 xlog x%:sum x} count each) each x} / max entropy

guess:{[SG] -1"guess? HINT: ",-3!SG 1;read0 0}
stdin:{[SGgs]show enlist summary SGgs;SG,enlist guess SG:filt . SGgs}
