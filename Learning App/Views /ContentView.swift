//
//  ContentView.swift
//  Learning App
//
//  Created by Dathan Felipe on 2/27/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                // confirm that currentModule is set
                if let currentModule = model.currentModule {
                    
                    ForEach(0..<currentModule.content.lessons.count) { index in
                        
                        NavigationLink {
                            
                            ContentDetailView()
                                .onAppear {
                                    model.beginLesson(index)
                                }
                            
                        } label: {
                            
                            let lesson = currentModule.content.lessons[index]
                            
                            // lesson card
                            ZStack(alignment: .leading) {
                                
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .frame(height: 68)
                                
                                HStack(spacing: 30.0) {
                                    
                                    Text(String(index + 1))
                                        .fontWeight(.bold)
                                    
                                    VStack(alignment: .leading) {
                                        Text(lesson.title)
                                            .fontWeight(.bold)
                                        Text(lesson.duration)
                                    }
                                }
                                .padding()
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .padding()
            .accentColor(.black)
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentModel())
    }
}
