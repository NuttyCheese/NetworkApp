//
//  ViewController.swift
//  NetworkApp
//
//  Created by Борис Павлов on 28.06.2022.
//

import UIKit
enum Link: String {
    case getResponse = "https://api.imgflip.com/get_memes"
    case postRequest = "https://jsonplaceholder.typicode.com/posts"
}

class ViewController: UIViewController {
    @IBOutlet weak var getLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    
    private var modelMemes: Model!
    private let list = [
        "name": "Networking",
        "imageUrl": "image url",
        "numberOfLessons": "10",
        "numberOfTests": "8"
    ]
    
    @IBAction func getResponse(_ sender: Any) {
       fetch()
    }
    
    @IBAction func postRequest(_ sender: Any) {
        give()
    }
    
    private func fetch() {
        NetworkManager.shared.getResponse(with: Link.getResponse.rawValue) { model in
            self.modelMemes = model
            self.getLabel.text = self.modelMemes.data?.memes?.first?.name
        }
    }
    
    private func give() {
        NetworkManager.shared.postRequest(with: list, to: Link.postRequest.rawValue) { _ in
            self.postLabel.text = self.list.keys.first
            print(self.list.randomElement()!)
        }
    }
}

