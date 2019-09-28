//
//  MovieCDE+Extension.swift
//  Movie
//
//  Created by saw pyaehtun on 28/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

extension MovieCDE {
    func toMovieVO() -> MovieVO {
        let genreIds = self.genre?.toGenerCDEs().map({ (genreCDE) -> Int in
            return Int(genreCDE.id)
        })
        let popolarity  = self.popularity
        let voteCount = Int(self.voteCount)
        let video = self.video
        let posterPath = self.posterPath
        let id = Int(self.id)
        let adult = self.adult
        let backdropPath = self.backdropPath
        let originalLanguate = self.originalLanguae
        let originalTitle = self.originalTitle
        let title = self.title
        let voteAverage = self.voteAverage
        let overView = self.overView
        let releaseDate = self.releaseDate
        let budget = Int(self.budget)
        let homePage = self.homePage
        let imdbId = self.imdbId
        let revenue = Int(self.revenue)
        let runtime = Int(self.runtime)
        let tagline = self.tagline
        
        let genreVOs = self.genre?.toGenerCDEs().toGenreVOs()
        
        return MovieVO(popularity: popolarity, voteCount: voteCount, video: video, posterPath: posterPath, id: id, adult: adult, backdropPath: backdropPath, originalLanguage: originalLanguate, originalTitle: originalTitle, genreIds: genreIds, title: title, voteAverage: voteAverage, overview: overView, releaseDate: releaseDate, budget: budget, homepage: homePage, imdbId: imdbId, revenue: revenue, runtime: runtime, tagline: tagline, genreVOs: genreVOs)
    }
}
