import Foundation
import UIKit

class ApplicationService {
    static let shared = ApplicationService()
    private init() {}
    
    // MARK: - API
    
    func showNetworkActivityIndicator(_ value: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = value
        }
    }
}
