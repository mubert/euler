/*
 https://projecteuler.net/problem=25
 1000-digit Fibonacci number
 
 The Fibonacci sequence is defined by the recurrence relation:
 
 Fn = Fn−1 + Fn−2, where F1 = 1 and F2 = 1.
 Hence the first 12 terms will be:
 
 F1 = 1
 F2 = 1
 F3 = 2
 F4 = 3
 F5 = 5
 F6 = 8
 F7 = 13
 F8 = 21
 F9 = 34
 F10 = 55
 F11 = 89
 F12 = 144
 The 12th term, F12, is the first term to contain three digits.
 
 What is the index of the first term in the Fibonacci sequence to contain 1000 digits?
*/


// EXPLANATION:
// We can't just bruteforce with a 64 bit Int because 10^1000 is well out of range.
// Doubles were also crapping out around e+300 for some reason I don't understand
// (64 bit doubles have 11 bits of exponent precision - should cover 1000, right?)
// Whatever. I just made a struct to track 10^x power in a separate Int, and I make
// sure I keep values between [0..10) and increment exp when it goes beyond the bound.


struct BigDouble {
    var val: Double
    var exp: Int
}

var cache: [Int : BigDouble] = [:]
func fib(_ num: Int) -> BigDouble {
    if num <= 2 {
        return BigDouble(val: 1.0, exp: 0)
    }
    let prev1 = cache[num-1] ?? fib(num-1)
    var prev2 = cache[num-2] ?? fib(num-2)
    var sum: Double = 0
    if prev1.exp > prev2.exp {
        prev2.val /= 10
    }
    sum = prev1.val + prev2.val
    
    var exp = prev1.exp
    if sum >= 10 {
        exp += 1
        sum /= 10
    }

    let result = BigDouble(val: sum, exp: exp)
    cache[num] = result
    return result
}

var i = 0
while fib(i).exp < 999 {
    i += 1
}
print(i)
