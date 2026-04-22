//
//  MovieFlixApp.swift
//  MovieFlix
//
//  Created by yoonie on 4/22/26.
//

import SwiftUI

@main
struct MovieFlixApp: App {
    
    @StateObject private var vm = MovieViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
