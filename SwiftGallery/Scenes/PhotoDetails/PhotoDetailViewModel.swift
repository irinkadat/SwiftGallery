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
}


