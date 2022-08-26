//
//  ConfessionsFeedView.swift
//  ChatApp
//
//  Created by Enrique Avina on 8/10/22.
//

import SwiftUI
import SwiftyJSON


struct ConfessionsFeedView: View {
//    static var confession: Confession = Confession(text: "So basically this is a tweet", date: Date.now.addingTimeInterval(TimeInterval(343*60.0)), yoos: 1529)
//    static var confession2: Confession = Confession(text: "So fdsfsdf this is a tweet", date: Date.now.addingTimeInterval(TimeInterval(43*60.0)), yoos: 1529)
//    static var confession3: Confession = Confession(text: "gsdy this is a tweet", date: Date.now.addingTimeInterval(TimeInterval(34343*60.0)), yoos: 1529)
    
    @StateObject var networkManager = ConfessionsNetworkManager()
//    @State var confessions: [Confession] = []
    @State var active: Bool = false
    
    func dummyConfessionsGenerator(num: Int) -> [Confession] {
        var confessions: [Confession] = []
        
        for _ in 1...num {
            let newConfession = Confession(text: randomString(of: Int.random(in: 10...100)), date: Date.now.addingTimeInterval(Double.random(in: 1...3600*60)), yoos: Int.random(in: 1...10000))
                                           
            confessions.append(newConfession)
        }
        
        return confessions
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 25) {
                    ForEach (networkManager.confessions, id: \.self) { confession in
                        ConfessionsFeedCellView(confession: confession)
                    }
                }
                .background(.black)
            }
//            .customNavigationTitle("Title")
//            .customNavigationBarBackButtonHidden(true)
        }
        .onAppear {
            self.networkManager.getConfessions()
//            self.confessions = self.networkManager.confessions
//            self.confessions = dummyConfessionsGenerator(num: 100)
        }
    }
}

class ConfessionsNetworkManager: ObservableObject {
    private var HTTPSUrl = "https://3iw5293ifj.execute-api.us-east-1.amazonaws.com/development"
    private let dateFormatter = ISO8601DateFormatter()
    
    @Published var confessions: [Confession] = []
    
    public func getConfessions(_ numConfessions: Int = 50) {
        PostRequest(endpoint: "/get-confessions",
                    body: ["confessionsToLoad": numConfessions]) { data, response, error in
            
            if let error = error {
                print("Unexpected error \(error)")
                return
            }
            
            self.parseConfessionsArray(data)
        }
    }
    
    private func parseConfessionsArray(_ data: Data?) {
        var _confessions: [Confession] = []
        
        if let data = data {
            if let jsonArr = JSON(data).array {
                for obj in jsonArr {
                    if let confession = parseDict(obj) {
                        _confessions.append(confession)
                        print("new confession: \(confession)")
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            self.confessions = _confessions
        }
    }
    
    private func parseDict(_ jsonDict: JSON) -> Confession? {
        let text = jsonDict["text"].stringValue
        let timestamp_str = jsonDict["timestamp"].stringValue
        
        guard let timestamp = dateFormatter.date(from: timestamp_str) else {
            print("error couldn't get date from \(timestamp_str)")
            return nil
        }
        
        let confession = Confession(text: text, date: timestamp, yoos: 0)
        return confession
    }
}

//        VStack(alignment: .center) {
            // Header
//            header
//            NavigationView {
//                ZStack {
//                    NavigationLink(isActive: $active, destination: {
//                        Color.blue
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .navigationTitle("")
////                            .navigationBarHidden(true)
////                            .ignoresSafeArea()
//                    }, label: {
//                        Text("yeash")
//                    })
//
//
//
//
//
////
////                    NavigationLink(destination: {
////                        Color.blue
////                            .frame(maxWidth: .infinity, maxHeight: .infinity)
////                            .navigationTitle("")
////                            .navigationBarHidden(true)
////                            .ignoresSafeArea()
////                    } isActive: $active) {
////                        Text("yer")
////                    }
//
//                    ScrollView {
//                        LazyVStack(spacing: 0) {
//                            ForEach (dummyConfessionsGenerator(num: 100), id: \.self) { confession in
//                                ConfessionsFeedCellView(confession: confession)
//                                    .padding(.horizontal)
//                                    .onTapGesture {
//                                        active = true
//                                    }
//                            }
//                        }
//                    }
//                    .background(.black)
//                    .navigationBarTitle("")
//                    .navigationBarHidden(true)
//                }
//            }
//        }
//        .background(.red)
//        .frame(maxWidth: .infinity)
//
//    }
//}

extension ConfessionsFeedView {
    var header: some View {
        ZStack {
            Text("Takes Feed")
                .font(.custom("GothicA1-Black", size: 24))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            HStack {
                Spacer()
                Button(action: {
                    print("filter")
                }, label: {
                    Image("filter")
                        .resizable()
                        .frame(width: 41, height: 41)
                })
            }.padding(.trailing)
        }
        .padding(4)
    }
}

struct ConfessionsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        ConfessionsFeedView()
    }
}
