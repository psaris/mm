# A Q Implementation of the Classic Mastermind Game

Clone this project and start q with the following command to see q
brief introduction to different solutions to the mastermind game.

`q mastermind.q`

## Code Selection

The classic game of mastermind has the code maker choose 4 colors
(with repeats) from a total of 6 colors.  Other versions have been
sold that increase the universe to 8 colors, but attempt to keep the
complexity the same by not allowing repeated colors.  A full list of
the variations can be found on the [mastermind wiki][variations].

[variations]:https://en.wikipedia.org/wiki/Mastermind_(board_game)#Variations

Our firs task, then, is to define the set of possible codes.  The
`.mm.perm` function allows us generate permutations with (or without)
repeat by passing a positive (or negative) parameter.

```
q)count C:`u#.mm.perm[4] "123456"
1296
```

## Algorithm Selection

We can then choose an algorithm (say Knuth's minimax algorithm that is
guaranteed to win in 5 moves) and an initial guess "1122", and we can
see how the algorithm performs:

```
q)show .mm.summary each .mm.game[.mm.onestep[`.mm.minimax];C;"1122"] rand C
n    guess  score
-----------------
1296 "1122" 1 0  
256  "1344" 0 2  
41   "3135" 1 0  
6    "3426" 1 3  
1    "6432" 4 0  

```

After starting with 1296 possibilities, it quickly narrowed the
choices down to 256, then to 41, 6 and finally found the answer on 5th
guess.

The list of possible algorithms are:

- .mm.minimax (Knuth's algorithm)
- .mm.irving (minimum expected size)
- .mm.maxent (maximum entropy)
- .mm.maxparts (most parts)

## Interactive Play

Alternatively, we can play the game interactively (passing in an
algorithm so it can give us a hint at the best answer).

```
q)show .mm.summary each .mm.game[.mm.stdin[.mm.onestep[`.mm.maxent]];C;"1122"] rand C
n    guess  score
-----------------
1296 "1122" 0 1  
guess (HINT 2345): 2345
n   guess  score
----------------
256 "2345" 0 1  
guess (HINT 3616): 3616
n  guess  score
---------------
27 "3616" 2 2  
guess (HINT 3661): 3661
n guess  score
--------------
2 "3661" 1 3  
guess (HINT 6613): 6613
n    guess  score
-----------------
1296 "1122" 0 1  
256  "2345" 0 1  
27   "3616" 2 2  
2    "3661" 1 3  
1    "6613" 4 0  
```

## Exhaustive Play

We can see the performance of each algorithm by using it on every
possible code and generating a histogram of how many turns each game
took.

To speed things up, we can convert the `.mm.score` function into a
cache:

```
q).mm.score:C!C!/:C .mm.scr\:/: C
```

We can then use `peach` to run the games in parallel:

```
q).mm.hist (count .mm.game[.mm.onestep[`.mm.minimax];C;"1122"]@) peach C
1| 1
2| 6
3| 62
4| 533
5| 694
```

We have just shown that Knuth's algorithm does indeed win in 5 moves
or less.
