import Foundation
import UIKit

class ValidationService {
    static let shared = ValidationService()
    private init() {}
    
    private static let imageExtensions = ["png", "jpg", "gif"]
    
    // MARK: - API
    
    func isValidURL(_ candidate: String?) -> Bool {
        if let candidate = candidate {
            if let url = URL(string: candidate) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
    func isImageUrl(_ candidate: String?) -> Bool {
        guard let candidate = candidate else { return false }
        
        let url = URL(fileURLWithPath: candidate)
        let pathExtention = url.pathExtension

        if ValidationService.imageExtensions.contains(pathExtention) {
            return true
        } 
        
        return false
    }
}
