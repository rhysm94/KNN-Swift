import UIKit

public class Graph: UIView {
	private struct Constants {
		static let cornerRadiusSize = CGSize(width: 8, height: 8)
		static let margin: CGFloat = 20
		static let topBorder: CGFloat = 60
		static let bottomBorder: CGFloat = 50
		static let colorAlpha: CGFloat = 0.3
		static let circleDiameter: CGFloat = 10
	}
	
	var points: [Point] = [] {
		didSet {
			setNeedsDisplay()
		}
	}
	
	var startColor: UIColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
	var midColor: UIColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
	var endColor: UIColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
	
	public override func draw(_ rect: CGRect) {
		let path = UIBezierPath(roundedRect: rect,
		                        byRoundingCorners: .allCorners,
		                        cornerRadii: Constants.cornerRadiusSize)
		path.addClip()
		
		let context = UIGraphicsGetCurrentContext()!
		let colors = [startColor.cgColor, endColor.cgColor]
		
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		
		let colorLocations: [CGFloat] = [0, 1]
		
		let gradient = CGGradient(colorsSpace: colorSpace,
		                          colors: colors as CFArray,
		                          locations: colorLocations)!
		
		let startPoint = CGPoint.zero
		let endPoint = CGPoint(x: 0, y: bounds.height)
		context.drawLinearGradient(gradient,
		                           start: startPoint,
		                           end: endPoint,
		                           options: [])
		
		let width = rect.width
		let height = rect.height
		let midX = rect.midX
		let midY = rect.midY
		
		UIColor.white.setFill()
		UIColor.white.setStroke()
		
		let middleVerticalLine = UIBezierPath()
		middleVerticalLine.move(to: CGPoint(x: midX, y: 20))
		middleVerticalLine.addLine(to: CGPoint(x: midX, y: height - 20))
		middleVerticalLine.stroke()
		
		let middleHorizontalLine = UIBezierPath()
		middleHorizontalLine.move(to: CGPoint(x: 20, y: midY))
		middleHorizontalLine.addLine(to: CGPoint(x: width - 20, y: midY))
		middleHorizontalLine.stroke()
		
		func drawPoint(_ point: Point, color: Point.Color?) {
			var point = CGPoint(x: midX + CGFloat(point.x) * 20, y: midY - CGFloat(point.y) * 20)
			point.x -= Constants.circleDiameter / 2
			point.y -= Constants.circleDiameter / 2
			
			let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
			circle.fill()
		}
		
		for i in 0..<points.count {
			switch points[i].color {
			case .none:
				UIColor.white.setStroke()
				UIColor.white.setFill()
			case .some(.red):
				UIColor.red.setStroke()
				UIColor.red.setFill()
			case .some(.blue):
				UIColor.blue.setStroke()
				UIColor.blue.setFill()
			}
			
			drawPoint(points[i], color: points[i].color)
		}
	}
	
	public func add(point: Point) {
		points.append(point)
	}
	
	public func train() {
		for (index, point) in zip(points.indices, points) where point.color == nil {
			var newPoint = point
			points.remove(at: index)
			newPoint.train(using: points)
			add(point: newPoint)
		}
	}
}
