//
//  GalleryViewController+Extention.swift
//  SwiftGallery
//
//  Created by Irinka Datoshvili on 09.05.24.
//

import Foundation
import UIKit

extension GalleryViewController: GalleryViewModelDelegate {
    // MARK: - Gallery View Model Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPhotoURL = viewModel.photoURL(at: indexPath)
        viewModel.didSelectPhoto(with: selectedPhotoURL)
    }
    
    func didUpdateSnapshot(_ snapshot: DiffableSnapshot<Int, URL>) {
        var nsSnapshot = NSDiffableDataSourceSnapshot<Int, URL>()
        for section in snapshot.sections {
            nsSnapshot.appendSections([section.identifier])
            nsSnapshot.appendItems(section.items, toSection: section.identifier)
        }
        dataSource.apply(nsSnapshot, animatingDifferences: true)
    }
    
    func didSelectPhoto(with photoURL: URL) {
        guard let selectedPhotoIndex = viewModel.photoURLs.firstIndex(of: photoURL) else {
            return
        }
        let photoDetailVC = PhotoDetailViewController(photoURLs: viewModel.photoURLs, selectedPhotoIndex: selectedPhotoIndex)
        
        // kai ramea smooth transitionistvis
        UIView.transition(with: navigationController!.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.navigationController?.pushViewController(photoDetailVC, animated: false)
        }, completion: nil)
    }
    
    func photosFetched() {
        var snapshot = DiffableSnapshot<Int, URL>()
        snapshot.appendSection(DiffableSnapshot.Section(identifier: 0, items: viewModel.photoURLs))
        didUpdateSnapshot(snapshot)
    }
}
