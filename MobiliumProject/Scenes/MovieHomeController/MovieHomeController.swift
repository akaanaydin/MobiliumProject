//
//  MovieHomeController.swift
//  MobiliumProject
//
//  Created by Arslan Kaan AYDIN on 19.06.2022.
//

import UIKit
import SnapKit
import Alamofire

//MARK: - Protocols
protocol MovieOutput {
    func selectedMovies(movieID: Int)
}

class MovieHomeController: UIViewController {
    //MARK: - UI Elements
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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.rowHeight = 160
        return tableView
    }()
    
    private let pageController: UIPageControl = {
        let pageController = UIPageControl()
        pageController.numberOfPages = 20
        pageController.currentPage = 0
        pageController.translatesAutoresizingMaskIntoConstraints = false
        pageController.pageIndicatorTintColor = .white
        pageController.currentPageIndicatorTintColor = .gray
        return pageController
    }()
    
    //MARK: - Properties
    private lazy var nowPlayingMovieModelResult = [NowPlayingMovieModelResult]()
    private lazy var upComingMovieModelResult = [UpComingMovieModelResult]()
    private var viewModel: MovieViewModelProtocol = MovieViewModel(service: Services())
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    //MARK: - Functions
    private func configure() {
        subviews()
        drawDesign()
        fetchUpComingMovieDatas()
        fetchNowPlayingMovieDatas()
        makeScrollView()
        makeContentView()
        makeCollectionView()
        makeTableView()
        makePageController()
    }
    
    private func drawDesign() {
        //View
        view.backgroundColor = .white
        //ViewModel
        viewModel.delegate = self
        //NavigationBar
        configureNavigationBar(largeTitleColor: .black, backgoundColor: .white, tintColor: .black, title: "Movies", preferredLargeTitle: false)
        //CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: MovieCollectionCell.Identifier.custom.rawValue)
        //TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableCell.self, forCellReuseIdentifier: MovieTableCell.Identifier.custom.rawValue)
        //ScrollView
        scrollView.delegate = self
    }
    
    private func subviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(tableView)
        contentView.addSubview(pageController)
    }
    //MARK: - Fetch Datas
    private func fetchUpComingMovieDatas() {
        viewModel.fetchUpComingMovies { [weak self] movie in
            guard let movie = movie?.results else { return }
            self?.upComingMovieModelResult = movie
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        } onError: { error in
            print(error)
        }
    }
    
    private func fetchNowPlayingMovieDatas() {
        viewModel.fetchNowPlayingMovies { [weak self] movie in
            guard let movie = movie?.results else { return }
            self?.nowPlayingMovieModelResult = movie
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        } onError: { error in
            print(error)
        }

    }
}
//MARK: - Snapkit Extension
extension MovieHomeController {
    private func makeScrollView() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func makeContentView() {
        contentView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(3460)
        }
    }
    
    private func makeCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.left.right.equalTo(collectionView)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
    
    private func makePageController() {
        pageController.snp.makeConstraints { make in
            make.centerX.equalTo(collectionView)
            make.bottom.equalTo(collectionView.snp.bottom).inset(5)
        }
    }
}
//MARK: - CollectionView Extension
extension MovieHomeController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovieModelResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MovieCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.Identifier.custom.rawValue, for: indexPath) as? MovieCollectionCell else {
            return UICollectionViewCell()
        }
        cell.saveModel(model: nowPlayingMovieModelResult[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.delegate?.selectedMovies(movieID: nowPlayingMovieModelResult[indexPath.row].id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.size.width,
            height: collectionView.frame.size.height
        )
    }
    
}

//MARK: - TableView Extension
extension MovieHomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        upComingMovieModelResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieTableCell = tableView.dequeueReusableCell(withIdentifier: MovieTableCell.Identifier.custom.rawValue) as? MovieTableCell else {
            return UITableViewCell()
        }
        cell.saveMovieModel(model: upComingMovieModelResult[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.delegate?.selectedMovies(movieID: upComingMovieModelResult[indexPath.row].id ?? 0)
    }
}

//MARK: - View Model Extension
extension MovieHomeController: MovieOutput {
    func selectedMovies(movieID: Int) {
        viewModel.getMovieDetail(movieID: movieID) { movie in
            guard let movie = movie else { return }
            self.navigationController?.pushViewController(MovieDetailController(detailResults: movie), animated: true)
        } onError: { error in
            print(error)
        }

    }
}

//MARK: - ScrollView Extension
extension MovieHomeController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageController.currentPage = Int(pageNumber)
    }
}
