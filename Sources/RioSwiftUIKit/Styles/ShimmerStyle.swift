//
//  SwiftUIView.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/29.
//

import SwiftUI

public struct ShimmerModifier<S: Shape>: ViewModifier {
    var contentShape: S
    var animate: Bool
    var color: Color
    @State private var offset: CGFloat = .infinity

    public init(contentShape: S, animate: Bool, color: Color) {
        self.contentShape = contentShape
        self.animate = animate
        self.color = color
    }

    public func body(content: Content) -> some View {
        if animate {
            content
                .overlay {
                    GeometryReader { proxy in
                        let size: CGSize = proxy.size

                        LinearGradient(
                            colors: [
                                .clear,
                                .clear,
                                color.opacity(0.1),
                                color.opacity(0.2),
                                color.opacity(0.1),
                                .clear,
                                .clear,
                            ],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                        .blur(radius: 10)
                        .offset(x: offset)
                        .onAppear {
                            offset = -size.width
                            withAnimation(
                                .linear(duration: 1.25).delay(4.0)
                                    .repeatForever(
                                        autoreverses: false)
                            ) {
                                offset = size.width
                            }
                        }
                        .clipShape(contentShape)
                    }

                }
        } else {
            content
        }
    }
}

struct ShimmerStyle: View {
    @State var isLoading: Bool = true
    var body: some View {
        LazyVGrid(columns: Array(repeating: .init(), count: 3), spacing: 10) {
            ForEach(0..<10) { i in
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray)
                    .frame(height: 50)
                    .shimmer(
                        contentShape: RoundedRectangle(cornerRadius: 10),
                        animate: isLoading,
                        color: .white
                    )
                    .onTapGesture {
                        isLoading.toggle()
                    }

            }
        }
        .padding()
    }
}

extension View{
    /// 为视图添加光泽扫过动画效果
    ///
    /// 此修饰符创建一个从左到右扫过的光泽动画效果，类似于加载或强调状态的视觉反馈。
    /// 光泽效果会按照指定的形状进行裁剪，并可以通过 animate 参数控制开启或关闭。
    ///
    /// Example usage:
    /// ```swift
    /// RoundedRectangle(cornerRadius: 12)
    ///     .fill(.blue)
    ///     .frame(width: 200, height: 100)
    ///     .shimmer(contentShape: RoundedRectangle(cornerRadius: 12))
    /// ```
    ///
    /// 或者控制动画状态:
    /// ```swift
    /// @State private var isShimmering = true
    ///
    /// RoundedRectangle(cornerRadius: 12)
    ///     .fill(.blue)
    ///     .frame(width: 200, height: 100)
    ///     .shimmer(
    ///         contentShape: RoundedRectangle(cornerRadius: 12),
    ///         animate: isShimmering
    ///     )
    /// ```
    ///
    /// - Parameters:
    ///   - contentShape: 定义光泽效果的形状。该形状将被用作裁剪遮罩
    ///   - animate: 控制动画是否激活,默认为 true
    ///   - color: 光泽颜色,默认为白色
    /// - Returns: 应用了光泽效果的修改后的视图
    @inlinable
    public func shimmer<S: Shape>(
        contentShape: S,
        animate: Bool = true,
        color: Color = Color.white
    ) -> some View {
        modifier(
            ShimmerModifier(
                contentShape: contentShape,
                animate: animate,
                color: color
            )
        )
    }
}

#Preview {
    ShimmerStyle()
}
