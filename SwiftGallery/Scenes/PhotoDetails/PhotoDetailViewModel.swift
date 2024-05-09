//
//  PhotoDetailViewModel.swift
//  SwiftGallery
//
//  Created by Irinka Datoshvili on 08.05.24.
//

import Foundation

class PhotoDetailViewModel {
    var photoURLs: [URL]
    var selectedPhotoIndex: Int
    
    var photoCount: Int {
        return photoURLs.count
    }
    
    init(photoURLs: [URL], selectedPhotoIndex: Int) {
        self.photoURLs = photoURLs
        self.selectedPhotoIndex = selectedPhotoIndex
    }
    
    func loadSelectedPhoto() -> URL? {
        guard selectedPhotoIndex >= 0 && selectedPhotoIndex < photoURLs.count else { return nil }
        return photoURLs[selectedPhotoIndex]
    }
}


