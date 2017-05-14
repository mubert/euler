/*
 https://projecteuler.net/problem=20
 
 n! means n × (n − 1) × ... × 3 × 2 × 1
 
 For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
 and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
 
 Find the sum of the digits in the number 100!
*/

// Sort of cheating using wolfram alpha to generate 100!
let fac100 = "93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000"

extension Int {
    init(_ c: Character) {
        self = Int(String(c))!
    }
}

func addStrDigits(_ str: String) -> Int {
    return str.characters.reduce(0) { $0 + Int($1) }
}

let solution = addStrDigits(fac100)
print(solution)