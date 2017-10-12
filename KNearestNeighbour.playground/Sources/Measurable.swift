import Darwin

protocol HasData {
	var data: [Double] { get }
}

protocol Measurable: HasData {
	func distance(from other: Self) -> Double
}

extension Measurable {
	func distance(from other: Self) -> Double {
		assert(other.data.count == self.data.count)
		
		var distances: [Double] = []
		
		for index in data.indices {
			distances.append(pow(other.data[index] - self.data[index], 2))
		}
		
		return sqrt(distances.reduce(0, +))
	}
}
