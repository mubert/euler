/*
 The sequence of triangle numbers is generated by adding the natural numbers. 
 So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:
 
 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
 
 Let us list the factors of the first seven triangle numbers:
 
 1: 1
 3: 1,3
 6: 1,2,3,6
 10: 1,2,5,10
 15: 1,3,5,15
 21: 1,3,7,21
 28: 1,2,4,7,14,28
 We can see that 28 is the first triangle number to have over five divisors.
 
 What is the value of the first triangle number to have over five hundred divisors?
*/



import UIKit

var cache: [Int: Int] = [:]

func triangleNum(_ index: Int) -> Int {
    return (index * (index+1)) / 2
}

func getNumDivisors(_ num: Int) -> Int {
    
    var divisorCount = 0
    for i in 1...Int(sqrt(Double(num))) {
        if num % i == 0 {
            divisorCount += 2
        }
    }
    return divisorCount
}

var numDivisors = 0
var i = 500
while (numDivisors <= 500) {
    let num = triangleNum(i)
    numDivisors = getNumDivisors(num)
    i += 1
}
print(triangleNum(i))