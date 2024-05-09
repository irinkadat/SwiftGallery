//
//  PhotoDetailViewController.swift
//  SwiftGallery
//
//  Created by Irinka Datoshvili on 08.05.24.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    var viewModel: PhotoDetailViewModel
    var selectedPhotoIndex: Int
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, URL>!
    private var collectionView: UICollectionView!
    
    init(photoURLs: [URL], selectedPhotoIndex: Int) {
        self.viewModel = PhotoDetailViewModel(photoURLs: photoURLs, selectedPhotoIndex: selectedPhotoIndex)
        self.selectedPhotoIndex = selectedPhotoIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureDataSource()
        scrollToSelectedPhoto()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, URL>(collectionView: collectionView) { collectionView, indexPath, photoURL in
            let photoCellViewModel = PhotoCellViewModel(photoURL: photoURL)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
            cell.configure(with: photoCellViewModel)
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, URL>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.photoURLs)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func scrollToSelectedPhoto() {
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath(item: selectedPhotoIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
}





