//
//  MyListView.swift
//  MovieFlix
//
//  Created by yoonie on 4/26/26.
//

import SwiftUI

struct MyListView: View {
	
	@EnvironmentObject var vm: MovieViewModel
	let columns = [
		GridItem(.flexible(), spacing: 10),
		GridItem(.flexible(), spacing: 10),
		GridItem(.flexible(), spacing: 10)
	]
	
    var body: some View {
		ScrollView(.vertical) {
			LazyVGrid(columns: columns) {

			}
		} //:SCROLL
		.navigationTitle("My List")
		.navigationBarTitleDisplayMode(.large)
    }//:body
}

#Preview {
    MyListView()
}
