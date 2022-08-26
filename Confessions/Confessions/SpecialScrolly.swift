//
//  SpecialScrolly.swift
//  ChatApp
//
//  Created by Enrique Avina on 8/11/22.
//

import SwiftUI

struct SpecialScrolly: View {
    var body: some View {
      GeometryReader { contentView in
        ScrollView {
          VStack {
            Rectangle()
              .fill(Color.red)
              .frame(width: 200, height: 200)
              .onTapGesture {
                print("Rectangle onTapGesture")
            }
          }
          .frame(minWidth: contentView.size.width, minHeight: contentView.size.height, alignment: .top)
          .contentShape(Rectangle())
          .onTapGesture {
            print("ScrollViewArea onTapGesture")
          }
        }.background(.blue)
      }
    


        
//        ScrollView {
//            VStack {
//                Color.red
//                    .frame(height: 300)
//                    .onTapGesture {
//                        print("yer")
//                    }
//                Color.blue
//                    .frame(height: 300)
//                    .onTapGesture {
//                        print("yer2")
//                    }
//            }
//        }   .frame(maxHeight: .infinity)

    }
}



struct SpecialScrolly_Previews: PreviewProvider {
    static var previews: some View {
        SpecialScrolly()
    }
}
