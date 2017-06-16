/*
 https://projecteuler.net/problem=28
 Number spiral diagonals

 Starting with the number 1 and moving to the right in a clockwise 
 direction a 5 by 5 spiral is formed as follows:
 
 21 22 23 24 25
 20  7  8  9 10
 19  6  1  2 11
 18  5  4  3 12
 17 16 15 14 13
 
 It can be verified that the sum of the numbers on the diagonals is 101.
 
 What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral 
 formed in the same way?
*/

// EXPLANATION:

// Took me a minute to see the problem as getting the corner values of a bunch
// of concentric squares. And then the equation for those values quickly followed.
// Top right corner will always be length^2. The next three corner values
// are length^2 minus i(length-1), where i in [1..3] for the three corners.
// Simplifying the equation:
// 4(i*i) -1(i-1) -2(i-1) - 3(i-1) =
// 4(i*i) -(6i-6)


let length = 1001
var sum = 0
for i in stride(from: 1, through: length, by: 2) {
    if i == 1 {
        sum += 1
        continue
    }
    sum += (i*i * 4) - (6*i-6)
}
print(sum)
