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

#Preview {
    LightStrokeStyle()
}
