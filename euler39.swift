/*
 https://projecteuler.net/problem=39
 Integer right triangles
 
 
 If p is the perimeter of a right angle triangle with integral length 
 sides, {a,b,c}, there are exactly three solutions for p = 120.
 
 {20,48,52}, {24,45,51}, {30,40,50}
 
 For which value of p ≤ 1000, is the number of solutions maximised?
*/


import UIKit


func solutions(_ p: Int) -> [[Int]] {
    var solutions: [[Int]] = []
    for a in 1 ..< p {
        for b in 1 ..< p {
            let cF = sqrt(Double(a*a + b*b))
            let c = Int(cF)
            if c > p - a - b {
                break
            }
            if cF > Double(c) {
                continue
            }
            if c == p - a - b {
                solutions.append([a, b, c])
            }
        }
        
    }
    return solutions
}

var max = 0
var maxP = 0
for p in 1 ..< 1000 {
    let numSolutions = solutions(p).count
    if numSolutions > max {
        max = numSolutions
        maxP = p
    }
}

print(maxP)
