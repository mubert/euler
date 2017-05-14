
/*
 https://projecteuler.net/problem=27
 Quadratic primes
 
 Euler discovered the remarkable quadratic formula:
 
 n2+n+41n2+n+41
 It turns out that the formula will produce 40 primes for the consecutive integer values 0≤n≤390≤n≤39. However, when n=40,402+40+41=40(40+1)+41n=40,402+40+41=40(40+1)+41 is divisible by 41, and certainly when n=41,412+41+41n=41,412+41+41 is clearly divisible by 41.
 
 The incredible formula n2−79n+1601n2−79n+1601 was discovered, which produces 80 primes for the consecutive values 0≤n≤790≤n≤79. The product of the coefficients, −79 and 1601, is −126479.
 
 Considering quadratics of the form:
 
 n2+an+bn2+an+b, where |a|<1000|a|<1000 and |b|≤1000|b|≤1000
 
 where |n||n| is the modulus/absolute value of nn
 e.g. |11|=11|11|=11 and |−4|=4|−4|=4
 Find the product of the coefficients, aa and bb, for the quadratic expression that produces the maximum number of primes for consecutive values of nn, starting with n=0n=0.
*/


// Explanation
// Pretty simple. I create an array of all primes up to 1000, and the same values
// negated. Iterate over this array for 'a' and 'b' (nested), finding the
// consecutive prime count when 'a' and 'b' are plugged into the equation. Get the max.

func findPrimes(_ num: Int) -> [Int] {
    
    var primes: [Int] = [2]
    
    for i in 3..<num {
        
        // Is it even?
        if i & 1 == 0 {
            continue
        }
        
        var found = false
        for p in primes {
            if i % p == 0 {
                found = true
                break
            }
        }
        if found {
            continue
        }
        
        primes.append(i)
    }
    return primes
}

func isPrime(_ num: Int) -> Bool {
    if num < 0 {
        return false
    }
    let upper = max(2, Int(sqrt(Double(num))))
    for i in 2 ... upper {
        if num % i == 0 {
            return false
        }
    }
    return true
}

func consecPrimes(_ a: Int, _ b: Int) -> Int {
    var i = 0
    while isPrime(equation(i, a, b)) {
        i += 1
    }
    return i
}

func equation(_ n: Int, _ a: Int, _ b: Int) -> Int {
    return (n*n) + (a*n) + b
}

var primes = findPrimes(1000)
primes.append(contentsOf: primes.map { -$0 })

var maxPrimes = 0
var coeffProd = 0
for a in primes {
    for b in primes {
        let primeCount = consecPrimes(a, b)
        if primeCount > maxPrimes {
            coeffProd = a * b
            maxPrimes = primeCount
        }
    }
}
print(coeffProd)
