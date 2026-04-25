//
//  FlixHeroCell.swift
//  MovieFlix
//
//  Created by YoonieMac on 4/25/26.
//

import SwiftUI

struct FlixHeroCell: View {
	
	let posterURL: URL?
	let title: String
	var onBackgroundPressed: (() -> Void)?
	var onDetailButtonPressed: (() -> Void)?

    var body: some View {
		BasicMovieCell(
			posterUrl: posterURL,
			title: title,
			onBackgroundPressed: onBackgroundPressed,
			onDetailButtonPressed: onDetailButtonPressed
		)
		
		
    }
}

#Preview {
	FlixHeroCell(
		posterURL: Movie.mock.posterURL,
		title: Movie.mock.title,
		onBackgroundPressed: nil,
		onDetailButtonPressed: nil
	)
}
