//
//  Model.swift
//  NetworkApp
//
//  Created by Борис Павлов on 28.06.2022.
//

import Foundation

struct Model: Codable {
    let data: Data?
}

struct Data: Codable {
    let memes: [Memes]?
}

struct Memes: Codable {
    let name: String?
}
