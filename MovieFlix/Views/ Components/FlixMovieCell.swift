//
//  FlixMovieCell.swift
//  MovieFlix
//
//  Created by YoonieMac on 4/25/26.
//

import SwiftUI

struct FlixMovieCell: View {
	
	let posterUrl: URL?
	let title: String
	var onBackgroundPressed: (() -> Void)?
	
    var body: some View {
		BasicMovieCell(
			posterUrl: posterUrl,
			title: title,
			onBackgroundPressed: onBackgroundPressed
		)
		.aspectRatio(3/4, contentMode: .fill)
		
    }//:body
}

#Preview {
	FlixMovieCell(
		posterUrl: Movie.mock.posterURL,
		title: Movie.mock.title,
		onBackgroundPressed: nil
	)
}
