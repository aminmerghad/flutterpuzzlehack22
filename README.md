# puzzle

## How we built it.
**1)- the main objective**

The main objective is to exploiting flutter rendering algorithm, which increase the performance by moving puzzle pieces without rebuild or repaint all pieces.

Other features was added by exploring this algorithm like :

1-controlling the size of the puzzle pieces and the plan according to the screen width;

2-In the first animation (shuffle animation) .we don't repaint all puzzles during this animation;

**2)- additional features**

1)- painting flutter logo:

-when the puzzles pieces are in there ideal position and complete flutter logo will be shown. 

- Flutter Logo is painted by lines that has start and end. The intersection ( between the puzzle piece sides and this lines ) is added to map (the key is index puzzle piece and the value is a list of two offset of the intersection the represente the start point and the end point ).


2)- Move animation  :

-it's depend on taping and it's composed of two part. The first part is when it's 40% of the animation , the box will double his size from his offset to the next position, then the size decrease ( for the second part ) intitle the piece take the next position.

3)- shuffle animation :

-animate the appearance of puzzle pieces in their random position is according to a curved line of 45 degree ,that pass from (0,0) to the end ( Offset(500,500) ).

-The distance of puzzles from the the topLeft and bottumRight accoding to the painting line are calculated and transformed to parcentage. this two parcentage represente the start and the end of painting of each box.

-Each puzzle start painting when the percentage of the animation between the parcentage of the topLeft and the BottumRight, which make it synchronised with other boxes
