import Foundation
import AVFoundation

extension CMTime {
    var asDouble: Double {
        return Double(self.value) / Double(self.timescale)
    }
    var asFloat: Float {
        return Float(self.value) / Float(self.timescale)
    }
}
