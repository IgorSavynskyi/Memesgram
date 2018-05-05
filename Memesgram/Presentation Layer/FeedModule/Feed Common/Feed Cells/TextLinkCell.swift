import UIKit

class TextLinkCell: UICollectionViewCell {
    @IBOutlet weak private var authorLabel: UILabel!
    @IBOutlet weak private var bulletLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var commentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupElements()
    }

    // MARK: - Private API
    
    private func setupElements() {
        authorLabel.applyStyle(font: .medium, textColor: .textColor)
        bulletLabel.applyStyle(font: .medium, textColor: .textColor)
        bulletLabel.applyStyle(font: .medium, textColor: .textColor)
        titleLabel.applyStyle(font: .header, textColor: .textColor)
        commentsLabel.applyStyle(font: .medium, textColor: .textColor)
    }
    
}
