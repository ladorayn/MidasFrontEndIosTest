//
//  MidasFrontEndTestApp.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 13/04/23.
//

import SwiftUI

@main
struct MidasFrontEndTestApp: App {
    
    @StateObject private var dataController = DataController()
    @StateObject private var authUser = AuthUser()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(authUser)
        }
    }
}
