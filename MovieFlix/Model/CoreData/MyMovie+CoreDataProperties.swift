//
//  MyMovie+CoreDataProperties.swift
//  MovieFlix
//
//  Created by YoonieMac on 4/24/26.
//

import Foundation
import CoreData


extension MyMovie {
	@NSManaged var id: Int64
	@NSManaged var title: String
	@NSManaged var overview: String
	@NSManaged var posterPath: String?
	@NSManaged var releaseDate: String
	@NSManaged var voteAverage: Double
	
	@nonobjc static func fetchRequest() -> NSFetchRequest<MyMovie> {
		return NSFetchRequest(entityName: "MyMovie")
	}
}

// MARK: - Poster의 URL 계산속성 추가
extension MyMovie {
	var posterURL: URL? {
		guard let path = posterPath else {return nil}
		return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
	}
}
