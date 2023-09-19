//
//  ContentView.swift
//  Landmarks
//
//  Created by Shubham Lahoti on 18/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View{
            AutoScroller(images: ["uk","us","germany","italy","russia","spain","estonia"])
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AutoScroller: View{
    var images: [String]
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    @State private var count:Int = 0

    var body: some View {
        ZStack{
            Color.green
                .ignoresSafeArea()
            
            ZStack{
                TabView(selection: $count, content: {
                    ForEach(0..<images.count){ i in
                        ZStack(alignment: .topLeading){
                            Image("\(images[i])").resizable().tag(i)
                            Text("Sample Text")
                                .font(.system(size:30, weight: .bold))
                                .foregroundColor(.black)
                                .padding(20)
                                
                                
                                
                        }
                        
                    }
                })
                .frame(height: 300)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                    HStack{
                        ForEach(0..<images.count){ ind in
                            Capsule()
                                .fill(Color.white.opacity(count == ind ? 1 : 0.55))
                                .frame(width: 35, height: 8)
                                .onTapGesture(perform: {
                                    count = ind
                                })
                        }
                        .offset(y:130)
                    
                }
                
            }
            .onReceive(timer, perform: {
                _ in
                withAnimation(.default){
                    count = count == images.count ? 0 : count+1
                }
            })
        }
    }
}
