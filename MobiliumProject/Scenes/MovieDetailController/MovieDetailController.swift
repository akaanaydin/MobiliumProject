//
//  MovieDetailController.swift
//  MobiliumProject
//
//  Created by Arslan Kaan AYDIN on 19.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class MovieDetailController: UIViewController {
    
    private var detailResults: MovieDetailModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let imdbButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "imdb"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private let starImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .orange
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let imdbVoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    init(detailResults: MovieDetailModel) {
        self.detailResults = detailResults
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeScrollView()
        makeContentView()
        makeImageView()
        makeImdbImageView()
        makeStarImageView()
        makeImdbVoteLabel()
        makeReleaseDateLabel()
        makeMovieNameLabel()
        makeMovieOverviewLabel()
    }
    
    private func configure() {
        subviews()
        drawDesign()
        fetchDatas()
    }
    
    private func drawDesign() {
        view.backgroundColor = .white
    }
    
    private func fetchDatas() {
        let urlImage = URL(string: Constant.NetworkConstant.MovieServiceEndPoint.IMAGE_BASE_URL.rawValue + (detailResults.posterPath ?? ""))
        imageView.kf.setImage(with: urlImage)
        
        guard let vote = detailResults.voteAverage else { return }
        imdbVoteLabel.text = "\(vote)/10"
        
        guard let date = detailResults.releaseDate else { return }
        releaseDateLabel.text = "\(date)"
        
        guard let name = detailResults.title else { return }
        movieNameLabel.text = name
        
        guard let overview = detailResults.overview else { return }
        movieOverviewLabel.text = overview
    }
    
    private func subviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(movieOverviewLabel)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(imdbVoteLabel)
        contentView.addSubview(imdbButton)
        contentView.addSubview(starImageView)
    }
    
    @objc func buttonTapped()
    {
        guard let imdbID = detailResults.imdbID else { return }
        guard let url = URL(string: "https://www.imdb.com/title/\(imdbID)") else { return }
        UIApplication.shared.open(url)
    }
    
    
}

extension MovieDetailController {
    
    private func makeScrollView() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func makeContentView() {
        contentView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(1000)
        }
    }
    
    private func makeImageView() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    private func makeImdbImageView() {
        imdbButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.left.equalTo(imageView.snp.left).offset(15)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
    }
    
    private func makeStarImageView() {
        starImageView.snp.makeConstraints { make in
            make.centerY.equalTo(imdbButton)
            make.left.equalTo(imdbButton.snp.right).offset(10)
        }
    }
    private func makeImdbVoteLabel() {
        imdbVoteLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImageView)
            make.left.equalTo(starImageView.snp.right).offset(10)
        }
    }
    
    private func makeReleaseDateLabel() {
        releaseDateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imdbVoteLabel)
            make.left.equalTo(imdbVoteLabel.snp.right).offset(10)
        }
    }
    
    private func makeMovieNameLabel() {
        movieNameLabel.snp.makeConstraints { make in
            make.left.equalTo(imdbButton)
            make.right.equalTo(imageView).inset(15)
            make.top.equalTo(imdbButton.snp.bottom).offset(15)
        }
    }
    
    private func makeMovieOverviewLabel() {
        movieOverviewLabel.snp.makeConstraints { make in
            make.left.equalTo(movieNameLabel)
            make.right.equalTo(movieNameLabel)
            make.top.equalTo(movieNameLabel.snp.bottom).offset(15)
        }
    }
    
}
