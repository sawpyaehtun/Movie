//
//  GenreModel.swift
//  Movie
//
//  Created by saw pyaehtun on 27/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

class GenreModel {
    
    static let shared = GenreModel()
    
    func fetchGeners(success : @escaping ([GenreVO]) -> Void, faulire: @escaping (String) -> Void) {
        NerworkClient.shared.getData(url: MovieAPI.genre.urlString(), success: { (data) in
            guard let data = data as? Data else { return }
            let json = JSON(data)
            let value = json["genres"]
            let jsonString = value.rawString()
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let genreList = try
                    decoder.decode([GenreVO].self, from: Data(jsonString!.utf8))
                
                self.addToCoreData(genreVOs: genreList)
                success(genreList)
                
            } catch let jsonError {
                print(jsonError)
                faulire(jsonError.localizedDescription)
            }
        }) { (err) in
            print("fail fatching top rated movies due to \(err)")
            faulire(err)
        }
    }
    
    func addToCoreData(genreVO : GenreVO) {
        let genreCDE = GenreCDE(context: PersistenceManager.shared.persistanceContainer.viewContext)
        
        genreCDE.id = Int32(genreVO.id ?? 0)
        genreCDE.name = genreVO.name
        
        PersistenceManager.shared.saveContext()
    }
    
    func addToCoreData(genreVOs : [GenreVO]) {
        genreVOs.forEach { (genreVO) in
            addToCoreData(genreVO: genreVO)
        }
    }
    
    func getGenreList(success : @escaping ([GenreVO]) -> Void) {
        guard let genreCDEs = PersistenceManager.shared.getData(classType: ClassType.GenreCDE) as? [GenreCDE] else {return}
        success(genreCDEs.toGenreVOs())
    }
    
    func getGenreCDEById(genreId : Int) -> GenreCDE? {
        let fetchRequest : NSFetchRequest<GenreCDE> = GenreCDE.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", genreId)
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

