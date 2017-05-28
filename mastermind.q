\l mm.q
\c 20 200

/ An Optimal Mastermind (4,7) Strategy and More Results in the Expected Case
/ Geoffroy Ville
/ https://arxiv.org/pdf/1305.1010

/ Yet Another Mastermind Strategy
/ Barteld Kooi

C:`u#(cross/)4 6#6#.Q.n / 4x6 Codes (w/ repeat)
G:("0000";"0001";"0011";"0012";"0123") / unique first Guesses
S:flip (where;raze til each)@\: 5 4 3 1 1 / Scores
/.mm.score:{x[y;z]}C!C!/:C .mm.score/:\: C
\
show T:([]score:S)!flip D:(`$G)!@\:[;S](count'') G .mm.dist \: C
/ simple: start with 0000
/ worst case: start with 0011
@[T;1 2#0N;:;] max each D
/ expected size: start with 0012
@["f"$T;1 2#0N;:;] D wavg' D
/ (information theoretic) entropy: start with 0123
/ not best.  but what if entropy
/ measure changed base depending on partition size
@["f"$T;1 2#0N;:;].mm.entropy each D
/ most parts: start with 0012
@[T;1 2#0N;:;] sum each 0<D

\ts .mm.hist c:(count .mm.game[.mm.algo[`.mm.esize];C;"0012"]@) peach C
.mm.hist b:(count .mm.game[.mm.algo[`.mm.msize];C;"0011"]@) peach C

a:(count .mm.game[.mm.algo[`.mm.simple];C;"0000"]@) each 50?C
b:(count .mm.game[.mm.algo[`.mm.msize];C;"0011"]@) each 50?C
.mm.hist c:(count .mm.game[.mm.algo[`.mm.esize];C;"0012"]@) each 50?C
.mm.hist d:(count .mm.game[.mm.algo[`.mm.ment];C;"0123"]@) each 50?C
.mm.hist e:(count .mm.game[.mm.algo[`.mm.mparts];C;"0012"]@) each 50?C
.mm.summary each .mm.game[.mm.algo[`.mm.simple];C;"0000"] C 10
.mm.summary each .mm.game[.mm.algo[`.mm.msize];C;"0011"] C 10
.mm.summary each .mm.game[.mm.algo[`.mm.esize];C;"0012"] C 10
.mm.summary each .mm.game[.mm.algo[`.mm.ment];C;"0123"] C 10
.mm.summary each .mm.game[.mm.algo[`.mm.msize];C;"0011"] rand C
.mm.summary each .mm.game[.mm.algo[`.mm.msize];C;"0011"] "0231"
.mm.summary each .mm.game[.mm.stdin[`.mm.esize];C;"0011"] rand C
.mm.summary each .mm.game[.mm.stdin[`.mm.msize];C;"    "] rand C

c:"ROYGPABW"             / Red Orange Yellow Green Pink grAy Blue White
CG:(C;C:.mm.perm[4] c)   / 4x8 Codes (no repeat)
.mm.summary each .mm.game[.mm.algo[`.mm.mparts];C;"BRAY"] "AROB"
.mm.best[`.mm.mparts] . CG:(.mm.filt . CG)["BRAY";1 2]
.mm.best[`.mm.mparts] . CG:(.mm.filt . CG)["ROAB";1 3]
.mm.best[`.mm.mparts] . CG:(.mm.filt . CG)["ORYB";2 1]
.mm.best[`.mm.mparts] . CG:(.mm.filt . CG)["AROB";4 0]
