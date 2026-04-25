//
//  MyListButton.swift
//  MovieFlix
//
//  Created by YoonieMac on 4/25/26.
//

import SwiftUI

struct MyListButton: View {
	
	var inMyList: Bool
	var onBackgroundPressed: (() -> Void)?
	
    var body: some View {
		ZStack(alignment: .center) {
			Image(systemName: "checkmark")
				.resizable()
				.frame(width: 45, height: 45)
				.foregroundStyle(.green)
				.opacity(inMyList ? 1.0 : 0.0)
				.rotationEffect(Angle(degrees: inMyList ? 0 : -180))
			Image(systemName: "plus")
				.resizable()
				.frame(width: 45, height: 45)
				.foregroundStyle(.orange)
				.opacity(inMyList ? 0.0 : 1.0)
				.rotationEffect(Angle(degrees: inMyList ? 0 : -180))
		}
		.animation(.spring, value: inMyList)
		.onTapGesture {
			onBackgroundPressed?()
		}
    }
}

#Preview {
	struct PreviewWrapper: View {
		@State private var inMyList = false
		var body: some View {
			MyListButton(inMyList: inMyList) {
				inMyList.toggle()
			}
		}
	}
	return PreviewWrapper()

//    MyListButton(inMyList: false, onBackgroundPressed: nil)
}
