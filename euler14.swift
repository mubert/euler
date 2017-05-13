import UIKit

func getChainLength(_ num: Int) -> Int {
    
    var count = 1
    var i = num
    while i != 1 {
        // if the number is even
        if i & 1 == 0 {
            i /= 2
        }
        else {
            i = i*3 + 1
        }
        count += 1
    }
    return count
}

var maxChain = 0
var maxNum = 0

for i in 1 ..< 1000000 {
    let chainLength = getChainLength(i)
    if chainLength > maxChain {
        maxChain = chainLength
        maxNum = i
        print("found new max: \(i): \(chainLength)")
    }
    
}
print(maxNum)
