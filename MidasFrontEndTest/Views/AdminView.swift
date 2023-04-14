//
//  AdminView.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 14/04/23.
//

import SwiftUI

struct AdminView: View {
    @EnvironmentObject var authUser : AuthUser
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) var context
    
        
    @FetchRequest(entity: User.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \User.username, ascending: true)])
    
    var users: FetchedResults<User>
    
    var body: some View {
        NavigationView{
            List {
                    ForEach(users, id: \.id) { user in
                        NavigationLink(destination: EditUserView(user: user)) {
                            UserRowView(user: user)
                        }.onAppear{
                            self.authUser.resetEditValidation()
                        }
                    }
                    .onDelete(perform: delete)
                }
                .navigationBarTitle("Registered Users")
                .navigationBarItems(trailing: Button(action: {
                    self.authUser.logout()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.forward.circle.fill")
                }))
        }
        
    }
    func delete(at offsets: IndexSet) {
            for index in offsets {
                let user = users[index]
                context.delete(user)
            }
            do {
                try context.save()
            } catch {
                print("Error deleting user: \(error)")
            }
        }
}

struct UserRowView: View {
    @ObservedObject var user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                Text("ID:")
                    .foregroundColor(.secondary)
                Spacer()
                if user.id != nil {
                    Text("\(user.id!)")
                }
                
            }
            
            HStack(alignment: .top) {
                Text("Username:")
                    .foregroundColor(.secondary)
                Spacer()
                Text(user.username ?? "")
            }
            
            HStack(alignment: .top) {
                Text("Email:")
                    .foregroundColor(.secondary)
                Spacer()
                Text(user.email ?? "")
            }
            
            HStack(alignment: .top) {
                Text("Role:")
                    .foregroundColor(.secondary)
                Spacer()
                Text(user.role ?? "")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

struct EditUserView: View {
    let user: User
    
    
    @EnvironmentObject var authUser: AuthUser
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var role = ""
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Text("Username").frame(maxWidth: geometry.size.width * 0.2)
                    TextField("Username", text: $username)
                        .padding()
                        .frame(maxWidth: geometry.size.width * 0.8)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .onAppear {
                            self.username = user.username ?? ""
                        }
                }
                
                HStack {
                    Text("Email").frame(maxWidth: geometry.size.width * 0.2)
                    Spacer()
                    TextField("Email", text: $email)
                        .padding()
                        .frame(maxWidth: geometry.size.width * 0.8)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .onAppear {
                            self.email = user.email ?? ""
                        }
                    
                }
                
                HStack {
                    Text("Password").frame(maxWidth: geometry.size.width * 0.2)
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(maxWidth: geometry.size.width * 0.8)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .onAppear {
                            self.password = user.password ?? ""
                        }
                    
                }
                
                HStack{
                    Text("Role").frame(maxWidth: geometry.size.width * 0.2)
                    
                    
                    RadioButtonGroups(selectedId: self.user.role ?? "") { selected in
                        
                        self.role = selected
                        
                    }.frame(maxWidth: geometry.size.width * 0.8)
                        .onAppear{
                            self.role = self.user.role ?? ""
                            
                        }
                }
                
                if(!self.authUser.editValidation) {
                    Text("All fields cannot be blank").foregroundColor(.red)
                }
                
                
                Button(action:
                        {
                    if self.email == "" || self.username == "" || self.password == "" || self.email == "" || self.role == "" {
                        self.authUser.editFieldValidation(bool: false)
                    }
                    else {
                        let dataController = DataController()
                        dataController.editUser(user: user, username: username, email: email, password: password, role: role, context: context)
                        self.authUser.editFieldValidation(bool: true)
                        presentationMode.wrappedValue.dismiss()
                    }
                            
                        }
                ) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: geometry.size.width * 0.9)
                        .background(Color.blue.opacity(0.6))
                        .cornerRadius(10)
                }
            }.padding()
            
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
