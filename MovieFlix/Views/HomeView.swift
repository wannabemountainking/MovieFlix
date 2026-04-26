//
//  ContentView.swift
//  MovieFlix
//
//  Created by yoonie on 4/22/26.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: MovieViewModel
    @State private var selectedMovie: Movie? = nil
    
    var body: some View {
        NavigationStack {
			ZStack {
				Color.black.ignoresSafeArea()
				VStack(spacing: 10) {
					// MARK: - 상단의 앱 이름과 mylist 텝
					HStack {
						Text("Movie")
							.font(.largeTitle)
							.fontWeight(.semibold)
							.foregroundStyle(.pink)
							.kerning(1.5)
						Text("Flix")
							.font(.largeTitle)
							.fontWeight(.ultraLight)
							.foregroundStyle(.white)
							.kerning(3)
						Spacer()
						NavigationLink {
							//destination
							MyListView()
						} label: {
							VStack {
								Image(systemName: "pencil.and.list.clipboard")
								Text("My List")
							}
							.font(.headline)
						} //:NavLink
					} //:HSTACK
					.padding(.horizontal)
					
					ScrollView(.vertical) {
						VStack {
							// MARK: - 중단의 heroCell
                            if let heroMovie = vm.randomNowPlayingMovie {
                                FlixHeroCell(
                                    movie: heroMovie,
                                    onBackgroundPressed: { self.selectedMovie = heroMovie },
                                    onDetailButtonPressed: { self.selectedMovie = heroMovie }
                                )
                                .aspectRatio(
                                    3/4,
                                    contentMode: .fill
                                )
                                .padding(.vertical, 15)
                            }
							// MARK: - 하단의 횡스크롤
							
							VStack(alignment: .leading, spacing: 5) {
								ForEach(MovieCategory.allCases, id: \.id) { category in
									Text(category.description)
										.font(.title)
										.foregroundStyle(.white)
									ScrollView(.horizontal) {
										LazyHStack(spacing: 20) {
											ForEach(vm.categoryMovies[category, default: []], id: \.id) { movie in
												FlixMovieCell(movie: movie) {
													self.selectedMovie = movie
												}
												.frame(height: 150)
												.onAppear {
													if movie == vm.categoryMovies[category]?.last {
														vm.loadNextPage(category: category)
													}
												}
											} //:LOOP
										} //:HSTACK
									} //:SCROLL
									.padding(.bottom, 15)
								} //:LOOP
							} //:VSTACK
						} //:VSTACK
						.padding()
					} //:SCROLL
				} //:VSTACK
            } //:ZSTACK
			.sheet(item: $selectedMovie) { movie in
				MovieDetailView(movie: movie)
			}
        } //:NAVIGATION
    } //:Body
}

#Preview {
    HomeView()
        .environmentObject(MovieViewModel())
}
