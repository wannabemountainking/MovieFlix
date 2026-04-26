//
//  Movie.swift
//  MovieFlix
//
//  Created by yoonie on 4/22/26.
//

import Foundation


struct Movie: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    var posterURL: URL? {
        guard let path = posterPath else {return nil}
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
	
	var releaseDateKR: String {
		let dateCompo: [String] = releaseDate.components(separatedBy: "-")
		return "\(dateCompo[0])년 \(dateCompo[1].first == "0" ? String(dateCompo[1].last ?? "0") : dateCompo[1])월 \(dateCompo[2])일"
	}
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let mock = Movie(
        id: 1193501,
        title: "휘슬",
        overview: "\"죽음의 휘파람, 그 소리를 불어서는 안 됐다\"\r 전학생 크리스는 작은 공업 도시의 고등학교로 전학 온 첫날, 의문의 사고로 죽은 학생이 사용하던 사물함을 물려받게 된다. 그 안에서 발견한 것은 해골 모양의 기묘한 고대 휘파람. 호기심에 불어본 순간, 그것이 단순한 장난감이 아니라 끔찍한 저주가 깃든 유물이라는 사실을 알게 된다. 휘파람이 울리는 순간, 그 소리를 들은 이들에게는 피할 수 없는 운명이 따라붙기 시작한다. 눈에 보이지 않던 공포가 점점 현실로 다가오고, 친구들 사이에서는 설명할 수 없는 사건들이 이어진다. 저주의 근원을 찾아내기 전까지 죽음은 멈추지 않는다. 크리스와 친구들은 이 끔찍한 운명을 끊어내기 위해 진실을 추적하기 시작하게 되는데…",
        posterPath: "/eGxPyseSnEZBMJaopGfRUO9HSYx.jpg",
        releaseDate: "2026-01-20",
        voteAverage: 6.039
    )
}

struct TMDBMovie: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
