\l mm.q

/ An Optimal Mastermind (4,7) Strategy and More Results in the Expected Case
/ by Geoffroy Ville
/ https://arxiv.org/pdf/1305.1010

/ Yet Another Mastermind Strategy
/ by Barteld Kooi
/ www.philos.rug.nl/~barteld/master.pdf

/ Mastermind
/ by Tom Davis
/ www.geometer.org/mathcircles/mastermind.pdf

/ https://rkoutnik.com/Mastermind/

/ http://colorcode.laebisch.com/links/Donald.E.Knuth.pdf
/ http://colorcode.laebisch.com/

C:`u#.mm.perm[4] 6#.Q.n / 4x6 (C)odes (w repeat)
G:("0000";"0001";"0011";"0012";"0123") / unique first (G)uesses
S:flip (where;raze til each)@\: 5 4 3 1 1 / (S)cores
/.mm.score:{x[y;z]}C!C!/:C .mm.score/:\: C
\
show T:([]score:S)!flip (`$G)!(count'')(G .mm.dist\: C)@\:S
/ simple: start with 0000
/ minimiax: start with 0011
T upsert (1 2#0N),value max T
/ expected size: start with 0012
("f"$T) upsert (1 2#0N),value T wavg T
/ (information theoretic) entropy: start with 0123
("f"$T) upsert (1 2#0N),value .mm.entropy each flip value T
/ most parts: start with 0012
T upsert (1 2#0N),value sum 0<T

.mm.hist d:(count .mm.game[.mm.simple;C;"0000"]@) peach C
.mm.hist a:(count .mm.game[.mm.onestep[`.mm.minimax];C;"0011"]@) peach C
.mm.hist c:(count .mm.game[.mm.onestep[`.mm.irving];C;"0012"]@) peach C
.mm.hist b:(count .mm.game[.mm.onestep[`.mm.maxent];C;"0123"]@) peach C
.mm.hist e:(count .mm.game[.mm.onestep[`.mm.maxparts];C;"0012"]@) peach C

.mm.summary each .mm.game[.mm.simple;C;"0000"] rand C
.mm.summary each .mm.game[.mm.onestep[`.mm.minimax];C;"0011"] rand C
.mm.summary each .mm.game[.mm.onestep[`.mm.irving];C;"0012"] rand C
.mm.summary each .mm.game[.mm.onestep[`.mm.maxent];C;"0123"] rand C
.mm.summary each .mm.game[.mm.onestep[`.mm.maxparts];C;"0012"] rand C

.mm.summary each .mm.game[.mm.stdin[.mm.onestep[`.mm.minimax]];C;"0011"] rand C
.mm.summary each .mm.game[.mm.stdin[.mm.onestep[`.mm.maxparts]];C;"    "] rand C
.mm.summary each .mm.game[.mm.stdin[.mm.simple];C;"    "] rand C

c:"ROYGPABW"             / Red Orange Yellow Green Pink grAy Blue White
CG:(C;C:.mm.perm[-4] c)   / 4x8 Codes (no repeat)
f:.mm.best[`.mm.maxparts]
.mm.summary each .mm.game[.mm.onestep[`.mm.maxparts];C;"BRAY"] "AROB"
f . CG:(.mm.filt . CG)["BRAY";1 2]
f . CG:(.mm.filt . CG)["ROAB";1 3]
f . CG:(.mm.filt . CG)["ORYB";2 1]
f . CG:(.mm.filt . CG)["AROB";4 0]

c:"GBWURY"             / Green Black White blUe Red Yellow
CG:(C;C:`u#.mm.perm[4] c)
f . CG:(.mm.filt . CG)["    ";0 0]
f . CG:(.mm.filt . CG)["GGBW";0 1]
f . CG:(.mm.filt . CG)["BUUR";1 2]
f . CG:(.mm.filt . CG)["BRYU";1 1]
f . CG:(.mm.filt . CG)["WURU";1 1]
f . CG:(.mm.filt . CG)["UBUU";4 0]
