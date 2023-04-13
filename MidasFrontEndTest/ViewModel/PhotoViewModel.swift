//
//  PhotoViewModel.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 14/04/23.
//

import Foundation


class PhotoViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    private var currentPage = 0
    private var isLoading = false
    
    func fetchPhotos() {
        guard !isLoading else {
            return
        }
        isLoading = true
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos?_start=\(currentPage)&_limit=50&_sort=albumId")!
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                self.isLoading = false
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let photos = try decoder.decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    self.photos += photos
                    self.currentPage += 50
                    self.isLoading = false
                }
            } catch {
                print(error.localizedDescription)
                self.isLoading = false
            }
        }.resume()
    }
    
    func loadMoreIfNeeded(currentItem: Photo?) {
        guard let currentItem = currentItem else {
            fetchPhotos()
            return
        }
        
        let thresholdIndex = photos.index(photos.endIndex, offsetBy: -5)
        if photos.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            fetchPhotos()
        }
    }
}
