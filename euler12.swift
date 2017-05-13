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
