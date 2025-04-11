//
//  PostData.swift
//  HackerNews
//
//  Created by Anthony Crawford on 1/19/22.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}


struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let title: String
    let points: Int
    let url: String?
}
