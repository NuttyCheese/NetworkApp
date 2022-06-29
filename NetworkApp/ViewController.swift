//
//  ViewController.swift
//  NetworkApp
//
//  Created by Борис Павлов on 28.06.2022.
//

import UIKit
enum Link: String {
    case url = "https://api.imgflip.com/get_memes"
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getResponse(_ sender: Any) {
        guard let url = URL(string: Link.url.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error ?? "error")
                return
            }
            print(response)
            let decoder = JSONDecoder()
            do {
                let product = try decoder.decode(Model.self, from: data)
                DispatchQueue.main.async {
                    print(product.name)
                }
                
            }catch {
                print(error)
            }

        }.resume()
        
    }
    
    @IBAction func postRequest(_ sender: Any) {
        let list = [
            "name": "Networking",
            "imageUrl": "image url",
            "numberOfLessons": "10",
            "numberOfTests": "8"
        ]
        
        guard let url = URL(string: Link.url.rawValue) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: list) else { return }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response else {
                print(error ?? "error")
                return
            }
            print(response)
            
            do {
                let json = try? JSONSerialization.data(withJSONObject: data)
                print(json)
            }catch {
                print(error)
            }
        }.resume()
        
    }
}

