//
//  PersistanceManager.swift
//  contact-core-date
//
//  Created by saw pyaehtun on 22/09/2019.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum ClassType : String {
    case MovieCDE
    case GenreCDE
    case BookMarkCDE
}

final class PersistenceManager {
    
    static let shared = PersistenceManager()
    
    private init(){}
    
    var persistanceContainer : NSPersistentContainer!
    
    func getData(classType : ClassType) -> [Any]{
        
        do {
            switch classType {
            case .MovieCDE:
                let results = try persistanceContainer.viewContext.fetch(MovieCDE.fetchRequest())
                print(results.count)
                return results
            case .GenreCDE:
               let results = try persistanceContainer.viewContext.fetch(GenreCDE.fetchRequest())
                print(results.count)
                return results
            case .BookMarkCDE:
                let results = try persistanceContainer.viewContext.fetch(BookMarkCDE.fetchRequest())
                print(results.count)
                return results
            }
        } catch let err{
            print("core data fetching error \(err.localizedDescription)")
        }
        
        return []
    }
    
    func saveContext() {
        let context = persistanceContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                print("successfylly saved . . .")
            } catch let coredataError {
                print("coredataError while saving \(coredataError.localizedDescription)")
            }
        }
    }
}
