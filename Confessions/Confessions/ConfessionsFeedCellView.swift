//
//  ConfessionsFeedCellView.swift
//  ChatApp
//
//  Created by Enrique Avina on 8/10/22.
//

import SwiftUI
import CoreFoundation


struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}


struct Confession: Hashable {
    let text: String
    let date: Date
    var yoos: Int
}

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

struct ConfessionsFeedCellView: View {
    @State var confession: Confession   // model
    @State var yood: Bool = false
    
    @State var animating: Bool = false

    let spring: Animation = .easeOut
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Image(self.yood ? "yoo-red" : "yoo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 42)
                    .padding(.trailing, 1)
                    .scaleEffect(self.animating ? 1.5 : 1)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.1)) {
                            self.yood.toggle()
                            self.animating = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                                self.animating = false
                            }
                            
                            confession.yoos += self.yood ? 1 : -1
                        }
                    }

                Text(confession.yoos.shortStringRepresentation)
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                Text(confession.text)
                    .font(.custom("GothicA1-Bold", size: 14))
                    .foregroundColor(.white)
                    .lineSpacing(3.0)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 1)
                Text("\(confession.date.timeFromNowString()) ago")
                    .font(.custom("GothicA1-Bold", size: 12))
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.gray)
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "message")
                .foregroundColor(.white)
                .padding()
                .padding(.bottom, -80)
        }
        .padding(.vertical, 25)
        .frame(maxWidth: .infinity)
        .background(.black)
//        .border(width: 1, edges: [.top, .bottom], color: Color(hex: "#2F3336"))
    }
}

struct ConfessionsFeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        ConfessionsFeedCellView(confession: Confession(text: "yQUcGZOqicOe\nbGtYbX6DNKt iukI0D\nd9s7U7EP wqbaHopLU", date: Date.now, yoos: 0))
    }
}
