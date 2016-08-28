perm:{{raze x{x,/:y except x}\:y}[;y]/[x-1;y]}
score:{[c;g]("j"$sum e;count[w]-count {x _ x ? y}/[c w;g w:where not e:c=g])} / (c)ode, (g)uess
filt:{[G;s;g]G where s~/:G score\: g}   / (G)uesses, (s)core, (g)uess
simple:{enlist 1}                       / simple case
wcase:{x=min x:(max count each) each x} / worst case
esize:{x=min x:({x wavg x} count each) each x} / expected size
entropy:{x=min x:({sum p*2 xlog p:x%sum x} count each) each x} / max entropy
mparts:{x=max x:count each x}   / most parts
pick:{[f;S;G]first $[1=count G;G;count G:G inter S@:where f group each S score/:\: G;G;S]}
turn:{[f;c;SGg]$[4 0~s:score[c;g:SGg 2];SGg;(S _ S?g;G;pick[f;S:SGg 0] G:filt[SGg 1;s;g])]}
game:{[f;S;g;c]turn[f;c] scan (S;S;g)}
\

S:cross/[4#enlist til 6]                  / 4x6 Set (w/ repeat)
a:(count game[`simple;S;0 0 0 0]@) peach S
b:(count game[`wcase;S;0 0 1 1]@) peach S
c:(count game[`esize;S;0 0 1 2]@) peach S
d:(count game[`entropy;S;0 1 2 3]@) peach S
e:(count game[`mparts;S;0 0 1 2]@) peach S
last last a:game[`wcase;S;0 0 1 1] 0N! S 10
last last a:game[`wcase;S;0 0 1 1] 0N!rand S
last last a:game[`wcase;S;0 0 1 1] 0N!0 2 3 1

c:"ROYGPABW"             / Red Orange Yello Green Pink grAy Blue White
P:flip (where;raze til each)@\: 5 4 3 1 1 / peg combinations
S:perm[4] c                               / 4x8 Set (no repeat)
pick[`mparts;S] G:filt[S;1 2;"BRAY"]
pick[`mparts;S] G:filt[G;1 3;"ROAB"]
pick[`mparts;S] G:filt[G;2 1;"ORYB"]
pick[`mparts;S] G:filt[G;4 0;"AROB"]

