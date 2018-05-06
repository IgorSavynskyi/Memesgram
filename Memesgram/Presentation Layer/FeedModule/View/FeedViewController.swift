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
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        var ip: IndexPath?
        if let topCell = collectionView?.visibleCells.first {
            ip = collectionView?.indexPath(for: topCell)
        }
        
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionView?.collectionViewLayout.invalidateLayout()
        }) { (context) in
            if let ip = ip {
                self.collectionView?.scrollToItem(at: ip, at: .top, animated: true)
            }
        }
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


