//
//  ContentView.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 13/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authUser : AuthUser
    
    @State var isAfterSplashScreen: Bool = false
    
    var body: some View {
        
        if self.isAfterSplashScreen {
            if self.authUser.isLoggedin {
                Home()
            } else {
                Login()
            }
        } else {
            SplashScreen()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            self.isAfterSplashScreen = true
                        }
                    }
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
