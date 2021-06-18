//
//  LotteryView.swift
//  Example
//
//  Created by xj on 2020/5/8.
//  Copyright © 2020 晋先森. All rights reserved.
//

import SwiftUI

struct LotteryView: View {
    
    @ObservedObject var control = LotteryControl()
    var radius: CGFloat = 100
    var title: String = ""
    @Binding var isShow: Bool
    let colors = [Color.red, .black, .gray, .green, .blue, .orange, .yellow, .purple]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if(isShow) {
                    Text(title).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                ZStack {
                    ForEach(0..<control.index, id: \.self) { idx in
                        Path { path in
                            path.move(to: CGPoint(x: geometry.size.width/2, y: geometry.size.height/2))
                            path.addArc(center: CGPoint(x: geometry.size.width/2, y: geometry.size.height/2),
                                        radius: self.radius,
                                        startAngle: Angle(degrees: Double(idx) * self.control.angle),
                                        endAngle: Angle(degrees: Double(idx+1) * self.control.angle),
                                        clockwise: false)
                            path.addLine(to:  CGPoint(x: geometry.size.width/2, y: geometry.size.height/2))
                        }.fill(self.colors[idx%self.colors.count])
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height,
                        alignment: .center)
                .rotationEffect(.degrees(control.rotation))
            }
        }
    }
}

struct TestBindView: View {
    @State var isShow = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.isShow = !self.isShow
            }) {
                Text("Click")
                    .bold()
                    .font(.system(.largeTitle,
                                  design: .rounded))
            }
            if(isShow) {
                Text("title").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            LotteryView(radius: 150, title: "Wahaha", isShow: $isShow)
                .frame(width: 350, height: 350, alignment: .topLeading)
        }
    }
}
struct LotteryView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        TestBindView()
            .frame(width: 350, height: 350, alignment: .topLeading)
            .background(Color.yellow.opacity(0.8))
            .frame(width: 400, height: 200)
            .background(Color.orange.opacity(0.5))
        
    }
}

