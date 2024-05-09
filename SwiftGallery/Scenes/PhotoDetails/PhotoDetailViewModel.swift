//
//  PhotoDetailViewModel.swift
//  SwiftGallery
//
//  Created by Irinka Datoshvili on 08.05.24.
//

import Foundation

class PhotoDetailViewModel {
    // MARK: - Properties
    var photoURLs: [URL]
    var selectedPhotoIndex: Int
    
    // MARK: - Computed Property
    var photoCount: Int {
        return photoURLs.count
    }
    
    // MARK: - Initialization
    init(photoURLs: [URL], selectedPhotoIndex: Int) {
        self.photoURLs = photoURLs
        self.selectedPhotoIndex = selectedPhotoIndex
    }
}
