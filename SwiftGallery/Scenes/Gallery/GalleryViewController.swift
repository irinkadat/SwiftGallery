//
//  ViewController.swift
//  SwiftGallery
//
//  Created by Irinka Datoshvili on 08.05.24.
//

import UIKit

class GalleryViewController: UICollectionViewController {
    private var viewModel: GalleryViewModel!
    private var dataSource: UICollectionViewDiffableDataSource<Int, URL>!
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        setupDataSource()
    }
    
    private func setupUI() {
        title = "Gallery"
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func setupViewModel() {
        viewModel = GalleryViewModel()
        viewModel.delegate = self
        viewModel.fetchPhotos()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let itemWidth = (collectionView.bounds.width - 2) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, URL>(collectionView: collectionView) { (collectionView, indexPath, photoURL) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
            cell.configure(with: photoURL)
            return cell
        }
    }
}

extension GalleryViewController: GalleryViewModelDelegate {
    
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




