//
//  ContentView.swift
//  HackerNews
//
//  Created by Anthony Crawford on 1/19/22.
//

import SwiftUI

struct ContentView: View {
    // Here we are subscribing to the published changes in NetworkManager
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView{
            List(networkManager.posts){
                post in HStack{
                    NavigationLink(destination: DetailView(url: post.url)) {
                        Text(String(post.points))
                        Text(post.title)
                    }

                }
            }
            .navigationBarTitle("Hacker News")
        }
        
        // When view loads, onAppear is executed and an anonymous function
        // is executed on the completion of the onAppear event
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
