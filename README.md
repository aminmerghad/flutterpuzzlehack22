# puzzle

## How we built it.
**1)- the main objective**

the main objective of mean is the performance by moving puzzle peaces without rebuild all piaces. by using rendering algorithms of flutter for bulding puzzle plan and puzzle pieces ( LeafRenderObjectWidget  & MultiChildRenderObjectWidget ) i had a deep controle of this mean objective and other second useful features like :

-controlling the size of the puzzle pieces and the plan according to the screen width;

-the first animation (shuffle animation) don't repaint all puzzles during the move of the line;

-the change of mouse when it entre or exist;

**2)- adding additional features**

1)- painting flutter logo:

-when the puzzles pieces are in there ideal position an complte flutter logo will be shown 

- the flutter Logo is painted by lines that has start and end. the intersection between the puzzle piece side and the line is added to map (the key is the puzzle piece index and the value is a list of two offset of the intersection)

-the flutter logo is painted on the pieces according to there index

2)- Move animation  :

-it's depend on the tap

-it's composed of two part ;

-the first is when 40% of the animation ; the box double his size from his offset two the next position then the size decrease intitle the piece take the next position.

3)- shuffle animation :

-The painting of puzzles in there randam position is according to a line from (0,0) to the end ( Offset(500,500) ) and it's parallel to a line that pass (forme 0,125 to 125,125).

-The distance of puzzles from the the topLeft and bottumRight accoding to the painting line are calculated and transformed to parcentage.

-Each puzzle start painting when the percentage of the animation between the topLeft and the BottumRight which make an synchronisation with other boxes
