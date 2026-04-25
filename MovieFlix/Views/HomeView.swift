//
//  ContentView.swift
//  MovieFlix
//
//  Created by yoonie on 4/22/26.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: MovieViewModel
    @State private var selectedMovie: Movie? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    // MARK: - 상단의 앱 이름과 mylist 텝
                    HStack {
                        Text("MovieFlix")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .kerning(1.5)
                        Spacer()
                        NavigationLink {
                            //destination
                            MyListView()
                        } label: {
                            VStack(spacing: 3) {
                                Image(systemName: "pencil.and.list.clipboard")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.orange.opacity(0.5))
                                Text("My List")
                                    .font(.caption)
                                    .foregroundStyle(.orange.opacity(0.5))
                            }
                        }
                    } //:HSTACK
                    
                    // MARK: - 중단의 heroCell
                    FlixHeroCell(
                        movie: vm.randomNowPlayingMovie,
                        onBackgroundPressed: { self.selectedMovie = vm.randomNowPlayingMovie },
                        onDetailButtonPressed: { self.selectedMovie = vm.randomNowPlayingMovie }
                    )
                } //:VSTACK
                .padding()
            } //:ZSTACK
        } //:NAVIGATION
    } //:Body
}

#Preview {
    HomeView()
        .environmentObject(MovieViewModel())
}
