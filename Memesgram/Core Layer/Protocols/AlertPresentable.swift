import Foundation
import UIKit

protocol ErrorAlertPresentable {
    func showError(title: String?, message: String?)
}

extension ErrorAlertPresentable where Self: UIViewController {
    func showError(title: String?, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: UIAlertActionStyle.default,
                                                handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
