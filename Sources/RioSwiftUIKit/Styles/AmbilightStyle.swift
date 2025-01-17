//
//  SwiftUIView.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/17.
//

import SwiftUI

struct AmbilightStyle: View {
    var colors: [Color]?
    var blur: CGFloat?
    var animate: Bool?
    var animateDuration: CGFloat?
    @State var colorRotation: CGFloat?
    var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(.thickMaterial)
            .frame(width: 200, height: 100)
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
                    angle: .degrees(colorRotation ?? 90.0)
                )
                .blur(radius: blur ?? 20)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .onAppear {
                if animate ?? false {
                    withAnimation(
                        .linear(duration: animateDuration ?? 10.0)
                            .repeatForever(autoreverses: false)
                    ) {
                        colorRotation = 360
                    }
                }
            }
    }
}

#Preview {
    AmbilightStyle(animate: false)
}
