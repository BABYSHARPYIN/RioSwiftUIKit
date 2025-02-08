//
//  ContentView.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/15.
//

import SwiftUI

// 破损效果修饰符
struct BreakStyleModifier: ViewModifier {
    let offsetLevel: CGFloat
    
    @State private var contentHeight: CGFloat = .zero
    @State private var contentWidth: CGFloat = .zero
    @State private var horizontalHeight: CGFloat = .zero
    @State private var maskOffsetHeight: CGFloat = .zero
    @State private var verticalWidth: CGFloat = .zero
    @State private var maskOffsetWidth: CGFloat = .zero
    
    private var timer = Timer.publish(every: 0.1, on: .main, in: .default)
        .autoconnect()
    
    init(offsetLevel: CGFloat = 5) {
        self.offsetLevel = offsetLevel
    }
    
    func body(content: Content) -> some View {
        ZStack {
            // layout1
            ZStack {
                content
                    .foregroundStyle(.blue)
                    .offset(x: -3)
                content
            }
            .offset(x: offsetLevel)
            .mask {
                ZStack {
                    // 方块故障
                    Rectangle()
                        .frame(width: verticalWidth * 10, height: horizontalHeight)
                        .offset(x: maskOffsetWidth, y: maskOffsetHeight)
                    // 平行故障
                    Rectangle()
                        .frame(height: horizontalHeight)
                        .offset(y: maskOffsetWidth)
                    // 垂直故障
                    Rectangle()
                        .frame(width: verticalWidth)
                        .offset(x: maskOffsetWidth)
                }
            }
            
            // layout2
            ZStack {
                content
                    .foregroundStyle(.red)
                    .offset(x: 3)
                content
            }
            .offset(x: -offsetLevel)
            .reverseMask {
                ZStack {
                    Rectangle()
                        .frame(width: verticalWidth * 10, height: horizontalHeight)
                        .offset(x: maskOffsetWidth, y: maskOffsetHeight)
                    Rectangle()
                        .frame(height: horizontalHeight)
                        .offset(y: maskOffsetWidth)
                    Rectangle()
                        .frame(width: verticalWidth)
                        .offset(x: maskOffsetWidth)
                }
            }
        }
        .background {
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        contentHeight = geo.size.height
                        contentWidth = geo.size.width
                    }
            }
        }
        .onReceive(timer) { _ in
            if Bool.random() {
                setSizeAndOffset()
            }
        }
    }
    
    private func setSizeAndOffset() {
        horizontalHeight = CGFloat.random(in: 0...contentHeight) / 2
        verticalWidth = CGFloat.random(in: 0...contentWidth) / 20
        maskOffsetHeight = CGFloat.random(
            in: -contentHeight / 2.0...contentHeight / 2.0
        )
        maskOffsetWidth = CGFloat.random(
            in: -contentWidth / 2.0...contentWidth / 2.0
        )
    }
}

// 使用示例
struct BreakStyleExample: View {
    var body: some View {
        VStack(spacing: 30) {
            // 基本文本效果
            Text("RIO")
                .font(.system(size: 44, weight: .bold, design: .monospaced))
                .breakStyle()
            
            // 自定义偏移的图标效果
            Image(systemName: "star.fill")
                .font(.system(size: 60))
                .breakStyle(offsetLevel: 8)
            
            // 组合视图效果
            VStack {
                Text("ERROR")
                    .font(.headline)
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.title)
            }
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .breakStyle(offsetLevel: 3)
        }
    }
}

#Preview {
    BreakStyleExample()
}

