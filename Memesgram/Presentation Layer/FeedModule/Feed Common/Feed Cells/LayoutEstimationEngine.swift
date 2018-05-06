import Foundation
import UIKit

struct LayoutEstimationEngine {
    
    static func linkCellEstimatedHeight(with title: String, titleWidth: CGFloat, font: UIFont, baseHeight: CGFloat) -> CGFloat  {
        let titleHeight = title.height(withConstrainedWidth: titleWidth,
                                       font: font)
        return baseHeight + titleHeight
    }
}
