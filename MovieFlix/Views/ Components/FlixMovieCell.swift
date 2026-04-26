//
//  FlixMovieCell.swift
//  MovieFlix
//
//  Created by YoonieMac on 4/25/26.
//

import SwiftUI

struct FlixMovieCell: View {
	
    var movie: Movie?
	var onBackgroundPressed: (() -> Void)?
	
    var body: some View {
		BasicMovieCell(
            movie: self.movie,
            onBackgroundPressed: self.onBackgroundPressed
		)
		.aspectRatio(2/3, contentMode: .fill)
		
    }//:body
}

#Preview {
	FlixMovieCell(
        movie: Movie.mock,
		onBackgroundPressed: nil
	)
}
