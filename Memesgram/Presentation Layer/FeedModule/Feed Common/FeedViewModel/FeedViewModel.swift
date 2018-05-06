import Foundation

struct LinkViewModel {
    var id: String
    var name: String
    var author: String
    var created: Date
    var title: String
    var commentCount: Int
    var thumbnail: String?
    var url: String?
    
    var type: LinkType {
        if ValidationService.shared.isValidURL(thumbnail) {
            return .media
        } else {
            return .text
        }
    }
    
    var hasImageToDownload: Bool {
        return ValidationService.shared.isImageUrl(url)
    }
}

// MARK: - Nested Types

extension LinkViewModel {
    enum LinkType {
        case text, media
    }
}
