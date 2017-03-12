perm:{{raze x{x,/:y except x}\:y}[;y]/[x-1;y]}
score:{[g;c]                    / (g)uess, (c)ode
 w:where not e:c=g;             / (e)xact
 i:{x _ x ? y}/[c w;g w];       / (i)ncorrect
 ("j"$sum e;count[w]-count i)}
filt:{[G;s;g]G where (s~score[g]@) each G} / (G)uesses, (s)core, (g)uess
pick:{[f;S;G] / (f)unction, (S)et of unused records, logical (G)uesses
 if[1=count G;:first G];        / only 1 left
 if[count G:G inter S@:where f (group G score\:) each S;:first G]; / trim G with f
 first S} / as a last resort, pick first unused record
turn:{[f;c;SGg]           / (f)unction, (c)ode, SGg
 if[count[g]=first s:score[g:SGg 2;c];:SGg]; / winning solution
 g:pick[f;S _: (S:SGg 0)?g] G:filt[SGg 1;s;g]; / pick next guess based on score
 (S;G;g)}
game:{[f;S;g;c]turn[f;c] scan (S;S;g)}

/ algorithms
simple:{enlist 1b}                             / simple case
mparts:{x=max x:count each x}                  / most parts
msize:{x=min x:(max count each) each x}        / min max size (knuth)
esize:{x=min x:({x wavg x} count each) each x} / min expected size
entropy:{x=min x:({sum x*2 xlog x%:sum x} count each) each x} / max entropy

\
/ An Optimal Mastermind (4,7) Strategy and More Results in the Expected Case
/ Geoffroy Ville
/ https://arxiv.org/pdf/1305.1010

S:cross/[4#enlist til 6]        / 4x6 Set (w/ repeat)
a:(count game[`simple;S;0 0 0 0]@0N!) peach 50?S
b:(count game[`msize;S;0 0 1 1]@0N!) peach 50?S
c:(count game[`esize;S;0 0 1 2]@0N!) peach 50?S
d:(count game[`entropy;S;0 1 2 3]@0N!) peach 50?S
e:(count game[`mparts;S;0 0 1 2]@0N!) peach 50?S
last last a:game[`msize;S;0 0 1 1] 0N! S 10
last last a:game[`simple;S;0 0 1 1] 0N! S 10
last last a:game[`msize;S;0 0 1 1] 0N!rand S
last last a:game[`msize;S;0 0 1 1] 0N!0 2 3 1

c:"ROYGPABW"             / Red Orange Yello Green Pink grAy Blue White
P:flip (where;raze til each)@\: 5 4 3 1 1 / peg combinations
S:perm[4] c                               / 4x8 Set (no repeat)
pick[`mparts;S] G:filt[S;1 2;"BRAY"]
pick[`mparts;S] G:filt[G;1 3;"ROAB"]
pick[`mparts;S] G:filt[G;2 1;"ORYB"]
pick[`mparts;S] G:filt[G;4 0;"AROB"]

