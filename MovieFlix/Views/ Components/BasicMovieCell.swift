//
//  BasicMovieCell.swift
//  MovieFlix
//
//  Created by YoonieMac on 4/25/26.
//

import SwiftUI

struct BasicMovieCell: View {
	
	let posterUrl: URL?
	let title: String
	var onBackgroundPressed: (() -> Void)?
	var onDetailButtonPressed: (() -> Void)?
	
	
	var body: some View {
		ZStack(alignment: .center) {
			RoundedRectangle(cornerRadius: 15)
				.fill(Color.black)
				.shadow(radius: 5)
				.overlay {
					ImageLoaderView(imageUrl: posterUrl)
				}
			VStack(alignment: .center) {
				Spacer()
				Text(title)
					.font(.largeTitle)
					.foregroundStyle(.white)
					.padding(.top)
					.padding()
					.frame(maxWidth: .infinity)
					.background(
						LinearGradient(
							colors: [.clear, .gray.opacity(0.7)],
							startPoint: .top,
							endPoint: .bottom
						)
					)
				if let onDetailButtonPressed {
					Button("상세 보기") {
						onDetailButtonPressed()
					}
					.font(.title)
					.fontWeight(.semibold)
					.foregroundStyle(.white)
					.padding(.vertical, 10)
					.frame(maxWidth: .infinity)
					.background(Color.pink)
					.clipShape(RoundedRectangle(cornerRadius: 15))
					.padding(.bottom)
				}
			} //:VSTACK
		} //:ZSTACK
		.clipShape(RoundedRectangle(cornerRadius: 15))
		.onTapGesture {
			onBackgroundPressed?()
		}
	}//:body
}

#Preview {
    BasicMovieCell(
		posterUrl: Movie.mock.posterURL,
		title: Movie.mock.title,
		onBackgroundPressed: nil,
		onDetailButtonPressed: nil
	)
}
