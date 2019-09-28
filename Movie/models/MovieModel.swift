//
//  MovieModel.swift
//  Movie
//
//  Created by saw pyaehtun on 26/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

final class MovieModel: BaseViewModel {
    
    static let shared = MovieModel()
    
    func fetchMovie(pageId : Int = 1, success : @escaping ([MovieVO]) -> Void, faulire: @escaping (String) -> Void) {
        
        GenreModel.shared.getGenreList { (genreVOs) in
            if genreVOs.isEmpty{
                GenreModel.shared.fetchGeners(success: { (genreVOs) in
                    print(genreVOs.count)
                }) { (err) in
                    print(err)
                }
            }
        }
        
        NerworkClient.shared.getData(url: MovieAPI.movie.urlStringWithPageID()+"\(pageId)", success: { (data) in
            guard let data = data as? Data else { return }
            let json = JSON(data)
            let value = json["results"]
            let jsonString = value.rawString()
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let movieList = try
                    decoder.decode([MovieVO].self, from: Data(jsonString!.utf8))
                self.addToCoreData(movieVOs: movieList)
                let movieVOs = self.getMovie()
                success(movieVOs)
            } catch let jsonError{
                print(jsonError)
                faulire(jsonError.localizedDescription)
            }
        }) { (err) in
            print("fail fatching top rated movies due to \(err)")
            faulire(err)
        }
    }
    
    func getMovie()-> [MovieVO]{
         guard let movieCDEs = PersistenceManager.shared.getData(classType: ClassType.MovieCDE) as? [MovieCDE] else {return []}
        return movieCDEs.toMovieVOs()
    }
    
    func addToCoreData(movieVO : MovieVO) {
        movieVO.toMovieCDE()
        PersistenceManager.shared.saveContext()
    }
    
    func addToCoreData(movieVOs : [MovieVO]) {
        movieVOs.forEach { (movieVO) in
            addToCoreData(movieVO: movieVO)
        }
    }
    
    
    func getMovieCDEById(movieID : Int) -> MovieCDE? {
        let fetchRequest : NSFetchRequest<MovieCDE> = MovieCDE.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", movieID)
        fetchRequest.predicate = predicate
        
        do {
            let data = try PersistenceManager.shared.persistanceContainer.viewContext.fetch(fetchRequest)
            if data.isEmpty {
                return nil
            }
            return data[0]
        } catch {
            print("failed to fetch movie genre vo \(error.localizedDescription)")
            return nil
        }
    }
}
