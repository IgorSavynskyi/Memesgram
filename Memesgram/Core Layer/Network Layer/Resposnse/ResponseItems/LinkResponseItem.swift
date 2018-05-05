import Foundation

struct LinkResponseItem: Codable {
    var kind: String
    var data: ItemData
}

// MARK: - Nested Types
extension LinkResponseItem {
    struct ItemData: Codable {
        var before: String?
        var after: String?                // t3_5gn8ru
        var children: [LinkChildren]
    }
    
    struct LinkChildren: Codable {
        var kind: String                 // t3
        var data: LinkData
    }
    
    struct LinkData: Codable {
        var id: String                   // 5gn8ru
        var title: String
        var thumbnail: String
        var url: String?
        var name: String                // t3_5gn8ru
        var author: String
        var created_utc: Int
        var num_comments: Int
    }
}
