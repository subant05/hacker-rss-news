//
//  NetworkManager.swift
//  HackerNews
//
//  Created by Anthony Crawford on 1/19/22.
//

import Foundation

class NetworkManager: ObservableObject {
    
    // Follow observable pattern where when posts is updated, it will publish and event for others to listen on
    @Published var posts = [Post]()
    
    func fetchData(){
        if let url = URL(string:"http://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){
                data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    
                    if let safeData = data {
                        do {
                            
                            let results = try decoder.decode(Results.self, from: safeData)
                            
                            // You have to remember when updated UI, wrap the update in DispatchQueue
                            // or you will get an error in the console
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
}
