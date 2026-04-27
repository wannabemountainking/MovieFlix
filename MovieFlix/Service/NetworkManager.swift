//
//  NetworkManager.swift
//  MovieFlix
//
//  Created by YoonieMac on 4/23/26.
//

import Foundation
import Combine

/*
 baseURL: https://api.themoviedb.org/3
 apiKey: "26bc3a347d35e9e11f08e0ac83a85319"
 language: "ko-KR"
 
 필요 데이터 URL파편
 1. nowPlaying : /movie/now_playing
 2. popular: /movie/popular
 3. topRated: /movie/top_rated
 4. upcoming: /movie/upcoming
 */

enum MovieCategory: CaseIterable, Hashable {
	case nowPlaying
	case popular
	case topRated
	case upcoming
	
	var description: String {
		switch self {
		case .nowPlaying: return "절찬 상영 중"
		case .popular: return "관심 집중"
		case .topRated: return "평단의 찬사"
		case .upcoming: return "상영 예정"
		}
	}
	
	var endpoint: String {
		switch self {
		case .nowPlaying: return "/movie/now_playing"
		case .popular: return "/movie/popular"
		case .topRated: return "/movie/top_rated"
		case .upcoming: return "/movie/upcoming"
		}
	}
}

struct NetworkManager {
	private let baseURL: String = "https://api.themoviedb.org/3"
	private let apiKey: String = "26bc3a347d35e9e11f08e0ac83a85319"
	private let language: String = "ko-KR"
	
	func getURL(category: MovieCategory, page: Int) -> URL? {
		let movieCategory = category.endpoint
		let urlString = "\(baseURL)\(movieCategory)?api_key=\(apiKey)&language=\(language)&page=\(page)"
		return URL(string: urlString)
	}
	
	func fetchMovies(category: MovieCategory, page: Int = 1) -> AnyPublisher<[Movie], Error> {
		guard let url = getURL(category: category, page: page) else {
			return Fail(error: URLError(.badURL))
				.eraseToAnyPublisher()
		}
		
		let networkPublisher = URLSession.shared.dataTaskPublisher(for: url)
			.map { $0.data }
			.decode(type: TMDBMovie.self, decoder: JSONDecoder())
			.map { $0.movies }
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
		
		return networkPublisher
	}
}
