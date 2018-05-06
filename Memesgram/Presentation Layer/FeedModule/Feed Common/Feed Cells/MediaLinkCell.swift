import UIKit

class MediaLinkCell: TextLinkCell {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var saveButton: UIButton!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    private var isIndicatorActive = false {
        didSet {
            DispatchQueue.main.async {
                if self.isIndicatorActive {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    lazy private var downloader = ImageDownloader()
    
    // MARK: - Overriding
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloader.cancelDownload()
        imageView.image = nil
        isIndicatorActive = false
    }
    
    override func setupElements() {
        super.setupElements()
        activityIndicator.color = .headlineColor
        saveButton.setTitleColor(.headlineColor, for: .normal)
        saveButton.titleLabel?.font = .medium
    }
    
    override func renderLink(_ link: LinkViewModel) {
        super.renderLink(link)
        
        if let thumb = link.thumbnailUrl {
            downloadMedia(thumb)
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func openMediaAction(_ sender: Any) {
        print(#function)
    }
    
    @IBAction private func saveMediaAction(_ sender: Any) {
        print(#function)
    }
    
    // MARK: - Private API
    
    private func downloadMedia(_ url: String) {
        guard let url = URL.init(string: url) else { return }
        
        isIndicatorActive = true
        downloader.downloadImage(from: url) {[weak self] (image, error) in
            if let image = image {
                self?.setMedia(image)
            }
            self?.isIndicatorActive = false
        }
    }
    
    private func setMedia(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
