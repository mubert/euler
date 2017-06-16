/*
 https://projecteuler.net/problem=31
 Coin sums
 
 
 In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:
 
 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
 It is possible to make £2 in the following way:
 
 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
 How many different ways can £2 be made using any number of coins?
*/

 
func combs(_ val: Int, _ coins: [Int], _ coinIndex: Int) -> Int {
    
    var coin = coins[coinIndex]
    if val < coin {
        return 0
    }
    var sum = 1
    if coinIndex+1 >= coins.count {
        return sum
    }
    coin = coins[coinIndex+1]
    for i in stride(from: 0, to: val, by: coin) {
        sum += combs(val-i, coins, coinIndex+1)
    }
    return sum
}

print(combs(200, [1,2,5,10,20,50,100,200], 0))
