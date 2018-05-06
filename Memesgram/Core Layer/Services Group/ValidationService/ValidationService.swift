import Foundation
import UIKit

class ValidationService {
    static let shared = ValidationService()
    private init() {}
    
    // MARK: - API
    
    func isValidURL(_ candidate: String?) -> Bool {
        if let candidate = candidate {
            if let url = URL(string: candidate) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
}
