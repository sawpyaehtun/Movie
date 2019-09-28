//
//  ArrayExtension.swift
//  contact-core-date
//
//  Created by saw pyaehtun on 22/09/2019.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation

extension Array {
    
    func toBookMarkVOs() -> [BookMarkVO] {
        guard let bookmarkCDEs = self as? [BookMarkCDE] else { return []}
        let bookmarkVOs = bookmarkCDEs.map { (bookmarkCDE) -> BookMarkVO in
            let id =  Int(bookmarkCDE.id)
            let movieVO =  bookmarkCDE.movie?.toMovieVO()
            return BookMarkVO(id: id, movie: movieVO)
        }
        return bookmarkVOs
    }
    
    func toGenreVOs() -> [GenreVO]{
        guard let genreCDEs = self as? [GenreCDE] else { return []}
        let genreVOs = genreCDEs.map { (genreCDE) -> GenreVO in
            let id = genreCDE.id
            let name = genreCDE.name
            return GenreVO(id: Int(id), name: name)
        }
        return genreVOs
    }
    
    func toMovieVOs() -> [MovieVO]{
        guard let movieCDEs = self as? [MovieCDE] else { return []}
        let movieVOs = movieCDEs.map { (movieCDE) -> MovieVO in
            let genreIds = movieCDE.genre?.toGenerCDEs().map({ (genreCDE) -> Int in
                return Int(genreCDE.id)
            })
            let popolarity  = movieCDE.popularity
            let voteCount = Int(movieCDE.voteCount)
            let video = movieCDE.video
            let posterPath = movieCDE.posterPath
            let id = Int(movieCDE.id)
            let adult = movieCDE.adult
            let backdropPath = movieCDE.backdropPath
            let originalLanguate = movieCDE.originalLanguae
            let originalTitle = movieCDE.originalTitle
            let title = movieCDE.title
            let voteAverage = movieCDE.voteAverage
            let overView = movieCDE.overView
            let releaseDate = movieCDE.releaseDate
            let budget = Int(movieCDE.budget)
            let homePage = movieCDE.homePage
            let imdbId = movieCDE.imdbId
            let revenue = Int(movieCDE.revenue)
            let runtime = Int(movieCDE.runtime)
            let tagline = movieCDE.tagline
            
            let genreVOs = movieCDE.genre?.toGenerCDEs().toGenreVOs()
            
            return MovieVO(popularity: popolarity, voteCount: voteCount, video: video, posterPath: posterPath, id: id, adult: adult, backdropPath: backdropPath, originalLanguage: originalLanguate, originalTitle: originalTitle, genreIds: genreIds, title: title, voteAverage: voteAverage, overview: overView, releaseDate: releaseDate, budget: budget, homepage: homePage, imdbId: imdbId, revenue: revenue, runtime: runtime, tagline: tagline, genreVOs: genreVOs)
        }
        
        return movieVOs
    }
    
}
