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
            .sink(receiveCompletion: handleCompletion) { [weak self] movies in
                guard let self else { return }
                self.allocateMovies(category: category, page: page, movies: movies)
            }
            .store(in: &cancellables)
	}
    
    func loadNextPage(category: MovieCategory) {
        nextPages[category, default: 1] += 1
        loadMovies(category: category, page: nextPages[category, default: 1])
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func allocateMovies(category: MovieCategory, page: Int, movies: [Movie]) {
        switch category {
        case .nowPlaying:
            if page == 1 {
                self.nowPlayingMovies = movies
            } else {
                self.nowPlayingMovies.append(contentsOf: movies)
            }
        case .popular:
            if page == 1 {
                self.popularMovies = movies
            } else {
                self.popularMovies.append(contentsOf: movies)
            }
        case .topRated:
            if page == 1 {
                self.topRatedMovies = movies
            } else {
                self.topRatedMovies.append(contentsOf: movies)
            }
        case .upcoming:
            if page == 1 {
                self.upcomingMovies = movies
            } else {
                self.upcomingMovies.append(contentsOf: movies)
            }
        }
    }
}
