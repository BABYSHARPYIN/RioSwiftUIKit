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

#Preview {
    ShimmerStyle()
}
