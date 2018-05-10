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
    
    init(_ link: LinkResponseItem.LinkData) {
        id = link.id
        name = link.name
        author = link.author
        created = Date(timeIntervalSince1970: TimeInterval(link.created_utc))
        title = link.title
        commentCount = link.num_comments
        thumbnail = link.thumbnail
        url = link.url
    }
    
}

extension LinkViewModel {
    enum LinkType {
        case text, media
    }
    
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
