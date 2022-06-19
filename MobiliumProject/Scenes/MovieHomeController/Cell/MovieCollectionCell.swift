//
//  MovieCollectionCell.swift
//  MobiliumProject
//
//  Created by Arslan Kaan AYDIN on 19.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class MovieCollectionCell: UICollectionViewCell {
    
    enum Identifier: String {
        case custom = "MovieCollectionCell"
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        subviews()
        drawDesign()
        makeImageView()
        makeMovieNameLabel()
        makeMovieOverviewLabel()
    }
    
    private func drawDesign() {
    }
    
    private func subviews() {
        addSubview(imageView)
        addSubview(movieNameLabel)
        addSubview(movieOverviewLabel)
    }
    
    func saveModel(model: NowPlayingMovieModelResult) {
        movieNameLabel.text = model.title
        movieOverviewLabel.text = model.overview
        imageView.kf.setImage(with: URL(string: Constant.NetworkConstant.MovieServiceEndPoint.IMAGE_BASE_URL.rawValue + (model.posterPath ?? "")))
    }
}

extension MovieCollectionCell {
    private func makeImageView() {
        imageView.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
    }
    
    private func makeMovieNameLabel() {
        movieNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(imageView.snp.centerY).offset(15)
            make.height.equalTo(25)
        }
    }
    
    private func makeMovieOverviewLabel() {
        movieOverviewLabel.snp.makeConstraints { make in
            make.left.equalTo(movieNameLabel)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(movieNameLabel.snp.bottom).offset(5)
//            make.bottom.equalTo(imageView.snp.bottom).inset(15)
        }
    }
}
