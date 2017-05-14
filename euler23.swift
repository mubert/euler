/*
 https://projecteuler.net/problem=23
 
 Non-abundant sums
 
 A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors 
 of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
 
 A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.
 
 As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. 
 By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper
 limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant
 numbers is less than this limit.
 
 Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
*/


func isAbundantNum(_ num: Int) -> Bool {
    if num <= 1 {
        return false
    }
    let sum = (1 ... num/2).reduce(0) { $0 + (num % $1 == 0 ? $1 : 0) }
    return sum > num
}

func getAbundantSums(_ abundantNums: [Int], _ limit: Int) -> Set<Int> {
    
    var sums: Set<Int> = []
    
    for i in 0 ..< abundantNums.count {
        let a = abundantNums[i]
        for j in i ..< abundantNums.count {
            let sum = a + abundantNums[j]
            if sum > limit {
                break
            }
            sums.insert(sum)
        }
    }
    return sums
}


let limit = 28123
let abundantNums = (1 ... 28123).filter { isAbundantNum($0) }
let abundantSums = getAbundantSums(abundantNums, limit)
let sumOfSums = (0 ... limit).reduce(0) { $0 + (abundantSums.contains($1) ? 0 : $1) }
print(sumOfSums)