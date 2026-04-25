//
//  ImageLoaderView.swift
//  MovieFlix
//
//  Created by YoonieMac on 4/24/26.
//

import SwiftUI

struct ImageLoaderView: View {
	
	var imageUrl: URL? // url만 받기
	
    var body: some View {
		AsyncImage(url: imageUrl) { imagePhase in
			switch imagePhase {
			case .empty:
				ProgressView("Now Loading ...")
					.font(.largeTitle)
			case .success(let image):
				image
					.resizable()
					.aspectRatio(contentMode: .fill)
			case .failure(let error):
				ContentUnavailableView(
					"No Image",
					systemImage: "photo.trianglebadge.exclamationmark",
					description: Text("포스터 이미지를 가져오지 못했습니다")
				)
				.font(.largeTitle)
				.onAppear {
					print(error.localizedDescription)
				}
				
			@unknown default:
				EmptyView()
			}
		}
    }
}

#Preview {
	ImageLoaderView(imageUrl: Movie.mock.posterURL)
}
