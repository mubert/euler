/*
 https://projecteuler.net/problem=15
 
 Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.

 [diagram]
 
 How many such routes are there through a 20×20 grid?
*/


// Using Ints would overflow for the massive values involved.
func factorial(_ num: Int) -> Double {
    return (1...num).reduce(1.0) { $0 * Double($1) }
}

// The answer is 40! / 20! * 20! = 137846528820
factorial(40) / (factorial(20) * factorial(20))
