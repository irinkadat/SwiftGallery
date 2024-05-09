//
//  GalleryViewModel.swift
//  SwiftGallery
//
//  Created by Irinka Datoshvili on 08.05.24.
//

import Foundation
import UnsplashAPI

protocol GalleryViewModelDelegate: AnyObject {
    func photosFetched()
    func didUpdateSnapshot(_ snapshot: DiffableSnapshot<Int, URL>)
    func didSelectPhoto(with photoURL: URL)
}

class GalleryViewModel {
    weak var delegate: GalleryViewModelDelegate?
    private(set) var photoURLs: [URL] = []
    
    func fetchPhotos() {
        let unSplashAPI = UnsplashAPI(apiKey: "_9w7vKs408HsVOqtAQqEzJa06tkv-jwqE068hoHYKqk")
        unSplashAPI.fetchPhotos(page: 1, perPage: 150) { photos, error in
            guard let photos = photos else {
                print("Failed to fetch photos:", error?.localizedDescription ?? "Unknown error")
                return
            }
            self.photoURLs = photos.map { $0.urls.regular }
            var snapshot = DiffableSnapshot<Int, URL>()
            snapshot.appendSection(DiffableSnapshot.Section(identifier: 0, items: self.photoURLs))
            self.delegate?.didUpdateSnapshot(snapshot)
            self.delegate?.photosFetched()
        }
    }
    
    func didSelectPhoto(with photoURL: URL) {
        delegate?.didSelectPhoto(with: photoURL)
    }
    
    var numberOfPhotos: Int {
        return photoURLs.count
    }
    
    func photoURL(at indexPath: IndexPath) -> URL {
        return photoURLs[indexPath.item]
    }
}
