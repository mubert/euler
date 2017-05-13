import UIKit

func findPrimes(_ num: Int) -> [Int] {
    
    var primes: [Int] = [2]
    
    for i in 3...num {
        
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

let num = 600851475143
let primes = findPrimes(Int(sqrt(Double(num))))
for p in primes.reversed() {
    if num % p == 0 {
        print(p)
        break
    }
}
