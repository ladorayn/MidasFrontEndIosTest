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
    
    @Published var registrationValidation: Bool = true
    
    @Published var editValidation: Bool = true
    
    @Published var loginValidation: Bool = true
    
    
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
    
    func regisValidation(bool: Bool) {
        DispatchQueue.main.async {
            self.registrationValidation = bool
        }
    }
    
    func resetLoginValidation() {
        DispatchQueue.main.async {
            self.isCorrect = true
        }
    }
    
    func resetRegisterValidation() {
        DispatchQueue.main.async {
            self.registrationValidation = true
        }
    }
    
    func editFieldValidation(bool: Bool) {
        DispatchQueue.main.async {
            self.editValidation = bool
        }
    }
    
    func resetEditValidation() {
        DispatchQueue.main.async {
            self.editValidation = true
        }
    }
    
    
    
}
