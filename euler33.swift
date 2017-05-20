/*
 https://projecteuler.net/problem=33
 Problem 33
 
 The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may 
 incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.
 
 We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
 
 There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two 
 digits in the numerator and denominator.
 
 If the product of these four fractions is given in its lowest common terms, find the value of the denominator.
*/

var numProd = 1
var denProd = 1
for n10 in 1 ..< 10 {
    for n1 in 0 ..< 10 {
        for d10 in 1 ..< 10 {
            for d1 in 0 ..< 10 {
                var num = 0
                var den = 0
                
                if n10 > d10 || (n10 == d10 && n1 >= d1) || (n1 == 0 && d1 == 0) {
                    continue
                }
                
                if n10 == d10 || n10 == d1 {
                    num = n1
                    den = (n10 == d10) ? d1 : d10
                }
                else if n1 == d10 || n10 == d1 {
                    num = n10
                    den = (n1 == d10) ? d1 : d10
                }
                else {
                    continue
                }

                let actualNum = (n10*10) + n1
                let actualDen = (d10*10) + d1
                let actual = Float(actualNum) / Float(actualDen)
                let simplified = Float(num)  / Float(den)
                
                if actual == simplified {
                    print("\(actualNum) / \(actualDen)")
                    numProd *= actualNum
                    denProd *= actualDen
                }
            }
        }
    }
}

print("\(numProd) / \(denProd)")