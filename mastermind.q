/ Red Orange Yello Green
/ Pink grAy Blue White
c:"ROYGPABW"
P:flip (where;raze til each)@\: 5 4 3 1 1 / peg combination

perm:{{raze x{x,/:y except x}\:y}[;y]/[x-1;y]}
/comb:{{raze x{x,/:y where y>max x}\:y}[;y]/[x-1;y]}
/k)perm:{x{,/(>:'t=/:t:*x)@\:x:0,'1+x}/,!0}    /permutations
/k)perm:{$[x=1;,,y;,/n,/:'(x-1).z.s'y-n:!1+y]}
score:{[c;g]("j"$sum e;count[w]-count {x _ x ? y}/[c w;g w:where not e:c=g])} / (c)ode, (g)uess
filt:{[G;s;g]G where s~/:G score\: g}   /(G)uesses, (s)core, (g)uess
simple:{enlist 1}                       / simple case
wcase:{x=min x:(max count each) each x} / worst case
mparts:{x=max x:count each x}           / most parts
pick:{[f;S;G]first $[1=count G;G;count G:G inter S@:where f group each S score/:\: G;G;S]}
play:{[f;c;SGg]$[1=count G:SGg 1;SGg;4 0~sc:score[c;g:SGg 2];SGg;(S _ S?g;G;pick[f;S:SGg 0] G:filt[G;sc;g])]}
game:{[f;S;g;c]play[f;c] scan (S;S;g)}
\
S:perm[4] til count c
S:cross/[4#enlist til 6]
show each (count;last) @\:a:game[`wcase;S;0 0 1 1] rand g:S
score[c:S 40;g:0 1 0 5]
a:(count game[`wcase;S;0 0 1 1]@) peach S
a:(count game[`mparts;S;0 0 1 2]@) peach S
a:(count game[`simple;S;0 0 0 0]@) peach S
\ts a:(count game[`wcase;S]@) peach 100#S
last last a:game[`wcase;S;0 0 1 1] 0N! S 10
last last a:game[`wcase;S;0 0 1 1] 0N!rand S
last last a:game[`wcase;S;0 0 1 1] 0N!0 2 3 1
a:game[`wcase;S] 0N!S 85

b:S score\:/: S
count G:filt[G;1 2i;6 0 5 2]

count G:filt[G;1 2i;"BRAY"]
count G:filt[G;1 3i;"ROAB"]
count G:filt[G;4 0i;"AROB"]

