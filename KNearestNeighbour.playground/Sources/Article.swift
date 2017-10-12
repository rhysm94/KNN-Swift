public struct Article: Measurable, Trainable {
	var label: String?
	let data: [Double]
	
	public init(label: String?, data: [Double]) {
		self.label = label
		self.data = data
	}
	
	private mutating func addLabel(_ label: String?) {
		self.label = label
	}
	
	public mutating func train(using trainingData: [Article], k: Int = 1) {
		var nearest: Article?
		
		for data in trainingData {
			if let tempNearest = nearest {
				if distance(from: data) < distance(from: tempNearest) {
					nearest = data
				}
			} else {
				nearest = data
			}
		}
		
		self.addLabel(nearest?.label)
	}
}

extension Article: CustomStringConvertible {
	public var description: String {
		return "Article about \(data) has label \(label ?? "no label")"
	}
}
