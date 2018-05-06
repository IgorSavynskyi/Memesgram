import UIKit

class FeedViewController: UIViewController {
    @IBOutlet weak private var collectionView: UICollectionView!
    
    var output: FeedViewOutput!
    lazy private var feedDisplay = FeedDisplayManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: - Actions
    // TODO: - remove
    
    @IBAction func requestLinksAction(_ sender: Any) {
        output.didRequestLinksAction()
    }
    
}

// MARK: - FeedViewInput
extension FeedViewController: FeedViewInput {
    func setupInitialState() {
        view.backgroundColor = .headlineColor
        feedDisplay.collectionView = collectionView
    }
    
    func renderLinks(_ links: [LinkViewModel]) {
        feedDisplay.renderLinks(links)
    }
}


