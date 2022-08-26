//
//  ConfessionsCOmment.swift
//  ChatApp
//
//  Created by Enrique Avina on 8/12/22.
//

import SwiftUI

struct Comment: Hashable {
    let pfp: String
    let username: String
    let content: String
    let time: Date
}

struct ConfessionsComment: View {
    let comment: Comment
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(comment.pfp)
                .resizable()
                .scaledToFit()
                .frame(width: 44)
                .cornerRadius(7)
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline) {
                    Text("@\(comment.username)")
                        .font(.custom("GothicA1-Black", size: 16))
                        .baselineOffset(-1)
                        .foregroundColor(.white)
                        .frame(height: 20)
                    Text("\(comment.time.timeFromNowString()) ago")
                        .font(.custom("GothicA1-Bold", size: 12))
                        .foregroundColor(Color(hex: "CCCCCC"))
                }
                Text(comment.content)
                    .font(.custom("GothicA1-Bold", size: 14))
                    .foregroundColor(.white)
            }
            .padding(.top, 2)
            .padding(.trailing, 4)
            .padding(.leading, 12)
        }
    }
}

struct ConfessionsComment_Previews: PreviewProvider {
    static var previews: some View {
        ConfessionsComment(comment: Comment(pfp: "doge", username: "sebi", content: "YERR ", time: Date.now + 2.0))
            .background(.black)
    }
}
