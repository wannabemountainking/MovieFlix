//
//  FlixHeroCell.swift
//  MovieFlix
//
//  Created by YoonieMac on 4/25/26.
//

import SwiftUI

struct FlixHeroCell: View {
	
    var movie: Movie?
	var onBackgroundPressed: (() -> Void)?
	var onDetailButtonPressed: (() -> Void)?

    var body: some View {
		BasicMovieCell(
            movie: movie,
			onBackgroundPressed: onBackgroundPressed,
			onDetailButtonPressed: onDetailButtonPressed
		)
    }
}

#Preview {
	FlixHeroCell(
        movie: Movie.mock,
		onBackgroundPressed: nil,
		onDetailButtonPressed: nil
	)
}
