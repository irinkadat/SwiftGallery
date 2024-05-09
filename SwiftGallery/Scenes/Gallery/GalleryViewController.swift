//
//  ViewController.swift
//  SwiftGallery
//
//  Created by Irinka Datoshvili on 08.05.24.
//

import UIKit

class GalleryViewController: UICollectionViewController {
    // MARK: - Properties
    private(set) var viewModel: GalleryViewModel!
    private(set) var dataSource: UICollectionViewDiffableDataSource<Int, URL>!
    
    // MARK: - Initialization
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        setupDataSource()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "გალერეა"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "FiraGO-Medium", size: 32) ?? UIFont.systemFont(ofSize: 32, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor(red: 60/255, green: 121/255, blue: 241/255, alpha: 1.0)
        ]
        
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
            let photoCellViewModel = PhotoCellViewModel(photoURL: photoURL)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
            cell.configure(with: photoCellViewModel)
            
            return cell
        }
    }
}
