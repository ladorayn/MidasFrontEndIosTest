//
//  UserView.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 14/04/23.
//

import SwiftUI
import SDWebImageSwiftUI


struct UserView: View {
    
    @EnvironmentObject var authUser : AuthUser
    
    @StateObject var viewModel = PhotoViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView{
            List(viewModel.photos) { photo in
                
                HStack{
                    WebImage(url: URL(string: photo.url))
                        .resizable()
                        .frame(width: 120, height: 170)
                        .cornerRadius(10)
                    VStack(alignment: .leading, spacing: 20) {
                        Text(photo.title)
                            .font(.headline)
                        Text("Album \(photo.albumId)")
                            .font(.subheadline)
                    }
                }
                        .onAppear {
                            viewModel.loadMoreIfNeeded(currentItem: photo)
                        }
                    }
                .navigationBarItems(
                    leading: Text(self.authUser.user?.username ?? "" ).fontWeight(.semibold).autocapitalization(.words),
                    trailing: Button(action: {
                    self.authUser.logout()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.forward.circle.fill")
                }))
                .navigationTitle("User View")
                .onAppear {
                            viewModel.fetchPhotos()
                        }
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
