//
//  Register.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 13/04/23.
//

import SwiftUI

struct Register: View {
//    @Binding var rootIsActive : Bool
    
    @EnvironmentObject var authUser : AuthUser
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment (\.managedObjectContext) var manageObjContext
    @Environment (\.dismiss) var dismiss
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var role: String = ""
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 10){
                Image("MidasLogo")
                
                VStack{
                    InputTextField(placeholder: "Username", bindingText: $username)
                    InputTextField(placeholder: "Email", bindingText: $email)
                    SecureTextField(placeholder: "Password", bindingText: $password)
                    HStack(spacing: 20){
                        Text("Role")
                            .font(Font.headline)
                        
                        
                        RadioButtonGroups { selected in
                            self.role = selected
                        }
                    }
                    .padding()
                    .frame(width: 300, height: 50)
                    
                    
                }
                
                if(!self.authUser.registrationValidation) {
                    Text("Please fill all the required field").foregroundColor(.red)
                }
                
                NavigationLink(destination: Login()){
                    Button(action: {
                        
                        if self.email == "" || self.username == "" || self.password == "" || self.email == "" || self.role == "" {
                            self.authUser.regisValidation(bool: false)
                        } else {
                            DataController().addUser(username: self.username, email: self.email, password: self.password, role: self.role, context: manageObjContext)
                            dismiss()
                            self.authUser.regisValidation(bool: true)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                        
                    }) {
                        Text("Register")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.blue.opacity(0.6))
                            .cornerRadius(10)
                    }
                    
                }
                
                HStack{
                    Text("Already have an account?").font(.caption)
                    
                    NavigationLink(destination: Login()){
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Login").font(.caption)
                        }
                        
                    }
                }
                
                
                    
                
            }
            .navigationBarHidden(true)
        }
        .onAppear{
            self.authUser.resetRegisterValidation()
        }
    }
}

struct Register_Previews: PreviewProvider {
    
    static var previews: some View {
        Register()
    }
}
