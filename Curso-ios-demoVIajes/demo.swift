


import SwiftUI
import CoreMotion
internal import Combine

struct GyroscopeView: View {
    @State private var gyroData = (x: 0.0, y: 0.0, z: 0.0)
    let motionManager = CMMotionManager()
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 20) {
            Text("Datos del Giroscopio")
                .font(.largeTitle)
            
            Text("X: \(gyroData.x, specifier: "%.2f") rad/s")
            Text("Y: \(gyroData.y, specifier: "%.2f") rad/s")
            Text("Z: \(gyroData.z, specifier: "%.2f") rad/s")
        }
        .font(.title2)
        .onAppear {
            startGyroscope()
        }
    }

    func startGyroscope() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: .main) { data, error in
                guard let data = data else { return }
                self.gyroData = (data.rotationRate.x, data.rotationRate.y, data.rotationRate.z)
            }
        }
    }
}


#Preview {
    GyroscopeView()
}
