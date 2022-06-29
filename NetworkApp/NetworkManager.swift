//
//  NetworkManager.swift
//  NetworkApp
//
//  Created by Борис Павлов on 29.06.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func getResponse(with url: String, completion: @escaping (Model) -> ()) {
        guard let url = URL(string: Link.getResponse.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "error")
                return
            }
            let decoder = JSONDecoder()
            do {
                let product = try decoder.decode(Model.self, from: data)
                DispatchQueue.main.async {
                    completion(product)
                }
            }catch {
                print(error)
            }
        }.resume()
    }
    
    func postRequest(with data: [String: Any], to url: String, completion: @escaping(Any) -> ()) {
        guard let url = URL(string: url), let httpBody = try? JSONSerialization.data(withJSONObject: data) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response else {
                print(error ?? "error")
                return
            }
            print(response)
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                DispatchQueue.main.async {
                    completion(json)
                }
                
            }catch {
                print(error)
            }
        }.resume()
    }
    
    private init() {}
}
