public struct Point: Measurable, Trainable {
	public enum Color: String {
		case red, blue
	}
	
	private(set) public var color: Color?
	let data: [Double]
	public var x: Double { return data.first ?? 0 }
	public var y: Double { return data.last ?? 0 }
	
	public init(color: Color?, data: [Double]) {
		self.color = color
		self.data = data
	}
	
	private mutating func addColor(_ color: Color?) {
		self.color = color
	}
	
	/// - parameter trainingData: labelled data for training
	/// - parameter k: the number of nearest neighbours to use for training
	public mutating func train(using trainingData: [Point], k: Int = 3) {
		var k = k
		if k > trainingData.count { k = trainingData.count }
		
		var dataPoints: [(point: Point, distance: Double)] = []
		
		for data in trainingData {
			dataPoints.append((point: data, distance: distance(from: data)))
		}
		
		dataPoints.sort { $0.distance < $1.distance }
		
		let nearest = dataPoints[0..<k]
		let mode = nearest.reduce([Color: Int]()) {
			var counts = $0
			counts[$1.point.color!] = ($0[$1.point.color!] ?? 0) + 1
			return counts
			}.max { $0.1 < $1.1 }?.0
		
		addColor(mode)
	}
}

extension Point: CustomStringConvertible {
	public var description: String {
		return "Point (\(data[0]), \(data[1])) is \(color?.rawValue ?? "colourless")"
	}
}

