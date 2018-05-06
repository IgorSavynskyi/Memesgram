import Foundation
import UIKit

class FeedDisplayManager: NSObject {
    private var dataSource: [LinkViewModel] = []
    var collectionView: UICollectionView? {
        didSet {
            setupCollectionView()
        }
    }
    
    // MARK: - API
    
    func renderLinks(_ links: [LinkViewModel]) {
        dataSource.append(contentsOf: links)
        DispatchQueue.main.async {
            self.collectionView?.reloadData()                // TODO: - update gracefully
        }
    }
    
    // MARK: - Private API
    
    func setupCollectionView() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension FeedDisplayManager: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let link = dataSource[indexPath.item]
        switch link.type {
        case .text:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextLinkCell.defaultReuseIdentifier, for: indexPath) as! TextLinkCell
            cell.renderLink(link)
            return cell
        case .media:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaLinkCell.defaultReuseIdentifier, for: indexPath) as! MediaLinkCell
            cell.renderLink(link)
            return cell
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedDisplayManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let link = dataSource[indexPath.item]

        switch link.type {
        case .text:
            return CGSize.init(width: collectionView.bounds.width, height: 200)
        case .media:
            return CGSize.init(width: collectionView.bounds.width, height: 400)
        }
    }
}

