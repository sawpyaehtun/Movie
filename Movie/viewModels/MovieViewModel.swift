//
//  MovieViewModel.swift
//  Movie
//
//  Created by saw pyaehtun on 27/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class MovieViewModel : BaseViewModel {
    
    var movieList = BehaviorRelay<[MovieVO]>(value: [])
    
    func fetchMovie(success : @escaping () -> Void) {
        loadingObservable.accept(true)
        MovieModel.shared.fetchMovie(success: { moivieVOs in
            print(moivieVOs.count)
            self.loadingObservable.accept(false)
            self.movieList.accept(moivieVOs)
            success()
        }) { (err) in
            self.loadingObservable.accept(false)
            print(err)
        }
    }
    
    func getMovie(success : @escaping () -> Void) {
        movieList.accept(MovieModel.shared.getMovie())
        success()
    }
    
}
