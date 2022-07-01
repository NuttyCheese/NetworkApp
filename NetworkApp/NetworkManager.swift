//
//  NetworkManager.swift
//  NetworkApp
//
//  Created by Борис Павлов on 29.06.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func getResponse(with url: String) async throws -> Model {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        guard let product = try? decoder.decode(Model.self, from: data) else {
            throw NetworkError.noData
        }
        
        return product
    }
    
    func postRequest(with data: [String: Any], to url: String) async throws -> Any {
        guard let url = URL(string: url), let httpBody = try? JSONSerialization.data(withJSONObject: data) else {
            throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        print(response)
        let json = try JSONSerialization.jsonObject(with: data)
        
        return json
    }
    
    private init() {}
}
