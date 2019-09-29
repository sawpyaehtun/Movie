//
//  MovieVO+Extension.swift
//  Movie
//
//  Created by saw pyaehtun on 28/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

extension MovieVO{
    func toMovieCDE() -> MovieCDE{
        let movieCDE = MovieCDE(context: PersistenceManager.shared.persistanceContainer.viewContext)
        movieCDE.popularity = self.popularity ?? 0
                movieCDE.voteCount = Int32(self.voteCount ?? 0)
                movieCDE.video = self.video ?? false
                movieCDE.posterPath = self.posterPath
                movieCDE.id = Int32(self.id ?? 0)
                movieCDE.adult = self.adult ?? false
                movieCDE.backdropPath = self.backdropPath
                movieCDE.originalTitle = self.originalTitle
                movieCDE.originalLanguae = self.originalLanguage
        //        movieCDE.addToGenre(NSSet(object: movieVO.genreIds as Any))
                movieCDE.title = self.title
                movieCDE.voteAverage = self.voteAverage ?? 0
                movieCDE.overView = self.overview
                movieCDE.releaseDate = self.releaseDate
                movieCDE.budget = Int32(self.budget ?? 0)
                movieCDE.homePage = self.homepage
                movieCDE.imdbId = self.imdbId
                movieCDE.revenue = Int32(self.revenue ?? 0)
                movieCDE.runtime = Int16(self.runtime ?? 0)
                self.genreIds?.forEach({ (id) in
                    movieCDE.addToGenre(GenreModel.shared.getGenreCDEById(genreId: id)!)
                })
        return movieCDE
    }
}
