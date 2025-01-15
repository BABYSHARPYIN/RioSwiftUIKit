//
//  ContentView.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/15.
//

//
//  ContentView.swift
//  BreakStyleView
//
//  Created by Rio on 2024/9/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BreakStyleView(offsetLevel: 10) {
            Text("Rio")
                .font(.system(size: 44, weight: .bold, design: .monospaced))
                .frame(maxWidth: .infinity)
        }
        //        BreakStyleView{
        //            Image(systemName: "trash.fill")
        //                .resizable()
        //                .scaledToFit()
        //                .frame(width: 100)
        //        }
        //        BreakStyleView{
        //            Image("image")
        //                .resizable()
        //                .scaledToFit()
        //                .frame(width: 100)
        //        }
    }
}

public struct BreakStyleView<Content: View>: View {

    let content: () -> Content

    var offsetLevel: CGFloat = 5
    @State private var contentHeight: CGFloat = .zero
    @State private var contentWidth: CGFloat = .zero
    @State private var horizontalHeight: CGFloat = .zero
    @State private var maskOffsetHeight: CGFloat = .zero

    @State private var verticalWidth: CGFloat = .zero
    @State private var maskOffsetWidth: CGFloat = .zero

    private var timer = Timer.publish(every: 0.1, on: .main, in: .default)
        .autoconnect()

    public init(
        offsetLevel: CGFloat = 5, @ViewBuilder content: @escaping () -> Content
    ) {
        self.offsetLevel = offsetLevel
        self.content = content
    }

    public var body: some View {
        ZStack {
            //layout1
            ZStack {
                self.content().foregroundStyle(.blue).offset(x: -3)
                self.content()
            }
            .offset(x: offsetLevel)
            .mask {
                ZStack {
                    //方块故障
                    Rectangle().frame(
                        width: verticalWidth * 10, height: horizontalHeight
                    ).offset(x: maskOffsetWidth, y: maskOffsetHeight)
                    //平行故障
                    Rectangle().frame(height: horizontalHeight).offset(
                        y: maskOffsetWidth)
                    //垂直故障
                    Rectangle().frame(width: verticalWidth).offset(
                        x: maskOffsetWidth)
                }
            }
            //layout2
            ZStack {
                self.content().foregroundStyle(.red).offset(x: 3)
                self.content()
            }
            .offset(x: -offsetLevel)
            //google from https://www.fivestars.blog/articles/reverse-masks-how-to/
            .reverseMask {
                ZStack {
                    Rectangle().frame(
                        width: verticalWidth * 10, height: horizontalHeight
                    ).offset(x: maskOffsetWidth, y: maskOffsetHeight)
                    Rectangle().frame(height: horizontalHeight).offset(
                        y: maskOffsetWidth)
                    Rectangle().frame(width: verticalWidth).offset(
                        x: maskOffsetWidth)
                }
            }

        }

        .background {
            GeometryReader {
                geo in
                Color.clear.onAppear {
                    contentHeight = geo.size.height
                    contentWidth = geo.size.width
                }
            }
        }
        .onReceive(
            timer,
            perform: { _ in
                if Bool.random() {
                    setSizeAndOffset()
                }
            })

    }
    private func setSizeAndOffset() {
        horizontalHeight = CGFloat.random(in: 0...contentHeight) / 2
        verticalWidth = CGFloat.random(in: 0...contentWidth) / 20
        maskOffsetHeight = CGFloat.random(
            in: -contentHeight / 2.0...contentHeight / 2.0)
        maskOffsetWidth = CGFloat.random(
            in: -contentWidth / 2.0...contentWidth / 2.0)
    }
}

#Preview {
    ContentView()
}
