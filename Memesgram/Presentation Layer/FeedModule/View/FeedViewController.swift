import UIKit

class FeedViewController: UIViewController {

    var output: FeedViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - Actions
    // TODO: - remove
    
    @IBAction func requestLinksAction(_ sender: Any) {
        output.didRequestLinksAction()
    }
    
}

extension FeedViewController: FeedViewInput {}


