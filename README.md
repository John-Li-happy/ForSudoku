# ForSudoku
ForSudoku is an open source sandbox game based on logical placement of numbers.

## Discription
A game designed for killing time when user feels boring. In the old days, it could always been found on newspaper entertainment section. This game was inspired while the developer owned sleeping issues, this game helped the developer went into sleep very soon.

 - For beginners, there are three rules of sudoku
 + Any row contains one of each number from 1 to 9;
 + Any colume contains one of each number from 1 to 9;
 + Any 3 * 3 grid contains one of each number from 1 to 9;
![download](https://user-images.githubusercontent.com/63318597/116277582-9d699a80-a753-11eb-8ea7-8d48a9acb08b.jpeg)


## Logic History
### First Logic: Random to Fit
Step 1: Random numbers array *rowA* could been generated based on *rule 1*(row). In *rowA* there are no repeated digits;

Step 2: Then repeat *Step 1* 9 times, a 9 * 9 matrix *MatrixA* is generated.

Step 3: Check *MatrixA* is adaptable with *rule3*. If not, go back to *Step 1*

For this logic it takes a lot redundant time of checking *rule 3* adapation (avarage 600 billion iterations). For the first valid matrix, spends me 6 hours. Then I move to the second one

### Second Logic: Create and Shuffle 
Step 1: Random numbers array *rowA* could been generated based on *rule 1*(row). In *rowA* there are no repeated digits; 

Then shift *rowA* to 3 cells right, make *rowB*; shift *rowB* 3 cells right, make *rowC*
 
Step 2: Shuffle and populate first three digit from *rowA* to *rowD*, and repeat three times, to make complete row. 

The same logic happens in the rest of the rows. Then, *matrixA* will be estaplished.

Step 3: Divide *matrixA* into 3 clomun blocks, and shuffle clolumes in each block.

For this logic, there is still a pattern of the digits, especially for the attached ones. For playing it is fine, but as a developer there must be a better way. Then I move to the third one

### Third Logic: Back Tracing
Step 1: Create and fill in diagonal sectors with random numbers, following *rule 3*

Step 2: Fill in the rest cells from start, by using *Brute Forth Algrithom*. Its basic idea is to create *state space trees* and traverse all possible solution; if its not working, then the *pencel mark* will go back to previous *chosen state*[1][2]. 

## Techniques
 + Model-View-ViewModel(MVVM)
 + CoreData
 + Delegation
 + Observation
 + UIkit

## IDE
Xcode 12.1 

Swift 5.3

Better experience with iPhone 8(4.7 inch) or larger devices 

## Todos
In sudoku puzzle solving, players always has to make decisions when there are multiple choices avaliable. To reduce the branches of *state tree*, it is easier for player if the solution of sudoku puzzle is unique. Meanwhile, this new soluton could not generate severe time issues.[3]

## References
1. [Generating Sudoku Puzzles as an Inverse Problem.pdf](https://github.com/John-Li-happy/For2048/files/5502924/Generating.Sudoku.Puzzles.as.an.Inverse.Problem.pdf)

2. [Sudoku_Creation_and_Grading.pdf](https://github.com/John-Li-happy/For2048/files/5502928/Sudoku_Creation_and_Grading.pdf)

3. [A New Algorithm for Generating Unique Solution Sudoku.pdf](https://github.com/John-Li-happy/ForSudoku/files/5507208/A.New.Algorithm.for.Generating.Unique.Solution.Sudoku.pdf)


## Permission
The main purpose of this project is to bring enjoyment to those who have spare time to cut, also to offer a good chance for developers who is also interested in iOS developing to discuss. This is an open source project, but it is not allowed to use it as any commercial-purposes.

![Start29](https://user-images.githubusercontent.com/63318597/98484410-1fcdc480-21dd-11eb-9194-d8ed8a41c0c9.gif)
![Play29](https://user-images.githubusercontent.com/63318597/98484443-73d8a900-21dd-11eb-9bf6-0f331f9746ae.gif)
![Saved29](https://user-images.githubusercontent.com/63318597/98484475-b5695400-21dd-11eb-8534-43d88d68d826.gif)

<img width="270" alt="Screen Shot 2020-11-06 at 9 41 39 PM" src="https://user-images.githubusercontent.com/63318597/98484241-17c15500-21dc-11eb-9b2f-5adb2108153c.png">

