//
//  MovieViewModel.swift
//  MovieFlix
//
//  Created by yoonie on 4/22/26.
//

import Foundation
import Combine


final class MovieViewModel: ObservableObject {
    
	let networkManager = NetworkManager()
	
	@Published var nowPlayingMovies: [Movie] = []
	@Published var popularMovies: [Movie] = []
	@Published var topRatedMovies: [Movie] = []
	@Published var upcomingMovies: [Movie] = []
	
	var nextPages: [MovieCategory: Int] = [:]
	var cancellables = Set<AnyCancellable>()
	
	init() {
		for category in MovieCategory.allCases {
			loadMovies(category: category)
		}
	}
	
	func loadMovies(category: MovieCategory, page: Int = 1) {
		let networkPublisher = networkManager.fetchMovies(category: category, page: page)
		networkPublisher
			.sink { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print("network Error: \(error.localizedDescription)")
				}
			} receiveValue: { [weak self] movies in
				guard let self else {return}
				
				switch category {
				case .nowPlaying:
					self.nowPlayingMovies.append(contentsOf: movies)
				case .popular:
					self.popularMovies.append(contentsOf: movies)
				case .topRated:
					self.topRatedMovies.append(contentsOf: movies)
				case .upcoming:
					self.upcomingMovies.append(contentsOf: movies)
				}
			}
			.store(in: &cancellables)
		
	}
    
}
