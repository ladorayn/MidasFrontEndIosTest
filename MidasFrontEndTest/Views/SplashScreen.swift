//
//  SplashScreen.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 13/04/23.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        Image("MidasLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
