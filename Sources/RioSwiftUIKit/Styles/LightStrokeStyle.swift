//
//  SwiftUIView.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/16.
//

import SwiftUI

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
#Preview {
    LightStrokeStyle()
}

public struct lightStrokeModifier<S: Shape>: ViewModifier {
    var contentShape: S
    var strokeLineWidth: CGFloat
    var gradientColors: [Color]
    var startPoint: UnitPoint
    var endPoint: UnitPoint

    @usableFromInline
    internal init(
        contentShape: S,
        strokeLineWidth: CGFloat = 1,
        gradientColors: [Color] = [.white.opacity(0.4), .clear, .clear, .clear, .black.opacity(0.4)],
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

public extension View {
    @inlinable
    func lightStroke<S: Shape>(
        contentShape: S,
        strokeLineWidth: CGFloat = 1.0,
        gradientColors: [Color] = [
            .white.opacity(0.4), .clear, .clear, .clear, .black.opacity(0.4),
        ],
        startPoint: UnitPoint = .topLeading,
        endPoint: UnitPoint = .bottomTrailing
    ) -> some View {
        modifier(
            lightStrokeModifier(
                contentShape: contentShape, strokeLineWidth: strokeLineWidth,
                gradientColors: gradientColors, startPoint: startPoint,
                endPoint: endPoint))
    }
}
