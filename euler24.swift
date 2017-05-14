/*
 https://projecteuler.net/problem=24
 
 Lexicographic permutations
 
 A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of 
 the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we 
 call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
 
 012   021   102   120   201   210
 
 What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
 */



// EXPLANATION OF THE SOLUTION:

// After staring at numbers for a long while, I determined that the index at which a given
// digit index (from right to left) first swaps is just the factorial of the digitIndex.
// To demonstrate, I'll list the first 6 ordered numbers:

// 9  8  7  6  5  4  3  2  1  0
// -------------------------------
// 0  1  2  3  4  5  6  7  8  9  : 0
// 0  1  2  3  4  5  6  7  9  8  : 1
// 0  1  2  3  4  5  6  8  7  9  : 2
// 0  1  2  3  4  5  6  8  9  7  : 3
// 0  1  2  3  4  5  6  9  7  8  : 4
// 0  1  2  3  4  5  6  9  8  7  : 5
// 0  1  2  3  4  5  7* 6  8  9  : 6

// For digit index 3 (asterisked), the permutation index at which this digit changed is:
// 3! == 6
// The digits underneath it (6, 8, 9) will permutate for every possible combination ( 3! times)
// and then the next highest number will take the place of 7. This will continue
// until all of the remaining three numbers have been substituted for 7, and then
// the next digit (5 at digit index 4) will be swapped out.

// We can create a table for the index values at which each digit first swaps, and use it
// to determine the lexicographic permutation at any index in constant time.

// The process works as follows:
// We loop from the highest digit down, subtracting the starting index value of that
// digit from the permutation index we are seeking until the starting index is greater 
// than the remaining value. We keep count of how many deductions occurred for each digit.

// When this is complete, we swap the digits based on these counts. For each digit place, there
// will be as many swaps as there were deductions. The digit indices to be swapped follow the pattern
// of index / index-1,  index / index-2, index / index-3, etc.

// For example, to calculate the lexicographic permutation at index 5, we do the following:
// * Compare each of the digit index swap values against the index, in this case
//   2! = 2 is the first value less than 5. This is the value for digit index 2.
// * Subtract 2 from 5 twice, noting the deduction count of 2
// * 2 > 1, so we move to the next digit
// * Subtract 1 from 1, noting the deduction count of 1
// * Reamining value is 0. We move on to swapping digits:
// * First, we swap digits starting at digit index 2 twice:

//  0  1  2  3  4  5  6  7  8  9
//                       <-->       // swap 7 with 8
//  0  1  2  3  4  5  6  8  7  9
//                       <----->    // swap 8 with 9
//  0  1  2  3  4  5  6  9  7  8

// * Finally, we swap at digit index 1 once:

//  0  1  2  3  4  5  6  9  7  8
//                          <-->    // swap 7 with 8
//  0  1  2  3  4  5  6  9  8  7

// That's it. 0123456987 is the lexicographic permutation at index 5


var num = [0,1,2,3,4,5,6,7,8,9]
var orderIndex = 1000000 - 1

func factorial(_ num: Int) -> Int {
    if num <= 1 {
        return 1
    }
    return (1 ... num).reduce(1, *)
}

func swap(_ num: inout [Int], _ index: Int, _ count: Int) {
    for i in 1 ... count {
        let d1 = num[index]
        let d2 = num[index+i]
        num[index] = d2
        num[index+i] = d1
    }
}

// generate swap index table
let swapIndexTable = (1 ... num.count).reversed().map { factorial($0) }

// count the number of swaps for each digit
var swaps: [Int] = Array<Int>(repeating: 0, count: num.count)
for i in (0 ..< num.count) {
    let deductor = swapIndexTable[i]
    while orderIndex >= deductor {
        orderIndex -= deductor
        swaps[i] += 1
    }
}

// do the swaps
for i in (0 ..< swaps.count) {
    let count = swaps[i]
    if count > 0 {
        swap(&num, i-1, count)
    }
}
print(num)

