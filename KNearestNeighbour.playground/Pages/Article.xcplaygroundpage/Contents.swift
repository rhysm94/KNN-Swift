//: # Example of 1-Nearest Neighbour

// Examples of articles which have been labelled
// Data is word counts, in the following order:
// [america, banker, political, obama, ball, score]
let pol1 = Article(label: "Politics", data: [1, 0, 0, 3, 0, 0])
let eco = Article(label: "Economics", data: [1, 3, 0, 0, 0, 0])
let spo = Article(label: "Sport", data: [1, 0, 0, 0, 3, 2])
let pol2 = Article(label: "Politics", data: [0, 3, 2, 1, 0, 0])

let trainingData = [pol1, eco, spo, pol2]

var testData = Article(label: nil, data: [0, 2, 1, 4, 0, 1])
var testData2 = Article(label: nil, data: [2, 0, 0, 0, 3, 4])
var testData3 = Article(label: nil, data: [0, 3, 1, 0, 0, 0])

print(testData)
print(testData2)
print(testData3)

print("Training...")
testData.train(using: trainingData)
testData2.train(using: trainingData)
testData3.train(using: trainingData)

print(testData)
print(testData2)
print(testData3)

//: [Next](@next)
