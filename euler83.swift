/*
 https://projecteuler.net/problem=83
 Path sum: four ways
 
 In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by moving left, right, up, and down, is indicated in bold red and is equal to 2297.
 
 [ DIAGRAM OF PATH THROUGH 2D ARRAY OF NUMBERS ]

 Find the minimal path sum, in matrix.txt (right click and "Save Link/Target As..."), a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by moving left, right, up, and down.
*/

// EXPLANATION
//
// Same as 82 and 81 - djikstra. Just added left-ward traversal.

import UIKit


struct Pt : Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    public static func ==(lhs: Pt, rhs: Pt) -> Bool {
        return lhs.y == rhs.y && lhs.x == rhs.x
    }
    
    var hashValue : Int {
        get {
            return x.hashValue &* 31 &+ y.hashValue
        }
    }
}


struct PriorityQueue<T: Hashable> {
    
    typealias Node = (v: T, p: Int)
    
    var data: [Node] = []
    var dict: [T : Int] = [:]
    
    public var isEmpty: Bool {
        return data.isEmpty
    }
    
    init() {
    }
    
    init(_ data: [Node]) {
        self.data = data
        for (i, d) in data.enumerated() {
            dict[d.v] = i
        }
    }
    
    private func parent(_ index: Int) -> Int {
        return (index-1) / 2
    }
    
    private func leftChild(_ index: Int) -> Int {
        return index * 2 + 1
    }
    
    private func rightChild(_ index: Int) -> Int {
        return index * 2 + 2
    }
    
    private func parentPriority(_ index: Int) -> Int? {
        if index == 0 {
            return nil
        }
        return data[parent(index)].p
    }
    
    private func leftChildPriority(_ index: Int) -> Int? {
        if leftChild(index) >= data.count {
            return nil
        }
        return data[leftChild(index)].p
    }
    
    private func rightChildPriority(_ index: Int) -> Int? {
        if rightChild(index) >= data.count {
            return nil
        }
        return data[rightChild(index)].p
    }
    
    private mutating func swap(_ i1: Int, _ i2: Int) {
        let val = data[i1]
        data[i1] = data[i2]
        data[i2] = val
        
        dict[val.v] = i2
        dict[data[i1].v] = i1
    }
    
    private mutating func bubbleUp(_ index: Int) {
        var i = index
        let priority = data[i].p
        while priority < parentPriority(i) ?? Int.min {
            swap(i, parent(i))
            i = parent(i)
        }
        if data[0].p == Int.max {
            for d in data {
                print(d)
            }
        }
    }
    
    private mutating func bubbleDown(_ index: Int) {
        var i = index
        let p = data[i].p
        while true {
            let lcp = leftChildPriority(i) ?? Int.max
            let rcp = rightChildPriority(i) ?? Int.max
            if p > lcp && lcp <= rcp {
                swap(i, leftChild(i))
                i = leftChild(i)
            }
            else if p > rcp && rcp <= lcp {
                swap(i, rightChild(i))
                i = rightChild(i)
            }
            else {
                break
            }
        }
    }
    
    public mutating func insert(_ e: T, priority : Int) {
        data.append(Node(e, priority))
        self.bubbleUp(data.count-1)
    }
    
    public mutating func pop() -> T {
        
        let v = data[0].v
        
        // remove top element and put last element on top
        swap(0, data.count-1)
        data.remove(at: data.count-1)
        dict.removeValue(forKey: v)
        
        if self.isEmpty {
            return v
        }
        
        self.bubbleDown(0)
        return v
    }
    
    public mutating func decreasePriority(_ v: T, priority: Int) {
        let i = dict[v]!
        data[i].p = priority
        self.bubbleUp(i)
    }
}

func djikstra(graph: [[Int]], start: Pt, dest: Pt) {
    
    var minDist: [Pt : Int] = [:]
    var prev: [Pt : Pt] = [:]
    
    var q: PriorityQueue<Pt> = PriorityQueue(
        (0 ..< graph.count).flatMap { (y) in
            (0 ..< graph[y].count).map { (x) in
                let pt = Pt(x, y)
                return (pt, (pt == start) ? 0 : Int.max)
            }
        }
    )
    
    // initialize min-distance array
    for y in 0 ..< graph.count {
        for x in 0 ..< graph[y].count {
            minDist[Pt(x, y)] = Int.max
        }
    }
    minDist[start] = 0
    
    while !q.isEmpty {
        let v = q.pop()
        let curDist = minDist[v]!
        
        if v == dest {
            break
        }
        
        // add edges of v
        var edges: [Pt] = []
        if v.y-1 >= 0 {
            edges.append(Pt(v.x, v.y-1))
        }
        if v.x+1 < graph[0].count {
            edges.append(Pt(v.x+1, v.y))
        }
        if v.y+1 < graph.count {
            edges.append(Pt(v.x, v.y+1))
        }
        if v.x-1 >= 0 {
            edges.append(Pt(v.x-1, v.y))
        }
        
        for e in edges {
            let edgeVal = graph[e.y][e.x]
            let distance = curDist + edgeVal
            
            if distance < minDist[e]! {
                minDist[e] = distance
                prev[e] = v
                q.decreasePriority(e, priority: distance)
            }
        }
    }
    var sum = graph[dest.y][dest.x] + graph[start.y][start.x]
    var v = prev[dest]!
    while v != start {
        print("\(v.x) \(v.y)")
        sum += graph[v.y][v.x]
        v = prev[v]!
    }
    print("SUM: \(sum)")
}


let url = URL(string: "https://projecteuler.net/project/resources/p083_matrix.txt")
let request = URLRequest(url: url!)

NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
    
    let csv = NSString(data: data!, encoding: 4)! as String
    let graph: [[Int]] = csv.components(separatedBy: "\n").filter { $0 != "" }
        .map{ $0.components(separatedBy: ",").map { Int($0)! } }
    
    let start = Pt(0, 0)
    let dest = Pt(graph[graph.count-1].count-1, graph.count-1)
    
    djikstra(graph: graph, start: start, dest: dest)
}

