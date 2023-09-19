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
            Color.secondary
                .ignoresSafeArea()
            
            Group{
                TabView(selection: $count){
                    ForEach(0..<images.count, id: \.self){ i in
                        ZStack(alignment: .topLeading){
                            Image("\(images[i])").resizable().tag(i)
                                .frame(width: 350, height: 200)
                        }.background(VisualEffectBlur()).shadow(radius: 20)
                        
                    }
                }
                .frame(height: 300)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .ignoresSafeArea()
                    HStack{
                        ForEach(0..<images.count, id: \.self){ ind in
                            Capsule()
                                .fill(Color.white.opacity(count == ind ? 1 : 0.33))
                                .frame(width: 35, height: 8)
                                .onTapGesture(perform: {
                                    count = ind
                                })
                        }
                        .offset(y:130)
                    
                }
                
            }
            .onReceive(timer, perform: { _ in
                withAnimation(.default){
                    count = count == images.count ? 0 : count+1
                }
            })
        }
    }
}
