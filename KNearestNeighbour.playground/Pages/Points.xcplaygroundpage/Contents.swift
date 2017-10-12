//: [Previous](@previous)
//: # Example of K-Nearest Neighbour
import UIKit
import PlaygroundSupport

let p1 = Point(color: .red, data: [1, 2])
let p2 = Point(color: .red, data: [1, 3])
let p3 = Point(color: .red, data: [1, 8])
let p4 = Point(color: .red, data: [2, 4])
let p5 = Point(color: .blue, data: [-1, 3])
let p6 = Point(color: .blue, data: [-2, 6])
let p7 = Point(color: .blue, data: [-3, 1])
let p8 = Point(color: .blue, data: [-2, 0])

let trainingData = [p1, p2, p3, p4, p5, p6, p7, p8]

var testData = Point(color: nil, data: [2, 3])
var newTest = Point(color: nil, data: [-1, 0])

//testData.train(using: trainingData)
//newTest.train(using: trainingData)

let graphView = Graph()
trainingData.forEach { graphView.add(point: $0) }

let vc = UIViewController()
vc.view = graphView
PlaygroundPage.current.liveView = vc

graphView.add(point: testData)
//graphView.train()

//: [Next](@next)
