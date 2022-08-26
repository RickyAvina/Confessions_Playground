//
//  SubmitConfessionView.swift
//  ChatApp
//
//  Created by Enrique Avina on 8/13/22.
//

import SwiftUI


struct CustomTextEditorView: View {
    var placerHolder: String
    @Binding var string: String
    @State var textEditorHeight : CGFloat = 20
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(string)
                .font(.system(.body))
                .foregroundColor(.clear)
                .padding(14)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self,
                                           value: $0.frame(in: .local).size.height)
                })
            TextEditor(text: $string)
                .font(.system(.body))
                .frame(height: max(40, textEditorHeight))
                .cornerRadius(10.0)
                .shadow(radius: 1.0)
                .foregroundColor(.white)
                .placeholder(when: string.isEmpty) {
                    Text("Write your confession here.")
                        .foregroundColor(Color(hex: "CCCCCC").opacity(0.3))
                        .padding(.vertical)
                        .padding(.top, -4)
                        .padding(.leading, 5)
                }
        }
        .onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
    }
}


struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct SubmitConfessionView: View {
    @State var confessionText: String = ""
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var animateGradient = false
    
    init(confessionText: String = "") {
        self.confessionText = confessionText
        UITextView.appearance().backgroundColor = .clear
    
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Submit your confession")
                    .font(.custom("GothicA1-Black", size: 24))
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                CustomTextEditorView(placerHolder: "Enter your confession here", string: $confessionText)

                ZStack(alignment: .topTrailing) {
                    image?
    //                Image("doge")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                        .padding()
                    if (image != nil) {
                        Button(action: {
                            image = nil
                        }) {
                            Image("X")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding([.top, .trailing], 20)
                        }
                    }

                }
                
                Divider()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .background(.white)
                    .padding()
                HStack(alignment: .center) {
                    Button(action: {
                        showingImagePicker = true
                    }, label: {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    })
                    Spacer()
                    Button {
                        print("submit")
                    } label: {
                        Text("Submit")
                            .font(.custom("GothicA1-Bold", size: 15))
                            .padding(9)
                            .foregroundColor(.white)
                            .background(
                            ZStack {
                                LinearGradient(colors: [.blue, .red], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                                    .onAppear {
                                        withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: true)) {
                                            animateGradient.toggle()
                                        }
                                    }
                            })
                            .cornerRadius(5)
                            .frame(width: 80)
                    }
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color(hex: "242424"))
            .cornerRadius(8)
            .padding(.horizontal, 30)
            .onChange(of: inputImage, perform: { _ in loadImage() })
            .sheet(isPresented: $showingImagePicker) {
//                ImagePicker(image: $inputImage)
        }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { print("invalid"); return }
        image = Image(uiImage: inputImage)
    }
}

struct SubmitConfessionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        SubmitConfessionView(confessionText: "So basically dune is the worst movie of 2022! I've seen it like 10df9d09d090d9f090 times and I can't seem to get the point of it....")
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
    }
}
