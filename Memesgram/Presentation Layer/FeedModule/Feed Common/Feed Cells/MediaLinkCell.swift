import UIKit

class MediaLinkCell: TextLinkCell {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var saveButton: UIButton!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Overriding
    
    override func setupElements() {
        super.setupElements()
        activityIndicator.color = .headlineColor
        saveButton.setTitleColor(.headlineColor, for: .normal)
        saveButton.titleLabel?.font = .medium
    }
    
    override func renderLink(_ link: LinkViewModel) {
        super.renderLink(link)
        print("download image")
    }
    
    // MARK: - Actions
    
    @IBAction private func openMediaAction(_ sender: Any) {
        print(#function)
    }
    
    @IBAction private func saveMediaAction(_ sender: Any) {
        print(#function)
    }
}
