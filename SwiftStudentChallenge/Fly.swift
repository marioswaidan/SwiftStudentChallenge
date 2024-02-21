import SwiftUI
import ARKit
import SceneKit

struct FlyARView: View {
    @State private var controlInput = ControlInput(thrust: 0, yaw: 0, pitch: 0, roll: 0)
    
    var body: some View {
        ZStack {
            ARViewContainer(controlInput: controlInput)
                .edgesIgnoringSafeArea(.top)
            VStack {
                Spacer()
                ControlPanelView(controlInput: $controlInput)
                PagerView()
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    var controlInput: ControlInput
    
    func makeUIView(context: Context) -> ARSCNView {
        let view = ARSCNView()
        view.session.run(ARWorldTrackingConfiguration())
        context.coordinator.setupScene(view)
        return view
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        context.coordinator.update(controlInput: controlInput)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, ARSCNViewDelegate {
        var arViewContainer: ARViewContainer
        var imageNode: SCNNode?
        
        init(_ arViewContainer: ARViewContainer) {
            self.arViewContainer = arViewContainer
        }
        
        func setupScene(_ view: ARSCNView) {
            view.delegate = self
            let scene = SCNScene()
            view.scene = scene
            
            let pyramid = SCNPyramid(width: 0.3, height: 0.3, length: 0.05)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.systemBlue
            pyramid.materials = [material]
            
            imageNode = SCNNode(geometry: pyramid)
            imageNode?.position = SCNVector3(x: 0, y: 0, z: -0.5)
            imageNode?.eulerAngles.x = -Float.pi / 2

            // Adjust the pivot to be at the center of the base of the pyramid
            let pyramidHeight = Float(pyramid.height) / 1 // Convert to Float and divide by 2
            imageNode?.pivot = SCNMatrix4MakeTranslation(0, -pyramidHeight, 0)

            scene.rootNode.addChildNode(imageNode!)

            // Gold coin setup
            let coinGeometry = SCNCylinder(radius: 0.05, height: 0.01)
            let coinMaterial = SCNMaterial()
            coinMaterial.diffuse.contents = UIColor(red: 1.0, green: 0.84, blue: 0, alpha: 1.0) // Gold color
            coinGeometry.materials = [coinMaterial]
            
            let coinNode = SCNNode(geometry: coinGeometry)
            coinNode.position = SCNVector3(x: 0, y: 0, z: -2)
            coinNode.eulerAngles.x = -Float.pi / 2 // Make it lie flat
            
            scene.rootNode.addChildNode(coinNode)
        }

        
        func update(controlInput: ControlInput) {
            guard let imageNode = imageNode else { return }
            
            // Calculate adjusted pitch and roll based on current yaw
            let yawRotation = imageNode.eulerAngles.y
            let adjustedPitch = Float(controlInput.pitch) * cos(yawRotation) - Float(controlInput.roll) * sin(yawRotation)
            let adjustedRoll = Float(controlInput.pitch) * sin(yawRotation) + Float(controlInput.roll) * cos(yawRotation)
            
            imageNode.position.x += adjustedRoll * 0.01
            imageNode.position.y -= Float(controlInput.thrust) * 0.01
            imageNode.position.z += adjustedPitch * 0.01
            
            // Adjusting yaw sensitivity
            let yawSensitivityFactor: Float = 0.1 // Adjust sensitivity factor
            imageNode.eulerAngles.y += -Float(controlInput.yaw) * yawSensitivityFactor
        }
    }
}

// MARK: - ControlPanelView and JoystickView remain unchanged
struct ControlPanelView: View {
    @Binding var controlInput: ControlInput
    
    var body: some View {
        HStack {
            JoystickView(title: "Thrust/Yaw", controlInput: $controlInput, isThrustYaw: true)
            JoystickView(title: "Pitch/Roll", controlInput: $controlInput, isThrustYaw: false)
        }
        .background(Color.black)
        .cornerRadius(15)
    }
}

struct JoystickView: View {
    var title: String
    @Binding var controlInput: ControlInput
    var isThrustYaw: Bool
    
    var body: some View {
        VStack {
            Text(title).foregroundColor(.white)
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 150, height: 150)
                Circle()
                    .fill(Color.white)
                    .frame(width: 135, height: 135)
                Circle()
                    .fill(Color.teal)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Circle()
                            .fill(Color.black)
                            .frame(width: 100, height: 100)
                            .padding(10)
                            .gesture(
                                DragGesture().onChanged { gesture in
                                    let maxDistance = 100.0
                                    var dx = Double(gesture.translation.width)
                                    var dy = Double(gesture.translation.height)
                                    
                                    dx = max(min(dx, maxDistance), -maxDistance)
                                    dy = max(min(dy, maxDistance), -maxDistance)
                                    
                                    if isThrustYaw {
                                        controlInput.thrust = CGFloat(dy / maxDistance)
                                        controlInput.yaw = CGFloat(dx / maxDistance)
                                    } else {
                                        controlInput.pitch = CGFloat(dy / maxDistance)
                                        controlInput.roll = CGFloat(dx / maxDistance)
                                    }
                                }
                                    .onEnded { _ in
                                        controlInput = ControlInput(thrust: 0, yaw: 0, pitch: 0, roll: 0)
                                    }
                            )
                    )
            }
        }
        .padding()
    }
}

struct ControlInput {
    var thrust: CGFloat
    var yaw: CGFloat
    var pitch: CGFloat
    var roll: CGFloat
}

// Assuming PagerView is defined elsewhere, as it's not provided in your code.
