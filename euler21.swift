/*
 https://projecteuler.net/problem=21
 
 Amicable numbers
 
 Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
 If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
 
 For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
 
 Evaluate the sum of all the amicable numbers under 10000.
*/

func getSumOfDivisors(_ num: Int) -> Int {
    if num <= 1 {
        return 0
    }
    return (1 ... num/2).reduce(0) { $0 + (num % $1 == 0 ? $1 : 0) }
}

func isAmicable(_ num: Int) -> Bool {
    let a = getSumOfDivisors(num)
    return a != num && getSumOfDivisors(a) == num
}

let solution = (1 ..< 10000).reduce(0) { $0 + (isAmicable($1) ? $1 : 0) }
