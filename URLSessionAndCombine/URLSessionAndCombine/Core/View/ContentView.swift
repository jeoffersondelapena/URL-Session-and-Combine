//
//  ContentView.swift
//  URLSessionAndCombine
//
//  Created by Jeofferson Dela Peña on 7/21/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        ScrollView {
            ForEach(viewModel.posts) { post in
                PostItem(post: post)
            }
        }
        .onAppear(perform: viewModel.fetchData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
