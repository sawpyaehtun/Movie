//
//  ViewController.swift
//  Movie
//
//  Created by saw pyaehtun on 25/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class MovieViewController: BaseViewController {
    
    @IBOutlet weak var collectionViewMovieList: UICollectionView!
    
    let numberOfItemsInRow : CGFloat = 3.0
    let spacing : CGFloat = 10
    let leadingSpace : CGFloat = 10
    let TrailingSpace : CGFloat = 10
    var viewModel = MovieViewModel()
    var movieList : [MovieVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print(MovieAPI.movie.urlString())
        fetchTopRatedMovie()
    }
    
    override func setUpUIs() {
        super.setUpUIs()
        setUpCollectionView()
    }
    
    private func setUpCollectionView(){
        collectionViewMovieList.delegate = self
        collectionViewMovieList.dataSource = self
        
        collectionViewMovieList.registerForCell(strID: String(describing: MoviePosetCollectionViewCell.self))
        
        let layout = collectionViewMovieList.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        // calculating total padding
        let totalPadding : CGFloat = (numberOfItemsInRow * spacing) + leadingSpace + TrailingSpace
        let itemWidth = (self.view.frame.width - totalPadding) / numberOfItemsInRow
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.45)
    }
    
    private func fetchTopRatedMovie(){
        if NerworkClient.checkReachable() == false {
            viewModel.getMovie {
//                self.collectionViewMovieList.reloadData()
            }
        } else {
            viewModel.fetchMovie {
//                self.collectionViewMovieList.reloadData()
            }
        }
    }
    
    override func bindModel() {
        viewModel.movieList.subscribe(onNext: { (movieVOs) in
            self.movieList = movieVOs
            self.collectionViewMovieList.reloadData()
        }).disposed(by: disposableBag)
    }
    
    override func bindData() {
        viewModel.bindViewModel(in: self)
    }
}

extension MovieViewController : UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController.init()
        vc.movieVO = movieList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MoviePosetCollectionViewCell.self), for: indexPath) as? MoviePosetCollectionViewCell
        item?.movieVO = movieList[indexPath.row]
        return item!
    }
    
}
