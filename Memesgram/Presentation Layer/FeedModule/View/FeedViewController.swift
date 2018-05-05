import UIKit

class FeedViewController: UIViewController {

    var output: FeedViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

extension FeedViewController: FeedViewInput {}


