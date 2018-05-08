import UIKit

extension UILabel {
    func applyStyle(font: UIFont, textColor: UIColor) {
        self.font = font
        self.textColor = textColor
    }
}

func applyStyle(font: UIFont, textColor: UIColor, to labels: UILabel...) {
    labels.forEach { $0.applyStyle(font: font, textColor: textColor) }
}
