import Foundation
import UIKit

class ApplicationService {
    static let shared = ApplicationService()
    private init() {}
    
    var isLandscape: Bool { return UIDevice.current.orientation.isLandscape }
    var showNetworkActivity = false { didSet { showNetworkActivityIndicator(showNetworkActivity) }}

    // MARK: - Private API
    
    private func showNetworkActivityIndicator(_ value: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = value
        }
    }
}
