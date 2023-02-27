//
//  ContentView.swift
//  Learning App
//
//  Created by Dathan Felipe on 2/26/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        NavigationStack {
            
            VStack(alignment: .leading) {
                
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(model.modules) { module in
                            
                            VStack(spacing: 20.0) {
                                
                                NavigationLink {
                                    ContentView()
                                        .onAppear {
                                            model.beginModule(moduleID: module.id)
                                        }
                                } label: {
                                    
                                    // learning card
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, lesson_question: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }
                                
                                // test card
                                HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, lesson_question: "\(module.test.questions.count) Questions", time: module.test.time)
                            }
                        }
                    }
                    .accentColor(.black)
                    .padding(.all)
                }
                
            }
            .navigationTitle("Get Started")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
