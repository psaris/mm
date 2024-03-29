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

-1 "generate a complete list of patterns";
count C:`u#.mm.perm[4] "123456" / 4x6 (C)odes (w repeat)
-1 "generate the list of unique first (G)uesses";
show G:("1111";"1112";"1122";"1123";"1234")
-1 "generate the list of unique scores";
show flip (where;raze til each)@\: 5 4 3 1 1
-1 "given the frequency distribution of first guesses, which should we pick?";
show T:.mm.freqt[G;C]
-1 "we can start simple. pick the next logic code: 1111";
-1 "or we can pick the code that minimizes the maximum remaining codes: 1122";
show asc max T
-1 "or we can pick the code that minimizes the expected remaining codes: 1123";
show asc T wavg T
-1 "or we can pick the code the maximizes the entropy: 1234"; / information theoretic
show desc .mm.entropy each flip value T
-1 "or we can pick the code the maximizes the gini coefficient: 1123";
show desc .mm.gini each flip value T
-1 "or why not pick a code that results in a distribution with the most parts: 1123";
show desc sum 0<T

-1 "lets play a single game for each strategy";
-1 "simple";
G:C
show .mm.summary each .mm.game[.mm.simple;G;C;"1111"] rand C
-1 "minimax (knuth: always wins in 5 or less guesses)";
show .mm.summary each .mm.game[.mm.onestep[`.mm.minimax];G;C;"1122"] rand C
-1 "irving (min expectation)";
show .mm.summary each .mm.game[.mm.onestep[`.mm.irving];G;C;"1123"] rand C
-1 "maximum entropy (information theoretic)";
show .mm.summary each .mm.game[.mm.onestep[`.mm.maxent];G;C;"1234"] rand C
-1 "maximum parts (the smallest expected number of guesses)";
show .mm.summary each .mm.game[.mm.onestep[`.mm.maxparts];G;C;"1123"] rand C

-1 "master mind comes in other variations - including one with 8 colors";
-1 "to narrow the universe of solutions, it does not allow repeats";
-1 "we also can generate this universe with .mm.perm";
-1 "like the ? operator, passing a negative operand prevents repeats";

/ grAy Blue Green Orange Pink Red White Yellow
count C:G:.mm.perm[-4] "ABGOPRWY"  / 4x8 Codes (no repeat)
-1 "now lets assume we don't know the code, but would like help on choosing codes";
-1 "we first generate 'GC': the list of valid Guesses and unused Codes";
GC:(G;C)
-1 "next we define our algorithm and use .mm.best to suggest the next code";
f:.mm.best[`.mm.maxparts]
-1 "with no repeats, there is no 'best' first guess";
-1 "we pick: ABGO, and pass the code maker's response";
f . GC:.mm.filt . GC,("ABGO";1 2)
f . GC:.mm.filt . GC,("AGBP";1 1)
f . GC:.mm.filt . GC,("AORB";2 2)
f . GC:.mm.filt . GC,("AROB";4 0)
-1 "solution in 4 guesses!";
-1 "replay the optimal game";
show .mm.summary each .mm.game[.mm.onestep[`.mm.maxparts];G;C;"ABGO"] "AROB"
-1 "lets play a game against the computer!";
show .mm.summary each .mm.game[.mm.stdin[.mm.onestep[`.mm.maxent]];G;C;"ABGO"] rand C

\
/ convert .mm.score into a cache
.mm.score:.mm.scr/:[;C!C] peach G!G

/ generate a histogram of guess counts for each strategy
.mm.hist a:(count .mm.game[.mm.simple;G;C;"1111"]::) peach C
.mm.hist b:(count .mm.game[.mm.onestep[`.mm.minimax];G;C;"1122"]::) peach C
.mm.hist c:(count .mm.game[.mm.onestep[`.mm.irving];G;C;"1123"]::) peach C
.mm.hist d:(count .mm.game[.mm.onestep[`.mm.maxent];G;C;"1234"]::) peach C
.mm.hist e:(count .mm.game[.mm.onestep[`.mm.maxparts];G;C;"1123"]::) peach C
show D:`turns xcol .mm.freqdist[`simple`minimax`irving`maxent`maxparts] (a;b;c;d;e)
show ("f"$D) upsert 0N,value[flip value D] wavg\: key[D]`turns


count C:G:`u#.mm.perm[-4] "ABGOPRWY"  / 4x8 Codes (no repeat)
.mm.score:.mm.scr/:[;C!C] peach G!G
/ all first guesses are the same
show .mm.freqt[G;C]
.mm.hist (count .mm.game[.mm.simple;G;C;"ABGO"]::) peach C
.mm.hist (count .mm.game[.mm.onestep[`.mm.minimax];G;C;"ABGO"]::) peach C
.mm.hist (count .mm.game[.mm.onestep[`.mm.irving];G;C;"ABGO"]::) peach C
.mm.hist (count .mm.game[.mm.onestep[`.mm.maxent];G;C;"ABGO"]::) peach C
.mm.hist (count .mm.game[.mm.onestep[`.mm.maxparts];G;C;"ABGO"]::) peach C
.mm.hist (count .mm.game[.mm.onestep[`.mm.maxgini];G;C;"ABGO"]::) peach C
