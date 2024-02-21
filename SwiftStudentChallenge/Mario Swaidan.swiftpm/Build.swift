import SwiftUI

struct Turbine: Identifiable {
    var id = UUID()
    var imageName: String
    var position: CGPoint
}

struct Build: View {
    @State private var turbines: [Turbine]
    
    init() {
        _turbines = State(initialValue: [
            Turbine(imageName: "turbine", position: BoxPosition.topBoxCenter),
            Turbine(imageName: "turbine", position: BoxPosition.bottomBoxLeft),
            Turbine(imageName: "turbine", position: BoxPosition.bottomBoxRight)
        ])
    }
    
    var body: some View {
        ZStack{
            Image("Drone")
                .resizable()
                .scaledToFit()
                .frame(width:650)
            VStack {
                GeometryReader { geometry in
                    ZStack {
                        
                        BoxView(y: BoxPosition.topRowY, screenWidth: geometry.size.width)
                        BoxView(y: BoxPosition.bottomRowY, screenWidth: geometry.size.width)
                        
                        ForEach($turbines) { $turbine in
                            Image(turbine.imageName)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .position(turbine.position)
                                .gesture(DragGesture()
                                    .onChanged { value in
                                        turbine.position = value.location
                                    }
                                    .onEnded { value in
                                        turbine.position = BoxPosition.nearestBoxCenter(for: value.location) ?? turbine.position
                                    }
                                )
                        }
                    }
                }
                PagerView()
            }
        }
    }
}
struct BoxPosition {
    static let topRowY: CGFloat = 100
    static let bottomRowY: CGFloat = 500
    static let boxWidth: CGFloat = 100
    static let boxSpacing: CGFloat = 50
    
    static var topBoxCenter: CGPoint { calculateBoxCenter(y: topRowY) }
    
    static var bottomBoxLeft: CGPoint {
        CGPoint(x: UIScreen.main.bounds.width / 2 - boxWidth - boxSpacing, y: bottomRowY)
    }
    
    static var bottomBoxRight: CGPoint {
        CGPoint(x: UIScreen.main.bounds.width / 2 + boxWidth + boxSpacing, y: bottomRowY)
    }
    
    static func calculateBoxCenter(y: CGFloat) -> CGPoint {
        let screenWidth = UIScreen.main.bounds.width
        return CGPoint(x: screenWidth / 2, y: y)
    }
    
    static func nearestBoxCenter(for location: CGPoint) -> CGPoint? {
        let threshold: CGFloat = 50
        let centers = [topBoxCenter, bottomBoxLeft, bottomBoxRight]
        let nearest = centers.min(by: { distance($0, location) < distance($1, location) })
        
        if let nearestPoint = nearest, distance(nearestPoint, location) < threshold {
            return nearestPoint
        } else {
            return nil
        }
    }
    
    static func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y))
    }
}

struct BoxView: View {
    var y: CGFloat
    var screenWidth: CGFloat
    
    var body: some View {
        Rectangle()
            .frame(width: BoxPosition.boxWidth, height: BoxPosition.boxWidth)
            .foregroundColor(.white)
            .border(Color.white, width: 2)
            .position(x: screenWidth / 2, y: y)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Build()
    }
}
