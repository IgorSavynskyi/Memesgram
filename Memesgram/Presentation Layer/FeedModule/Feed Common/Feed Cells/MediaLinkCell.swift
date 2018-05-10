import UIKit

enum MediaCellLayout {
    static let fixedHeight: CGFloat = 316
    static let titleTextShrinkage: CGFloat = 32
    static let titleFont = UIFont.header
}

protocol MediaLinkCellDelegate: class {
    func didOpenMediaAction(for link: LinkViewModel)
    func didSaveMediaAction(for link: LinkViewModel)
}

class MediaLinkCell: TextLinkCell {
    weak var delegate: MediaLinkCellDelegate?
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var saveButton: UIButton!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    private var isIndicatorActive = false {
        didSet { updateIndicatorState() }
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
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .header
        saveButton.backgroundColor = .headlineColor
    }
    
    override func updateUI() {
        guard let link = link else { return }
        super.updateUI()
        
        if let thumb = link.thumbnail {
            downloadMedia(thumb)
        }
        saveButton.isHidden = !link.hasImageToDownload
    }
    
    // MARK: - Actions
    
    @IBAction private func openMediaAction(_ sender: Any) {
        if let link = link {
            delegate?.didOpenMediaAction(for: link)
        }
    }
    
    @IBAction private func saveMediaAction(_ sender: Any) {
        if let link = link {
            delegate?.didSaveMediaAction(for: link)
        }
    }
    
    // MARK: - Private API
    
    private func downloadMedia(_ url: String) {
        guard let url = URL(string: url) else { return }
        
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
    
    private func updateIndicatorState() {
        DispatchQueue.main.async {
            if self.isIndicatorActive {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
