//
//  onShake.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/20.
//
import Foundation
import SwiftUI

public struct OnShakeModifier: ViewModifier {

    @State private var degress: CGFloat
    var amplitude: CGFloat?
    var anchor: UnitPoint?
    var action: () -> Void

    public init(
        amplitude: CGFloat? = nil, anchor: UnitPoint? = nil,
        action: @escaping () -> Void
    ) {
        self.degress = 0
        self.amplitude = amplitude
        self.anchor = anchor
        self.action = action
    }

    public func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(degress), anchor: anchor ?? .top)
            .onTapGesture {
                action()
                withAnimation(.easeIn(duration: 0.1)) {
                    degress = amplitude ?? 20
                }
                withAnimation(.easeIn(duration: 0.1).delay(0.1)) {
                    degress = -(amplitude ?? 20)
                }
                withAnimation(.easeOut(duration: 0.1).delay(0.2)) {
                    degress = 0
                }
            }
    }
}

struct OnShakeModifierView: View {
    @State var symbolVariant: SymbolVariants = .none
    var body: some View {
        Image(systemName: "bell")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .foregroundStyle(.yellow)
            .symbolVariant(symbolVariant)
            .onShake(amplitude: 20, anchor: .top) {
                print("shaking")
                if symbolVariant == .none {
                    symbolVariant = .fill
                } else {
                    symbolVariant = .none
                }
            }
    }
}

extension View {
    /// 添加抖动效果
    ///
    /// Example usage:
    /// ```swift
    /// Text("Shake me!")
    ///     .onShake(amplitude: 5) {
    ///         print("View was shaken!")
    ///     }
    /// ```
    ///
    /// - Parameters:
    ///   - amplitude: 抖动幅度
    ///   - anchor: 抖动锚点
    ///   - action: 抖动触发时执行的动作
    /// - Returns: 添加了抖动效果的视图
    @inlinable
    public func onShake(
        amplitude: CGFloat? = nil,
        anchor: UnitPoint? = nil,
        action: @escaping () -> Void
    ) -> some View {
        modifier(
            OnShakeModifier(
                amplitude: amplitude,
                anchor: anchor,
                action: action
            )
        )
    }
}

#Preview {
    OnShakeModifierView()
}
