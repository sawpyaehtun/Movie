//
//  NetworkConfiguration.swift
//  Movie
//
//  Created by saw pyaehtun on 27/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

enum MovieAPI {
    case movie
    case genre
    case posters
    
    func urlStringWithPageID() -> String {
        NetworkConfiguration.urlStringWithPageID(apiString: apiString())
    }
    
    func urlString() -> String {
        NetworkConfiguration.urlString(apiString: apiString())
    }
    
    func apiString() -> String {
        switch self {
        case .movie:
            return "/movie/top_rated"
        case .genre:
            return "/genre/movie/list"
        case .posters:
            return ""
        }
    }
}

struct NetworkConfiguration {
    
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let BASE_IMG_URL = "https://image.tmdb.org/t/p/w500"
    static let KEY = "?api_key=3ea4500e51ab3b0358547f472e44d5fc"
    
    static func urlStringWithPageID(apiString : String) -> String{
        return "\(BASE_URL)\(apiString)\(KEY)&page="
    }
    
    static func urlString(apiString : String) -> String{
        return "\(BASE_URL)\(apiString)\(KEY)"
    }
}
