//
//  PhotosModel.swift
//  MidasFrontEndTest
//
//  Created by Lado Rayhan on 14/04/23.
//

import Foundation
import Combine


struct Photo: Codable, Identifiable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
