//
//  HomeViewRow.swift
//  Learning App
//
//  Created by Dathan Felipe on 2/26/23.
//

import SwiftUI

struct HomeViewRow: View {
    
    var image:String
    var title:String
    var description:String
    var lesson_question:String
    var time:String
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            HStack {
                
                // image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                Spacer()
                
                // text
                VStack(alignment: .leading, spacing: 10.0) {
                    
                    // headline
                    Text(title)
                        .fontWeight(.bold)
                    
                    // description
                    Text(description)
                        .font(.caption)
                        .padding(.bottom, 20)
                    
                    // icons
                    HStack {
                        
                        // number of lessons/questions
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(lesson_question)
                            .font(Font.system(size: 10))
                        
                        Spacer()
                        
                        // duration
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(time)
                            .font(Font.system(size: 10))
                    }
                }
                .padding(.leading, 20)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "Some course description", lesson_question: "15 Lessons", time: "3 Hours")
    }
}