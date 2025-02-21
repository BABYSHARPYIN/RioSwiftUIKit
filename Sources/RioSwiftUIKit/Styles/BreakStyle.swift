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

extension View{
    /// 添加破损风格效果
    ///
    /// 为视图添加故障艺术风格的视觉效果，包括色差和随机故障块。
    ///
    /// Example usage:
    /// ```swift
    /// // 基本用法
    /// Text("Glitch Text")
    ///     .breakStyle()
    ///
    /// // 自定义偏移级别
    /// Image(systemName: "star.fill")
    ///     .font(.largeTitle)
    ///     .breakStyle(offsetLevel: 8)
    ///
    /// // 应用于复杂视图
    /// VStack {
    ///     Text("Glitch")
    ///     Image(systemName: "bolt.fill")
    /// }
    /// .breakStyle(offsetLevel: 3)
    /// ```
    ///
    /// - Parameter offsetLevel: 故障效果的偏移级别，默认为 5
    /// - Returns: 添加了破损效果的视图
    public func breakStyle(offsetLevel: CGFloat = 5) -> some View {
        modifier(BreakStyleModifier(offsetLevel: offsetLevel))
    }
}

#Preview {
    BreakStyleExample()
}

