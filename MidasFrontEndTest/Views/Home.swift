//
//  Home.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 13/04/23.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var authUser : AuthUser
    
    @Environment(\.managedObjectContext) var manageObjContext
    
    var body: some View {
        if self.authUser.user?.role == "user" {
            UserView()
        } else {
            AdminView()
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
