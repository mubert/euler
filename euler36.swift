/*
 https://projecteuler.net/problem=36
 Double-base palindromes
 
 
 The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
 
 Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
 
 (Please note that the palindromic number, in either base, may not include leading zeros.)
*/


func isPalindrome(_ chars: [Character]) -> Bool {
    for i in 0 ... (chars.count/2) {
        if chars[i] != chars[chars.count-i-1] {
            return false
        }
    }
    return true
}

func isDecimalPalindrome(_ num: Int) -> Bool {
    return isPalindrome(Array(String(num).characters))
}


func isBinaryPalindrome(_ num: Int) -> Bool {
    return isPalindrome(Array(String(String(num, radix: 2)).characters))
}

var sum = 0
for i in 0 ..< 1000000 {
    if isDecimalPalindrome(i) && isBinaryPalindrome(i) {
        sum += i
    }
}
print(sum)