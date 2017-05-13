/*
 https://projecteuler.net/problem=34
 
 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
 
 Find the sum of all numbers which are equal to the sum of the factorial of their digits.
 
 Note: as 1! = 1 and 2! = 2 are not sums they are not included.
*/

import UIKit

var cache: [Int : Int] = [:]

func factorial(_ num: Int) -> Int {
    if let val = cache[num] {
        return val
    }
    if num == 0 {
        return 1
    }
    let result = num * factorial(num-1)
    cache[num] = result
    return result
}

func isCurious(_ num: Int) -> Bool {

    var val = num
    var sum = 0
    while (val > 0) {
        let remainder = val % 10
        val /= 10
        sum += factorial(remainder)
    }
    return sum == num
}

var sum = 0
for i in 3 ..< 10000000 {
    let curious = isCurious(i)
    if curious {
        sum += i
    }
}
print(sum)
