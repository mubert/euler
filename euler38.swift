/*
 https://projecteuler.net/problem=38
 Pandigital multiples
 
 
 Take the number 192 and multiply it by each of 1, 2, and 3:
 
 192 × 1 = 192
 192 × 2 = 384
 192 × 3 = 576
 
 By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the 
 concatenated product of 192 and (1,2,3)
 
 The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the 
 pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).
 
 What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated 
 product of an integer with (1,2, ... , n) where n > 1?
*/

import UIKit

func permutations(_ digits: Set<Int>, _ length: Int, _ index: Int = 0) -> [Int] {
    
    if index+1 == length {
        return Array(digits)
    }
    if digits.count == 1 {
        return [digits.first!]
    }
    var perms: [Int] = []
    
    for d in digits {
        var subDigits = digits
        subDigits.remove(d)
        let subPerms = permutations(subDigits, length, index+1)
        
        for sp in subPerms {
            perms.append((sp * 10) + d)
        }
    }
    return perms
}

func isPandigital(_ num: Int, digits: Set<Int>) -> Bool {
    
    var d = digits
    var v = num
    while v > 0 {
        let digit = v % 10
        if !d.contains(digit) {
            return false
        }
        d.remove(digit)
        v /= 10
    }
    return d.isEmpty
}

func concatProduct(_ num: Int, count: Int) -> Int {
    var str = ""
    for i in 1 ... count {
        str.append(String(num * i))
    }
    return Int(str)!
}

func findLargestPandigitalProduct(digits: Set<Int>) -> Int {
    
    var largest = 0
    for i in (1 ... (digits.count/2)) {
        let perms = permutations(digits, i)
        for p in perms {
            let concat = concatProduct(p, count: digits.count/i)
            if isPandigital(concat, digits: digits) {
                largest = max(largest, concat)
            }
        }
    }
    return largest
}

print(findLargestPandigitalProduct(digits: [1,2,3,4,5,6,7,8,9]))
