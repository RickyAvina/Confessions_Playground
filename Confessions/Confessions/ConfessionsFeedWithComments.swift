//
//  ConfessionsFeedWithComments.swift
//  ChatApp
//
//  Created by Enrique Avina on 8/12/22.
//

import SwiftUI

struct ConfessionsFeedWithComments: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach (dummyConfessionsGenerator(num: 100), id: \.self) { confession in
                        NavigationLink(destination:
                            ConfessionsCommentsView(confession: confession)
//                            .customNavigationTitle("Confessions")
//                            .customNavigationFilterButtonHidden(true)
                        ) {
                            ConfessionsFeedCellView(confession: confession)
                        }
                    }
                }
            }
            .background(.black)
//            .customNavigationTitle("Confessions")
        }
    }
}
            
//            ZStack {
//                Color.orange.ignoresSafeArea()
//                CustomNavLink(destination:
//                    Text("destination")
//                    .customNavigationTitle("camila view")
//                    .customNavigationSubtitle(nil)
//                    .customNavigationFilterButtonHidden(false)
//                ) {
//                    Text("Navigate")
//                }
//            }
//            .customNavigationTitle("Ricky Title")
//            .customNavigationSubtitle("camila sux")
//            .customNavigationBarBackButtonHidden(true)
//            .customNavigationFilterButtonHidden(true)
//        }
//    }
//}
    
extension ConfessionsFeedWithComments {
    func dummyConfessionsGenerator(num: Int) -> [Confession] {
        var confessions: [Confession] = []
        
        for _ in 1...num {
            let newConfession = Confession(text: randomString(of: Int.random(in: 10...100)), date: Date.now.addingTimeInterval(Double.random(in: 1...3600*60)), yoos: Int.random(in: 1...10000))
                                           
            confessions.append(newConfession)
        }
        
        return confessions
    }
}

struct ConfessionsFeedWithComments_Previews: PreviewProvider {
    static var previews: some View {
        ConfessionsFeedWithComments()
    }
}
