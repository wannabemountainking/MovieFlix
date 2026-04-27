//
//  MovieDetailView.swift
//  MovieFlix
//
//  Created by YoonieMac on 4/26/26.
//

import SwiftUI

struct MovieDetailView: View {
	
	@EnvironmentObject var vm: MovieViewModel
	@Environment(\.dismiss) var dismiss
	
	@State private var isInMyList: Bool = false
	@State private var showPopup: Bool = false
	@State private var popupMessage: String = ""
	
	var movie: Movie
	
    var body: some View {
		ZStack {
			Color.black.ignoresSafeArea()
			VStack {
				HStack {
					Spacer()
					Image(systemName: "xmark.app")
						.resizable()
						.frame(width: 40, height: 40)
						.foregroundStyle(.white.opacity(0.8))
						.onTapGesture {
							dismiss()
						}
					
				} //:HSTACK
				Spacer()
			} //:VSTACK
			.padding(30)
			.zIndex(1)

			VStack {
				BasicMovieCell(movie: movie)
					.aspectRatio(2/3, contentMode: .fit)
					.frame(height: 400)
				HStack {
					VStack(alignment: .leading) {
						Text(movie.title)
						Text("개봉일: \(movie.releaseDateKR)")
						Text("평점: ⭐️ \(movie.voteAverage.formatted(.number.precision(.fractionLength(1))))")
					} //:VSTACK
					Spacer()
					VStack {
						MyListButton(inMyList: isInMyList) {
							isInMyList.toggle()
                            if isInMyList {
                                vm.addToMyList(movie)
								self.popupMessage = "해당 영화가 My List에 추가되었습니다"
                            } else {
                                vm.deleteFromMyList(movie: movie)
								self.popupMessage = "해당 영화가 My List에서 제거되었습니다"
                            }
							withAnimation(.easeInOut(duration: 0.5)) {
								self.showPopup = true
							}
							print(vm.myMovieList)
						}
						Text("My List")
					} //:VSTACK
				} //:HSTACK
				
				VStack(alignment: .leading) {
					Text("줄거리")
					Text(movie.overview)
						.lineLimit(3)
				} //:VSTACK
				
				Button("상세 보기") {
					//action
					let urlString = "https://www.themoviedb.org/movie/\(movie.id)"
					if let url = URL(string: urlString) {
						UIApplication.shared.open(url)
					}
				}
				.font(.title2)
				.fontWeight(.semibold)
				.padding(5)
				.frame(maxWidth: .infinity)
				.background(Color.orange)
				.clipShape(RoundedRectangle(cornerRadius: 15))
			} //:VSTACK
			.padding()
			.foregroundStyle(.white)
			
			// popup
			if showPopup {
				VStack(alignment: .center) {
					Text(self.popupMessage)
						.font(.subheadline)
						.foregroundStyle(.black)
						.padding()
						.padding(.horizontal, 20)
						.background(Color.white)
						.clipShape(RoundedRectangle(cornerRadius: 10))
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.onAppear {
					DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
						withAnimation(.easeInOut(duration: 0.5)) {
							self.showPopup = false
						}
					}
				}
				.zIndex(1)
				.transition(.opacity)
			}
		} //:ZSTACK
        .onAppear {
            print(self.isInMyList, vm.isInMyList(movieID: movie.id), vm.myMovieList)
            self.isInMyList = vm.isInMyList(movieID: movie.id)
            print(self.isInMyList, vm.isInMyList(movieID: movie.id))
        }
    }//: Body
}

#Preview {
	MovieDetailView(movie: Movie.mock)
		.environmentObject(MovieViewModel())
}
