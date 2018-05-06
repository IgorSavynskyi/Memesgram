import Foundation
import UIKit

class ApplicationService {
    static let shared = ApplicationService()
    private init() {}
    
    var isLandscape: Bool { return isLandscapeOrientation() }

    // MARK: - API
    
    func showNetworkActivityIndicator(_ value: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = value
        }
    }
    
    // MARK: - Private API
    
    private func isLandscapeOrientation() -> Bool {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            return true
        default:
            return false
        }
    }
}
