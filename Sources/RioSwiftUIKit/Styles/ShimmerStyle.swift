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
    @State private var offset: CGFloat = .infinity

    public init(contentShape: S, animate: Bool) {
        self.contentShape = contentShape
        self.animate = animate
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
                                .white.opacity(0.1),
                                .white.opacity(0.3),
                                .white.opacity(0.1),
                                .clear,
                            ],
                            startPoint: .leading, endPoint: .trailing
                        )
                        .blur(radius: 5)
                        .offset(x: offset)
                        .onAppear {
                            offset = -size.width
                            withAnimation(
                                .linear(duration: 1.25).delay(1.25)
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
                    .shimmer(contentShape: RoundedRectangle(cornerRadius: 10), animate: isLoading)
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
