//
//  ConfessionsCommentsView.swift
//  ChatApp
//
//  Created by Enrique Avina on 8/12/22.
//

import SwiftUI

struct ConfessionsCommentsView: View {
    let confession: Confession
    @State var comments: [Comment] = []
    @State private var comment: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ConfessionsFeedCellView(confession: confession)
                .padding(.horizontal)
                .border(width: 1.0, edges: [.bottom], color: .gray)
            
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(comments, id: \.self) { comment in
                        ConfessionsComment(comment: comment)
                            .padding(.top)
                    }
                }
            }
            .padding(.horizontal)

            
            HStack {
                TextField("",
                          text: $comment)
                .placeholder(when: comment.isEmpty, placeholder: {
                    Text("Add a comment...")
                        .foregroundColor(.gray)
                })
                .foregroundColor(.white)
                Button {
                    print("Send")
                } label: {
                    Text("Send")
                        .font(.custom("GothicA1-Bold", size: 16))
                        .padding(9)
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)

                        )
                        .cornerRadius(5)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: 30)
            .padding()
            .border(width: 1.0, edges: [.top], color: .gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .onAppear(perform: {
            // get comments
            self.comments = ConfessionsCommentsView.dummyCommentsGenerator(num: 100)
        })
    }
}


extension ConfessionsCommentsView {
    static func dummyCommentsGenerator(num: Int) -> [Comment] {
        var comments: [Comment] = []
        
        for _ in 1...num {
            let comment = Comment(pfp: "doge", username: randomString(of: 10), content: randomString(of: Int.random(in: 1...200)), time: Date.now)
            comments.append(comment)
        }
        
        return comments
    }
}
struct ConfessionsCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        
        ConfessionsCommentsView(confession: Confession(text: "So basically monkey", date: Date.now, yoos: 21322), comments: ConfessionsCommentsView.dummyCommentsGenerator(num: 100))
        
//        ConfessionsCommentsView(confession: Confession(text: "So basically monkey", date: Date.now, yoos: 21322), comments: [Comment(pfp: "doge", username: "Doge", content: "So this is a comment", time: Date.now + 20000),Comment(pfp: "doge", username: "Dog3", content: "So this is a comment", time: Date.now + 20000)])
    }
}
