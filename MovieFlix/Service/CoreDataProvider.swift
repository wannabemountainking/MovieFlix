//
//  CoreDataProvider.swift
//  MovieFlix
//
//  Created by YoonieMac on 4/24/26.
//

import Foundation
import CoreData


final class CoreDataProvider {
	
	static let shared = CoreDataProvider()
	
	let container: NSPersistentContainer
	lazy private(set) var context: NSManagedObjectContext = container.viewContext
	
	private init() {
		container = NSPersistentContainer(name: "MyMovie")
		
		container.loadPersistentStores { description, error in
			if let error {
				fatalError("CoreData Loading Error: \(error.localizedDescription)")
			}
		}
	}
	
	// MARK: - 공통 메서드 (저장, read, add, delete)
	// context 저장
	private func saveContext() {
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				print("CoreData Context Save Error: \(error.localizedDescription)")
			}
		}
	}
	
	// read
	func fetchMyMovies() -> [MyMovie] {
		let request = NSFetchRequest<MyMovie>(entityName: "MyMovie")
		guard let results = try? context.fetch(request) else {return []}
		return results
	}
	
	// add
	func addMovie(_ movie: Movie) {
		let coreDataMovie = MyMovie(context: context)
		coreDataMovie.id = Int64(movie.id)
		coreDataMovie.title = movie.title
		coreDataMovie.overview = movie.overview
		coreDataMovie.posterPath = movie.posterPath
		coreDataMovie.releaseDate = movie.releaseDate
		coreDataMovie.voteAverage = movie.voteAverage
		
		saveContext()
	}
	
	// delete
	func deleteMovie(_ movie: MyMovie) {
		context.delete(movie)
		saveContext()
	}
}
