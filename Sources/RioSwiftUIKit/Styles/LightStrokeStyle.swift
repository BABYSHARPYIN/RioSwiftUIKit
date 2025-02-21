//
//  SwiftUIView.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/16.
//

import SwiftUI

public struct LightStrokeModifier<S: Shape>: ViewModifier {
    var contentShape: S
    var strokeLineWidth: CGFloat
    var gradientColors: [Color]
    var startPoint: UnitPoint
    var endPoint: UnitPoint

    public init(
        contentShape: S,
        strokeLineWidth: CGFloat = 1,
        gradientColors: [Color] = [
            .white.opacity(0.4), .clear, .clear, .clear, .black.opacity(0.4),
        ],
        startPoint: UnitPoint = .topLeading,
        endPoint: UnitPoint = .bottomTrailing
    ) {
        self.contentShape = contentShape
        self.strokeLineWidth = strokeLineWidth
        self.gradientColors = gradientColors
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    public func body(content: Content) -> some View {
        content
            .overlay {
                contentShape
                    .stroke(lineWidth: strokeLineWidth)
                    .foregroundStyle(
                        .linearGradient(
                            colors: gradientColors, startPoint: .topLeading,
                            endPoint: .bottomTrailing))
            }
    }
}

struct LightStrokeStyle: View {
    var body: some View {
        ZStack {
            Color.secondary
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.tint)
                .frame(width: 100, height: 100)
                .lightStroke(contentShape: RoundedRectangle(cornerRadius: 10))
                .rotationEffect(.degrees(45))

        }.ignoresSafeArea()
    }
}

extension View{
    /// 为视图添加光效描边
    ///
    /// Example usage:
    /// ```swift
    /// RoundedRectangle(cornerRadius: 12)
    ///     .frame(width: 200, height: 100)
    ///     .lightStroke(
    ///         contentShape: RoundedRectangle(cornerRadius: 12),
    ///         strokeLineWidth: 2,
    ///         gradientColors: [.white, .clear, .white]
    ///     )
    /// ```
    ///
    /// - Parameters:
    ///   - contentShape: 描边的形状
    ///   - strokeLineWidth: 描边宽度
    ///   - gradientColors: 渐变颜色数组
    ///   - startPoint: 渐变起点
    ///   - endPoint: 渐变终点
    /// - Returns: 添加了光效描边的视图
    @inlinable
    public func lightStroke<S: Shape>(
        contentShape: S,
        strokeLineWidth: CGFloat = 1.0,
        gradientColors: [Color] = [
            .white.opacity(0.4), .clear, .clear, .clear, .black.opacity(0.4),
        ],
        startPoint: UnitPoint = .topLeading,
        endPoint: UnitPoint = .bottomTrailing
    ) -> some View {
        modifier(
            LightStrokeModifier(
                contentShape: contentShape, strokeLineWidth: strokeLineWidth,
                gradientColors: gradientColors, startPoint: startPoint,
                endPoint: endPoint))
    }
}

#Preview {
    LightStrokeStyle()
}
