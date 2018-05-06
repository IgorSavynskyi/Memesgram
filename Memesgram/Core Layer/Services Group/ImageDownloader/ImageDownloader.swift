import Foundation
import UIKit

enum MediaDownloadError: Error {
    case imageFailedToDecode
}

typealias DownloadCompletion = (UIImage?, Error?) -> Void

class ImageDownloader {
    static let defaultSession = ImageDownloader.makeDefaultSession()
    
    private var completion: DownloadCompletion?
    private var session = URLSession.shared
    private var currentTask: URLSessionDataTask?
    
    // MARK: - API
    
    func downloadImage(from url: URL, completion: @escaping DownloadCompletion) {
        self.completion = completion
        
        currentTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if error == nil {
                if let data = data, let image = UIImage(data: data) {
                    completion(image, nil)
                } else {
                    completion(nil, MediaDownloadError.imageFailedToDecode)
                }
            } else {
                completion(nil, error)
            }
        })
        
        currentTask?.resume()
    }
    
    func cancelDownload() {
        self.completion = nil
        currentTask?.cancel()
    }
    
    // MARK: - Private API
    
    static private func makeDefaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration)
    }
}
