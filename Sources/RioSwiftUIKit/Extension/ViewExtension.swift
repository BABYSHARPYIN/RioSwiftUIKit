//
//  ViewExtension.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/14.
//

import Foundation
import SwiftUI

extension View {
    /// 创建一个反向遮罩效果，将遮罩视图的非透明部分变为透明
    /// - Parameters:
    ///   - alignment: 遮罩对齐方式
    ///   - mask: 用作遮罩的视图构建器
    /// - Returns: 应用了反向遮罩的视图
    @inlinable
    public func reverseMask<Mask: View>(
        alignment: Alignment = .center,
        @ViewBuilder _ mask: () -> Mask
    ) -> some View {
        self.mask {
            self.overlay(alignment: alignment) {
                mask()
                    .blendMode(.destinationOut)
            }
        }
    }

    /// 为视图添加光效描边
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

    /// 添加环形光效果
    /// - Parameters:
    ///   - contentShape: 光效形状
    ///   - colors: 自定义颜色数组（可选）
    ///   - blur: 模糊程度（可选）
    ///   - animate: 是否开启动画（可选）
    ///   - animateDuration: 动画周期（可选）
    /// - Returns: 修改后的视图
    @inlinable
    public func ambilightStyle<S: Shape>(
        contentShape: S,
        colors: [Color]? = nil,
        blur: CGFloat? = nil,
        animate: Bool? = nil,
        animateDuration: CGFloat? = nil,
        colorRotation: CGFloat? = nil
    ) -> some View {
        modifier(
            AmbilightStyleModifier(
                contentShape: contentShape,
                colors: colors,
                blur: blur,
                animate: animate,
                animateDuration: animateDuration,
                colorRotation: colorRotation
            )
        )
    }

    /// 添加抖动效果
    /// - Parameters:
    ///   - amplitude: 抖动幅度
    ///   - anchor: 抖动锚点
    ///   - action: 抖动触发时执行的动作
    /// - Returns: 添加了抖动效果的视图
    @inlinable
    public func onShake(
        amplitude: CGFloat? = nil, anchor: UnitPoint? = nil,
        action: @escaping () -> Void
    ) -> some View {
        modifier(
            OnShakeModifier(
                amplitude: amplitude, anchor: anchor, action: action))
    }
}
