//
//  MovieTableCell.swift
//  MobiliumProject
//
//  Created by Arslan Kaan AYDIN on 19.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class MovieTableCell: UITableViewCell {
    
    // MARK: - Identifier
    enum Identifier: String {
        case custom = "cellIdentifier"
    }
    //MARK: - UI Elements

    private let movieImage: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    private let cellRightArrow: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = .lightGray
        return iv
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    
    private let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func configure() {
        subviews()
        drawDesign()
        makeMovieImage()
        makeCellRightArrow()
        makeMovieNameLabel()
        makeReleaseDateLabel()
        makeMovieOverviewLabel()
    }
    
    private func drawDesign() {
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.05)
    }
    
    private func subviews() {
        contentView.addSubview(movieImage)
        contentView.addSubview(cellRightArrow)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(movieOverviewLabel)

    }
    //MARK: - Datas for Cell
    func saveMovieModel(model: UpComingMovieModelResult) {
        // Release Date
        releaseDateLabel.text = model.releaseDate
        // Overview
        movieOverviewLabel.text = model.overview
        // Movie Name
        movieNameLabel.text = model.title
        // Movie Image
        movieImage.kf.setImage(with: URL(string: Constant.NetworkConstant.MovieServiceEndPoint.IMAGE_BASE_URL.rawValue + (model.posterPath ?? "")))
    }
    
}
    //MARK: - SnapKit Extensions
extension MovieTableCell {
    
    private func makeMovieImage() {
        movieImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalTo(contentView.snp.bottom).inset(15)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.width.equalTo(contentView).multipliedBy(0.32)
        }
    }
    
    private func makeCellRightArrow() {
        cellRightArrow.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalToSuperview().inset(15)
//            make.width.equalTo(20)
            make.height.equalTo(25)
        }
    }
    
    private func makeMovieNameLabel() {
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.top).offset(10)
            make.left.equalTo(movieImage.snp.right).offset(10)
            make.right.equalTo(cellRightArrow.snp.left)
            make.height.equalTo(30)
        }
    }
    
    private func makeReleaseDateLabel() {
        releaseDateLabel.snp.makeConstraints { make in
            make.right.equalTo(cellRightArrow.snp.left)
            make.bottom.equalTo(movieImage.snp.bottom)
        }
    }
    
    private func makeMovieOverviewLabel() {
        movieOverviewLabel.snp.makeConstraints { make in
            make.left.equalTo(movieImage.snp.right).offset(10)
            make.centerY.equalTo(contentView)
            make.right.equalTo(cellRightArrow.snp.left)
            
        }
    }
}
