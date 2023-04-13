//
//  RadioButtonGroups.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 13/04/23.
//

import SwiftUI

enum Role: String {
    case user = "user"
    case admin = "admin"
}

struct RadioButtonGroups: View {
    @State var selectedId: String = ""
    
    let callback: (String) -> ()
    
    
    
    var body: some View {
        HStack(spacing: 5) {
            radioUserMajority
            radioAdminMajority
        }
    }
    
    var radioUserMajority: some View {
        RadioButtonField(
            id: Role.user.rawValue,
            label: Role.user.rawValue,
            isMarked: selectedId == Role.user.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioAdminMajority: some View {
        RadioButtonField(
            id: Role.admin.rawValue,
            label: Role.admin.rawValue,
            isMarked: selectedId == Role.admin.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}
