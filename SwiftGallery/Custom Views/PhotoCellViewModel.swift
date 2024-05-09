//
//  PhotoCellViewModel.swift
//  SwiftGallery
//
//  Created by Irinka Datoshvili on 09.05.24.
//

import Foundation

class PhotoCellViewModel {
    // MARK: - Properties
    let photoURL: URL
    var imageData: Data?
    
    // MARK: - Initialization
    init(photoURL: URL) {
        self.photoURL = photoURL
    }
    
    // MARK: - Image Loading
    func loadImage(completion: @escaping (Data?) -> Void) {
        if let cachedImageData = imageData {
            completion(cachedImageData)
            return
        }
        
        URLSession.shared.dataTask(with: photoURL) { [weak self] (data, _, _) in
            guard let imageData = data else {
                completion(nil)
                return
            }
            
            self?.imageData = imageData
            completion(imageData)
        }.resume()
    }
}
