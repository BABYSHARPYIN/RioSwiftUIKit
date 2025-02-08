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
    ///
    /// Example usage:
    /// ```swift
    /// Color.blue
    ///     .frame(width: 200, height: 200)
    ///     .reverseMask {
    ///         Circle()
    ///             .frame(width: 100, height: 100)
    ///     }
    /// ```
    ///
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

    /// 添加环形光效果
    ///
    /// Example usage:
    /// ```swift
    /// RoundedRectangle(cornerRadius: 12)
    ///     .fill(.blue)
    ///     .frame(width: 200, height: 100)
    ///     .ambilightStyle(
    ///         contentShape: RoundedRectangle(cornerRadius: 12),
    ///         colors: [.red, .blue, .green],
    ///         blur: 20,
    ///         animate: true,
    ///         animateDuration: 2
    ///     )
    /// ```
    ///
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
        animate: Bool? = true,
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

    /// 为视图添加加载状态和加载指示器
    ///
    /// 使用默认加载指示器样式，可自定义加载文本。当加载状态激活时，会显示一个半透明遮罩层和加载指示器，
    /// 并在后台执行指定的异步任务。
    ///
    /// Example usage:
    /// ```swift
    /// Button("Load Data") {
    ///     isLoading = true
    /// }
    /// .onLoading(isLoading: isLoading, loadingText: "加载中...") {
    ///     await loadDataTask()
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - isLoading: 控制加载状态的布尔值
    ///   - loadingText: 加载过程中显示的文本，默认为 "Loading..."
    ///   - task: 在加载状态下执行的异步任务
    /// - Returns: 添加了加载效果的修改后的视图
    @inlinable
    public func onLoading(
        isLoading: Bool,
        loadingText: String = "Loading...",
        perform task: @escaping () async -> Void
    ) -> some View {
        modifier(
            OnLoadingModifier(
                isLoading: isLoading,
                loadingText: loadingText,
                task: task,
                loadingView: nil
            )
        )
    }

    /// 为视图添加加载状态和自定义加载指示器
    ///
    /// 允许使用自定义视图作为加载指示器。当加载状态激活时，会显示一个半透明遮罩层和自定义的加载视图，
    /// 并在后台执行指定的异步任务。
    ///
    /// Example usage:
    /// ```swift
    /// Button("Load Data") {
    ///     isLoading = true
    /// }
    /// .onLoading(isLoading: isLoading) {
    ///     // 自定义加载视图
    ///     VStack {
    ///         Image(systemName: "arrow.triangle.2.circlepath")
    ///             .font(.largeTitle)
    ///         Text("Processing...")
    ///     }
    /// } perform: {
    ///     await loadDataTask()
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - isLoading: 控制加载状态的布尔值
    ///   - loadingView: 自定义加载视图的视图构建器
    ///   - task: 在加载状态下执行的异步任务
    /// - Returns: 添加了自定义加载效果的修改后的视图
    @inlinable
    public func onLoading<LoadingView: View>(
        isLoading: Bool,
        @ViewBuilder loadingView: @escaping () -> LoadingView,
        perform task: @escaping () async -> Void
    ) -> some View {
        modifier(
            OnLoadingModifier(
                isLoading: isLoading,
                loadingText: "",
                task: task,
                loadingView: {
                    AnyView(loadingView())
                }
            )
        )
    }

    /// 添加浮动气泡效果
    ///
    /// 使用自定义配置数组创建浮动气泡效果。每个气泡可以独立配置大小、颜色、透明度和动画速度。
    ///
    /// Example usage:
    /// ```swift
    /// // 基本用法
    /// Text("Hello World")
    ///     .bubbles([
    ///         BubbleConfig(size: 20, color: .red, opacity: 0.5, speed: 1.0),
    ///         BubbleConfig(size: 30, color: .blue, opacity: 0.4, speed: 1.2)
    ///     ])
    ///
    /// // 创建彩虹气泡效果
    /// Text("Rainbow Bubbles")
    ///     .bubbles(
    ///         (0..<10).map { i in
    ///             BubbleConfig(
    ///                 size: 25,
    ///                 color: Color(hue: Double(i) / 10, saturation: 0.7, brightness: 0.9),
    ///                 opacity: 0.5,
    ///                 speed: 1.0
    ///             )
    ///         }
    ///     )
    ///
    /// // 创建大小渐变的气泡
    /// Text("Size Gradient")
    ///     .bubbles(
    ///         (0..<5).map { i in
    ///             BubbleConfig(
    ///                 size: CGFloat(10 + i * 5),
    ///                 color: .blue,
    ///                 opacity: 0.5,
    ///                 speed: 1.0
    ///             )
    ///         }
    ///     )
    /// ```
    ///
    /// - Parameter configs: 气泡配置数组，每个配置定义一个气泡的属性
    /// - Returns: 添加了浮动气泡效果的修改后的视图
    public func bubbles(_ configs: [BubbleConfig]) -> some View {
        modifier(BubblesModifier(configs: configs))
    }

    /// 添加浮动气泡效果（便捷方法）
    ///
    /// 使用简单的参数快速创建统一样式的浮动气泡效果。所有气泡将共享相同的颜色，
    /// 但大小、透明度和速度会在指定范围内随机变化。
    ///
    /// Example usage:
    /// ```swift
    /// // 基本用法（使用默认值）
    /// Text("Default Bubbles")
    ///     .bubbles()
    ///
    /// // 自定义气泡数量和颜色
    /// Text("Custom Bubbles")
    ///     .bubbles(
    ///         count: 15,
    ///         color: .purple
    ///     )
    ///
    /// // 完全自定义
    /// Text("Fully Custom")
    ///     .bubbles(
    ///         count: 20,
    ///         color: .orange,
    ///         size: 15...40
    ///     )
    ///
    /// // 作为背景效果
    /// VStack {
    ///     Text("Title")
    ///     Button("Press Me") {
    ///         // 动作
    ///     }
    /// }
    /// .frame(maxWidth: .infinity, maxHeight: .infinity)
    /// .bubbles(
    ///     count: 25,
    ///     color: .blue.opacity(0.3),
    ///     size: 20...50
    /// )
    ///
    /// // 在列表中使用
    /// List {
    ///     ForEach(items) { item in
    ///         Text(item.title)
    ///     }
    /// }
    /// .bubbles(
    ///     count: 10,
    ///     color: .gray,
    ///     size: 5...15
    /// )
    /// ```
    ///
    /// - Parameters:
    ///   - count: 气泡数量，默认为 10
    ///   - color: 气泡颜色，默认为蓝色
    ///   - size: 气泡大小范围，默认为 10...30 点
    /// - Returns: 添加了浮动气泡效果的修改后的视图
    public func bubbles(
        count: Int = 10,
        color: Color = .blue,
        size: ClosedRange<CGFloat> = 10...30
    ) -> some View {
        let configs = (0..<count).map { _ in
            BubbleConfig(
                size: .random(in: size),
                color: color,
                opacity: .random(in: 0.3...0.7),
                speed: .random(in: 0.8...1.2)
            )
        }
        return bubbles(configs)
    }
    
    /// 添加破损风格效果
    ///
    /// 为视图添加故障艺术风格的视觉效果，包括色差和随机故障块。
    ///
    /// Example usage:
    /// ```swift
    /// // 基本用法
    /// Text("Glitch Text")
    ///     .breakStyle()
    ///
    /// // 自定义偏移级别
    /// Image(systemName: "star.fill")
    ///     .font(.largeTitle)
    ///     .breakStyle(offsetLevel: 8)
    ///
    /// // 应用于复杂视图
    /// VStack {
    ///     Text("Glitch")
    ///     Image(systemName: "bolt.fill")
    /// }
    /// .breakStyle(offsetLevel: 3)
    /// ```
    ///
    /// - Parameter offsetLevel: 故障效果的偏移级别，默认为 5
    /// - Returns: 添加了破损效果的视图
    public func breakStyle(offsetLevel: CGFloat = 5) -> some View {
        modifier(BreakStyleModifier(offsetLevel: offsetLevel))
    }
}
