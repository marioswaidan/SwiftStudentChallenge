import SwiftUI

struct Build: View {
    private let circleSize: CGFloat = 100
    @State private var offset1 = CGSize.zero // Offset for the first circle
    @State private var offset2 = CGSize.zero // Offset for the second circle
    @State private var showTriangle = false
    
    // Threshold distance
    private let thresholdDistance: CGFloat = 150
    
    // Drag gesture for the first circle
    var dragGesture1: some Gesture {
        DragGesture()
            .onChanged { value in
                self.offset1 = CGSize(width: value.translation.width, height: value.translation.height)
            }
            .onEnded { value in
                // Calculate the distance dragged
                let dragDistance = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2))
                
                // Show the triangle if the drag distance exceeds the threshold
                if dragDistance > self.thresholdDistance {
                    self.showTriangle = true
                }
            }
    }
    
    // Drag gesture for the second circle
    var dragGesture2: some Gesture {
        DragGesture()
            .onChanged { value in
                self.offset2 = CGSize(width: value.translation.width, height: value.translation.height)
            }
            .onEnded { value in
                // Calculate the distance dragged
                let dragDistance = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2))
                
                // Show the triangle if the drag distance exceeds the threshold
                if dragDistance > self.thresholdDistance {
                    self.showTriangle = true
                }
            }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                if !showTriangle {
                    Spacer()
                    Image("books")
                        .foregroundColor(.teal)
                        .frame(width: circleSize, height: circleSize)
                        .offset(x: offset1.width, y: offset1.height) // Use offset1 for this image
                        .gesture(dragGesture1)
                    Spacer()
                } else {
                    ZStack {
                        VStack {
                            HStack {
                                Circle()
                                    .foregroundColor(.teal)
                                    .frame(width: circleSize, height: circleSize)
                                    .offset(x: offset1.width, y: offset1.height) // Use offset1 for the first circle
                                    .gesture(dragGesture1)
                                Circle()
                                    .foregroundColor(.teal)
                                    .frame(width: circleSize, height: circleSize)
                                    .offset(x: offset2.width, y: offset2.height) // Use offset2 for the second circle
                                    .gesture(dragGesture2)
                            }
                        }
                    }
                    Spacer()
                }
                PagerView()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Drag")
            .toolbar {
                Button("Reset") {
                    offset1 = .zero
                    offset2 = .zero // Reset offsets for both circles
                    showTriangle = false
                }
            }
        }
    }
}


struct Build_Previews: PreviewProvider {
    static var previews: some View {
        Build()
    }
}
