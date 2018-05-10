import UIKit

enum TextCellLayout {
    static let fixedHeight: CGFloat = 140
    static let titleTextShrinkage: CGFloat = 32
    static let titleFont = UIFont.header
}

class TextLinkCell: UICollectionViewCell {
    @IBOutlet weak private var authorLabel: UILabel!
    @IBOutlet weak private var bulletLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var commentsLabel: UILabel!
    
    var link: LinkViewModel? { didSet { updateUI() }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupElements()
    }
    
    // MARK: - API
    
    func setupElements() {
        titleLabel.applyStyle(font: .header, textColor: .textColor)
        applyStyle(font: .medium, textColor: .textColor, to: authorLabel, bulletLabel, timeLabel, commentsLabel)
    }
    
    func updateUI() {
        guard let link = link else { return }
        authorLabel.text = link.author
        timeLabel.text = timeAgo(from: link.created)
        titleLabel.text = link.title
        commentsLabel.text = "\(link.commentCount) comments"
    }
    
    // MARK: - Private API
    
    private func timeAgo(from date: Date) -> String {
        let now = Date()
        let days = now.days(from: date)
        let hours = now.hours(from: date)
        if days >= 1 {
            return "\(days)" + "d"
        } else if hours > 0 {
            return "\(hours)" + "h"
        } else {
            return "a moment ago"
        }
    }
}



