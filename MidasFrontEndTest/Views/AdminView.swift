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
    let user: User
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text("ID:")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Text("\(user.id!)")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            HStack(alignment: .top) {
                Text("Username:")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Text(user.username ?? "")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            HStack(alignment: .top) {
                Text("Email:")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Text(user.email ?? "")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            HStack(alignment: .top) {
                Text("Role:")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Text(user.role ?? "")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct EditUserView: View {
    let user: User
    
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
                }
                
                
                Button(action:
                        {
                            let dataController = DataController()
                            dataController.editUser(user: user, username: username, email: email, password: password, role: role, context: context)
                            presentationMode.wrappedValue.dismiss()
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
