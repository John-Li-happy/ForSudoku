# ForSudoku
For Sudoku is an open source sandbox game

## Discription
A game designed for killing time when user feels boring. In the old days, it could always been found on newspaper entertainment section. 

 - For beginners, there are three rules of sudoku
 + Any row contains one of each number from 1 to 9;
 + Any colume contains one of each number from 1 to 9;
 + Any 3 * 3 grid contains one of each number from 1 to 9;

## Logic History
### First Logic
Step 1: Based on three rules, random numbers array *rowA* could been generated based on first rule(row). In *rowA* there are no repeated digits;

Step 2: Then repeat *Step 1* 9 times, a 9 * 9 matrix *SectorA* is generated.

Step 3: Check *SectorA* is adaptable with *rule3*. If not, go back to *Step 1*

For this logic it takes a lot redundant time of checking *rule 3* adapation. For the first valid matrix, spends me 6 hours. Then I move to the second one

### Second Logic 
  

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

## References

## Permission
The main purpose of this project is to bring enjoyment to those who have spare time to cut, also to offer a good chance for developers who is also interested in iOS developing to discuss. This is an open source project, but it is not allowed to use it as any commercial-purposes.
