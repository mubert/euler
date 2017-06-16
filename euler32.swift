/*
 https://projecteuler.net/problem=32
 Pandigital products
 
 We shall say that an n-digit number is pandigital if it makes use of all the 
 digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 
 through 5 pandigital.
 
 The product 7254 is unusual, as the identity, 39 × 186 = 7254, 
 containing multiplicand, multiplier, and product is 1 through 9 pandigital.
 
 Find the sum of all products whose multiplicand/multiplier/product identity 
 can be written as a 1 through 9 pandigital.
 
 HINT: Some products can be obtained in more than one way so be sure to only 
 include it once in your sum.
*/

// Explanation
// My approach is to calculate all permutations for digits [1..9] of the length
// 5, since that is the only multiplicand/multiplier pair length that will result
// in potential results. From there, I split these permutations into 1/4 and 2/3
// length pairs, calculate the products, and test the results.

import UIKit

func permutations(_ digits: Set<Int>, _ length: Int, _ index: Int) -> [[Int]] {
    
    if index == length {
        return [[]]
    }
    if digits.count == 1 {
        return [[digits.first!]]
    }
    var perms: [[Int]] = []
    
    for d in digits {
        var subDigits = digits
        subDigits.remove(d)
        let subPerms = permutations(subDigits, length, index+1)
        
        for var sp in subPerms {
            sp.insert(d, at: 0)
            perms.append(sp)
        }
    }
    return perms
}

func toInt<T: Sequence>(_ numbers: T) -> Int where T.Iterator.Element == Int {
    return numbers.reduce(0) { ($0 * 10) + $1 }
}

func digitsFromInt(_ num: Int) -> [Int] {
    var digits: [Int] = []
    var val = num
    while val > 0 {
        digits.insert(val % 10, at: 0)
        val /= 10
    }
    return digits
}


let digits: Set<Int> = [1,2,3,4,5,6,7,8,9]
let perms = permutations(digits, 5, 0)
var products: Set<Int> = []

// split permutations into 1/4 and 2/3 multiplicand/multiplier pairs
// then test the product
for i in 1 ... 2 {
    for perm in perms {
        let p1 = toInt(perm.prefix(upTo: i))
        let p2 = toInt(perm.suffix(from: i))
        let product = p1 * p2
        let productDigits = digitsFromInt(product)
        
        let is9Digits = perm.count + productDigits.count == 9
        let hasAllDigits = digits.intersection(Set(productDigits).union(Set(perm))) == digits
        if hasAllDigits && is9Digits  {
            products.insert(product)
        }
    }
}
print(products.reduce(0,+))

