//
//  MyListView.swift
//  MovieFlix
//
//  Created by yoonie on 4/26/26.
//

import SwiftUI

struct MyListView: View {
	
	@EnvironmentObject var vm: MovieViewModel
    @State private var selectedMovie: Movie? = nil
    
	let columns = [
		GridItem(.flexible(), spacing: 10),
		GridItem(.flexible(), spacing: 10),
		GridItem(.flexible(), spacing: 10)
	]
	
    var body: some View {
        if vm.myMovieList.isEmpty {
            ContentUnavailableView("No Movies", systemImage: "text.page.slash", description: Text("나의 리스트가 비어있습니다"))
        } else {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(vm.myMovieList, id: \.id) { myMovie in
                        let movie = vm.switchTypeFromMyMovieToMovie(myMovie: myMovie)
                        FlixMovieCell(movie: movie) {
                            self.selectedMovie = movie
                        }
                        .padding(10)
                    }
                }
            } //:SCROLL
            .sheet(item: $selectedMovie, content: { movie in
                MovieDetailView(movie: movie)
            })
            .padding(20)
            .navigationTitle("My List")
            .navigationBarTitleDisplayMode(.inline)
        }
    }//:body
}

#Preview {
    NavigationStack {
        MyListView()
            .environmentObject(MovieViewModel())
    }
}
