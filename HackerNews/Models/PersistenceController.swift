//
//  PersistenceController.swift
//  HackerNews
//
//  Created by Anthony Crawford on 1/19/22.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name:"Storage")
        container.loadPersistentStores{description,error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    // @completion: @escaping (Error?) ->() = {_ in}
    // is a default value for a callback, which you replace with your own
    // when executing the save function
    func save(completion: @escaping (Error?) ->() = {_ in}){
        let context = container.viewContext
        if context.hasChanges {
            do{
                try context.save()
            } catch {
                completion(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) ->() = {_ in}){
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
}
