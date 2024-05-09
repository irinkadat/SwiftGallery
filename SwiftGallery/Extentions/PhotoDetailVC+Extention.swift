//
//  PhotoDetailVC+Extention.swift
//  SwiftGallery
//
//  Created by Irinka Datoshvili on 09.05.24.
//

import Foundation
import UIKit

extension PhotoDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
        let photoURL = viewModel.photoURLs[indexPath.item]
        let photoCellViewModel = PhotoCellViewModel(photoURL: photoURL)
        cell.configure(with: photoCellViewModel)
        return cell
    }
}


extension PhotoDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
