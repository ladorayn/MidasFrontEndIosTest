//
//  DataController.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 13/04/23.
//

import Foundation
import Combine
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "UserModel")
    
    init() {
        
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data. \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved")
        }catch {
            print("We could not save the data")
        }
    }
    
    func addUser(username: String, email:String, password:String, role:String, context: NSManagedObjectContext){
        let user = User(context: context)
        user.id = UUID()
        user.username = username
        user.email = email
        user.password = password
        user.role = role
        
        save(context: context)
    }
    
    func editUser(user: User, username: String, email: String, password: String, role:String,  context: NSManagedObjectContext) {
        user.username = username
        user.email = email
        user.password = password
        user.role = role
        
        save(context: context)
    }
    
    func login(email: String, password: String, context: NSManagedObjectContext) -> UserModel? {
        

        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicate = NSPredicate(format: "email = %@ AND password = %@", email, password) // Specify your condition here


        fetch.predicate = predicate
        

        do {
          let result = try context.fetch(fetch)            
            
          for data in result as! [NSManagedObject] {
              let id = data.value(forKey: "id") as! UUID
              let username = data.value(forKey: "username") as! String
              let email = data.value(forKey: "email") as! String
              let password = data.value(forKey: "password") as! String
              let role = data.value(forKey: "role") as! String
              
              return UserModel(id: id, username: username, email: email, password: password, role: role)
              
          }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
}
