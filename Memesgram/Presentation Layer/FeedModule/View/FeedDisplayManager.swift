import Foundation
import UIKit

class FeedDisplayManager: NSObject {
    weak var delegate: FeedDisplayDelegate?
    var collectionView: UICollectionView? { didSet { setupCollectionView() }}
    var observePagination: Bool?
    
    private var dataSource: [LinkViewModel] = []
    private var itemsReserve = 4

    // MARK: - API
    
    func renderLinks(_ links: [LinkViewModel]) {
        let beforeUpdateCount = dataSource.count
        dataSource.append(contentsOf: links)
        
        DispatchQueue.main.async {
            self.collectionView?.performBatchUpdates({
                let insertIndexPaths = Array(beforeUpdateCount...self.dataSource.count - 1).map { IndexPath(item: $0, section: 0) }
                self.collectionView?.insertItems(at: insertIndexPaths)
            }, completion: nil)
        }
    }
    
    // MARK: - Private API
    
    private func setupCollectionView() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension FeedDisplayManager: UICollectionViewDataSource {
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

// MARK: - UICollectionViewDelegate

extension FeedDisplayManager: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if observePagination == true, dataSource.count - indexPath.item < itemsReserve {
            delegate?.lackOfItemsSignal()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedDisplayManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let link = dataSource[indexPath.item]
        let height: CGFloat

        let columns: CGFloat = ApplicationService.shared.isLandscape ? 2 : 1
        let cellSpacing: CGFloat = ApplicationService.shared.isLandscape ? 10 : 0
        let availableWidth = ApplicationService.shared.isLandscape ? max(collectionView.bounds.width, collectionView.bounds.height)
                                                                   : min(collectionView.bounds.width, collectionView.bounds.height)
        
        let width = (availableWidth - cellSpacing)/max(columns, 1)
        
        switch link.type {
        case .text:
            height = LayoutEstimationEngine.linkCellEstimatedHeight(with: link.title,
                                                                    titleWidth: width - TextCellLayout.titleTextShrinkage,
                                                                    font: TextCellLayout.titleFont,
                                                                    baseHeight: TextCellLayout.fixedHeight)
            
        case .media:
            height = LayoutEstimationEngine.linkCellEstimatedHeight(with: link.title,
                                                                    titleWidth: width - MediaCellLayout.titleTextShrinkage,
                                                                    font: MediaCellLayout.titleFont,
                                                                    baseHeight: MediaCellLayout.fixedHeight)
        }
        
        return CGSize(width: width, height: height)
    }
}

