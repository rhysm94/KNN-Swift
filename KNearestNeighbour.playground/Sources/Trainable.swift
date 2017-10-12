protocol Trainable {
	mutating func train(using trainingData: [Self], k: Int)
}
