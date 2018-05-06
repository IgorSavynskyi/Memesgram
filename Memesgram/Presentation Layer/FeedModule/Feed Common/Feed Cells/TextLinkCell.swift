import UIKit

class TextLinkCell: UICollectionViewCell {
    @IBOutlet weak private var authorLabel: UILabel!
    @IBOutlet weak private var bulletLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var commentsLabel: UILabel!
    
    var link: LinkViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupElements()
    }
    
    // MARK: - API
    
    func setupElements() {
        authorLabel.applyStyle(font: .medium, textColor: .textColor)
        bulletLabel.applyStyle(font: .medium, textColor: .textColor)
        timeLabel.applyStyle(font: .medium, textColor: .textColor)
        titleLabel.applyStyle(font: .header, textColor: .textColor)
        commentsLabel.applyStyle(font: .medium, textColor: .textColor)
    }
    
    func renderLink(_ link: LinkViewModel) {
        self.link = link
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
