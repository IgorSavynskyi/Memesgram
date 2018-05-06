import Foundation

struct LinkViewModel {
    var id: String
    var name: String
    var author: String
    var created: Date
    var title: String
    var commentCount: Int
    var thumbnailUrl: String?
    var url: String?
    
    var type: LinkType {
        if thumbnailUrl == nil {
            return .text
        } else {
            return .media
        }
    }
}

// MARK: - Nested Types

extension LinkViewModel {
    enum LinkType {
        case text, media
    }
}
