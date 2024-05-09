//
//  PhotoCellCollectionViewCell.swift
//  SwiftGallery
//
//  Created by Irinka Datoshvili on 08.05.24.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotoCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var viewModel: PhotoCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with viewModel: PhotoCellViewModel) {
        self.viewModel = viewModel
        self.imageView.image = nil
        
        viewModel.loadImage { [weak self] imageData in
            if let imageData = imageData, let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
}



