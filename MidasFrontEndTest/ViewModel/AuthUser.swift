//
//  AuthUser.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 14/04/23.
//

import Foundation
import SwiftUI
import Combine


class AuthUser: ObservableObject {
    var didChange = PassthroughSubject<AuthUser, Never>()
    
    @Published var isLoggedin: Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    @Published var isCorrect: Bool = true
    
    @Published var user: UserModel? = nil
    
    
    func fetchUser(user: UserModel?) {
        
        DispatchQueue.main.async {
            if user != nil {
                self.user = user
                self.isLoggedin = true
                self.isCorrect = true
            } else {
                self.isCorrect = false
            }
        }
    }
    
    func logout() {
        DispatchQueue.main.async {
            self.user = nil
            self.isLoggedin = false
        }
    }
    
    
}
