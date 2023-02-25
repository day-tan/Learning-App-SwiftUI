//
//  Learning_AppApp.swift
//  Learning App
//
//  Created by Dathan Felipe on 2/26/23.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
