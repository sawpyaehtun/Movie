//
//  BaseResponse.swift
//  HouseListApp
//
//  Created by saw pyaehtun on 14/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

class BaseResponse: Codable {
    var code : Int?
    var message : String?
//    var error : ErrorVO?
    func isResponseOK() -> Bool {
        
        guard let code = code else { return false}
        
        switch code {
        case 200:
            return true
        default:
            return false
        }
        
    }
}
