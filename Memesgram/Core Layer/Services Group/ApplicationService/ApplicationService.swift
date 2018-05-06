import Foundation
import UIKit

class ApplicationService {
    static let shared = ApplicationService()
    private init() {}
    
    var isLandscape: Bool { return UIDevice.current.orientation.isLandscape }

    // MARK: - API
    
    func showNetworkActivityIndicator(_ value: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = value
        }
    }
}
