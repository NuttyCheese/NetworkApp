//
//  Model.swift
//  NetworkApp
//
//  Created by Борис Павлов on 28.06.2022.
//

import Foundation

struct Model: Codable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
