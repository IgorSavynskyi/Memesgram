import Foundation
import UIKit
import AudioToolbox.AudioServices

class ApplicationService {
    static let shared = ApplicationService()
    private init() {}
    
    var isLandscape: Bool { return UIDevice.current.orientation.isLandscape }
    var showNetworkActivity = false { didSet { showNetworkActivityIndicator(showNetworkActivity) }}

    // MARK: - API
    
    func vibrate() {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, nil)
    }
    
    // MARK: - Private API
    
    private func showNetworkActivityIndicator(_ value: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = value
        }
    }
}
