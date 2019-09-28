//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by saw pyaehtun on 27/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var lblOverView: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    var movieVO : MovieVO?
    let viewModel = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
    }
    
    override func setUpNavigationBar() {
        let backItem = UIBarButtonItem()
        backItem.title = movieVO?.title
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        
        let closeButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "bookmark"), style: .plain, target: self, action: #selector(didTapBookMark(sender:)))
        
        viewModel.getBookMarkIDList { (bookmarkIDLsit) in
            closeButtonItem.tintColor = bookmarkIDLsit.contains((self.movieVO?.id)!) ? .blue : .white
        }
        
        navigationItem.rightBarButtonItems = [closeButtonItem]
    }
    
    @objc func didTapBookMark(sender : Any){
        let closeButtonItem = sender as! UIBarButtonItem
        if closeButtonItem.tintColor == .white {
            viewModel.addToBookMark(bookmarkVO: BookMarkVO(id: movieVO?.id, movie: movieVO)) {
                closeButtonItem.tintColor = .blue
            }
        } else {
            viewModel.deleteFromBookMark(id: (movieVO?.id)!) {
                 closeButtonItem.tintColor = .white
            }
        }
    }

    override func setUpUIs() {
        lblOverView.text = movieVO?.overview
        lblReleaseDate.text = movieVO?.releaseDate
        var geners = ""
        movieVO?.genreVOs?.forEach({ (genreVO) in
            geners += "\(genreVO.name ?? "")\n"
        })
        lblGenres.text = geners
        lblRating.text = "\(movieVO?.voteAverage ?? 0)"
    }

}
