import Foundation

func testSolution(_ solution: ([Int], Int) -> [Int], prefixMessage: String? = nil) {
    var testsPassed = 0
    var failedTests: [(list: [Int], target: Int, expectedSolution: [Int], actualSolution: [Int])] = []
    
    if let prefixMessage = prefixMessage {
        print(prefixMessage)
    }
    let tests: [(list: [Int], target: Int, expectedSolution: [Int])] = [
        ([2,7,11,15], 9, [0, 1]),
        ([3,2,4], 6, [1, 2]),
        ([3,3], 6, [0, 1])
    ]
    for (list, target, expectedSolution) in tests {
        let actualSolution = solution(list, target)
        if actualSolution == expectedSolution {
            testsPassed += 1
        }
        else {
            failedTests.append((list, target, expectedSolution, actualSolution))
        }
    }
    print("\(testsPassed)/\(tests.count) Tests Passed")
    if !failedTests.isEmpty {
        for failedTest in failedTests {
            print(failedTest)
        }
    }
    print()
}

func bruteForce(_ nums: [Int], _ target: Int) -> [Int] {
    for i in 0..<nums.count {
        for j in (i + 1)..<nums.count {
            if nums[i] + nums[j] == target {
                return [i, j]
            }
        }
    }
    return [Int]()
}

func twoPassHashTable(_ nums: [Int], _ target: Int) -> [Int] {
    var hashTable: [Int: Int] = [:]
    for i in 0..<nums.count {
        hashTable[nums[i]] = i
    }
    for i in 0..<nums.count {
        let complement = target - nums[i]
        if let value = hashTable[complement], value != i {
            return [i, value]
        }
    }
    return [Int]()
}

func onePassHashTable(_ nums: [Int], _ target: Int) -> [Int] {
    var hashTable: [Int: Int] = [:]
    for i in 0..<nums.count {
        let complement = target - nums[i]
        if let value = hashTable[complement], value != i {
            return [value, i]
        }
        hashTable[nums[i]] = i
    }
    return [Int]()
}

testSolution(bruteForce, prefixMessage: "Brute Force Solution")
testSolution(twoPassHashTable, prefixMessage: "Two Pass Hash Table Solution")
testSolution(onePassHashTable, prefixMessage: "One Pass Hash Table Solution")
