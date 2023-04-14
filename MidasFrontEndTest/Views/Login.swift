//
//  Login.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 13/04/23.
//

import SwiftUI
import CoreData

struct Login: View {
    @EnvironmentObject var authUser : AuthUser
    
    @Environment(\.managedObjectContext) var manageObjContext
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var user:
//    FetchedResults<User>
    
    
    @State private var isActive: Bool = false
     
    @State var email: String = ""
    @State var password: String = ""
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 10){
                Image("MidasLogo")
                
                VStack{
                    InputTextField(placeholder: "Email", bindingText: $email)
                    SecureTextField(placeholder: "Password", bindingText: $password)
                }
                
                if(!self.authUser.isCorrect) {
                    Text("email or password is wrong!").foregroundColor(.red)
                }
                
                NavigationLink(destination: Home()){
                    Button(action: {
                        let user = DataController().login(email: self.email, password: self.password, context: manageObjContext)
                        self.authUser.fetchUser(user: user)
                        
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.blue.opacity(0.6))
                            .cornerRadius(10)
                    }
                }
                
                HStack{
                    Text("Don't have an account?").font(.callout).bold()
                    Spacer()
                    NavigationLink(destination: Register()){
                        Text("Register").font(.callout).foregroundColor(.blue)
                    }.simultaneousGesture(TapGesture().onEnded{
                        self.email = ""
                        self.password = ""
                        self.authUser.resetLoginValidation()
                    })
                    
                }
                .frame(width: 300, height: 50)
                
            }
            .navigationBarHidden(true)
        }
        
    }
    
    func findUser(email: String) {
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext

        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicate = NSPredicate(format: "email = %@", email) // Specify your condition here
    // Or for integer value
    // let predicate = NSPredicate(format: "age > %d", argumentArray: [10])

        fetch.predicate = predicate

        do {

          let result = try manageObjContext.fetch(fetch)
          for data in result as! [NSManagedObject] {
            print(data.value(forKey: "username") as! String)
            print(data.value(forKey: "password") as! String)
            print(data.value(forKey: "role") as! String)
          }
        } catch {
          print("Failed")
        }
    }
}



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
