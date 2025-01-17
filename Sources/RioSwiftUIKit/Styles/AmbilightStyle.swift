//
//  AmbilightStyle.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/17.
//

import SwiftUI

struct AmbilightStyleModifier<S: Shape>: ViewModifier {
    var contentShape: S
    var colors: [Color]?
    var blur: CGFloat?
    var animate: Bool?
    var animateDuration: CGFloat?
    @State private var colorRotation: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay {
                AngularGradient(
                    colors: colors ?? [
                        Color(hex: "0ebeff"),
                        Color(hex: "29b0f7"),
                        Color(hex: "44a2ee"),
                        Color(hex: "5e95e6"),
                        Color(hex: "7987dd"),
                        Color(hex: "9479d5"),
                        Color(hex: "af6bcc"),
                        Color(hex: "c95ec4"),
                        Color(hex: "e450bb"),
                        Color(hex: "ff42b3"),

                        Color(hex: "ff42b3"),
                        Color(hex: "e450bb"),
                        Color(hex: "c95ec4"),
                        Color(hex: "af6bcc"),
                        Color(hex: "9479d5"),
                        Color(hex: "7987dd"),
                        Color(hex: "5e95e6"),
                        Color(hex: "44a2ee"),
                        Color(hex: "29b0f7"),
                        Color(hex: "0ebeff"),
                    ], center: .center,
                    angle: .degrees(colorRotation)
                )
                .blur(radius: blur ?? 20)
                .clipShape(
                    contentShape
                )
            }
            .onAppear {
                if animate ?? false {
                    withAnimation(
                        .linear(duration: animateDuration ?? 10)
                            .repeatForever(autoreverses: false)
                    ) {
                        colorRotation = 360
                    }
                }
            }
    }
}

extension View {
    /// 添加环形光效果
    /// - Parameters:
    ///   - contentShape: 光效形状
    ///   - colors: 自定义颜色数组（可选）
    ///   - blur: 模糊程度（可选）
    ///   - animate: 是否开启动画（可选）
    ///   - animateDuration: 动画周期（可选）
    /// - Returns: 修改后的视图
    public func ambilightStyle<S: Shape>(
        contentShape: S,
        colors: [Color]? = nil,
        blur: CGFloat? = nil,
        animate: Bool? = nil,
        animateDuration: CGFloat? = nil
    ) -> some View {
        modifier(
            AmbilightStyleModifier(
                contentShape: contentShape,
                colors: colors,
                blur: blur,
                animate: animate,
                animateDuration: animateDuration
            )
        )
    }
}

struct AmbilightStyle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(.thickMaterial)
            .frame(width: 200, height: 100)
            .ambilightStyle(
                contentShape: RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 10),
                animate: true
            )
    }
}

#Preview {
    AmbilightStyle()
}
