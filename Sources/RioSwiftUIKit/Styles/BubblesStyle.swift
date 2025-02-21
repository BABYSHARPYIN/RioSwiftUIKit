import SwiftUI

// 使用示例
struct BubblesExample: View {
    var body: some View {
        TabView {
            // 基本使用
            VStack {
                Text("Basic Bubbles")
                    .font(.title)
            }
            .frame(width: 200, height: 200)
            .bubbles(count: 10,color: .pink,animate: true)
            .tabItem {
                Label("Basic", systemImage: "circle.fill")
            }

            // 自定义配置
            VStack {
                Text("Custom Bubbles")
                    .font(.title)
            }
            .frame(width: 200, height: 200)
            .bubbles([
                BubbleConfig(size: 20, color: .red, opacity: 0.5, speed: 1.0),
                BubbleConfig(size: 30, color: .blue, opacity: 0.4, speed: 1.2),
                BubbleConfig(size: 25, color: .green, opacity: 0.6, speed: 0.8),
            ])
            .tabItem {
                Label("Custom", systemImage: "star.fill")
            }

            // 多色气泡
            VStack {
                Text("Multi-Color Bubbles")
                    .font(.title)
            }
            .frame(maxWidth: 200, maxHeight: 200)
            .bubbles(
                (0..<20).map { i in
                    BubbleConfig(
                        size: .random(in: 15...35),
                        color: Color(
                            hue: Double(i) / 20,
                            saturation: 0.7,
                            brightness: 0.9
                        ),
                        opacity: .random(in: 0.3...0.7),
                        speed: .random(in: 0.8...1.2)
                    )
                }
            )
            .tabItem {
                Label("Multi-Color", systemImage: "sparkles")
            }
        }
    }
}

// 气泡配置
public struct BubbleConfig {
    var size: CGFloat
    var color: Color
    var opacity: Double
    var speed: Double

    public init(
        size: CGFloat,
        color: Color,
        opacity: Double,
        speed: Double
    ) {
        self.size = size
        self.color = color
        self.opacity = opacity
        self.speed = speed
    }
}

// 单个气泡视图
struct BubbleView: View {
    let config: BubbleConfig
    let animate:Bool
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0

    init(config: BubbleConfig,animate:Bool) {
        self.config = config
        self.animate = animate
    }

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            Color.clear.onAppear {
                xOffset = CGFloat.random(
                    in: -size.width / 2 + config.size / 2...size.width / 2
                        - config.size / 2)
                yOffset = CGFloat.random(
                    in: -size.height / 2 + config.size / 2...size.height / 2
                        - config.size / 2)
            }
            Circle()
                .fill(config.color)
                .opacity(config.opacity)
                .frame(width: config.size, height: config.size)
                .offset(
                    x: size.width / 2 - config.size / 2,
                    y: size.height / 2 - config.size / 2
                )
                .offset(x: xOffset, y: yOffset)
                .onChange(of: xOffset) { _ in
                    if animate{
                        withAnimation(
                            .easeInOut(duration: config.speed)
                                .repeatForever(autoreverses: true)
                        ) {
                            xOffset = CGFloat.random(
                                in: -size.width / 2 + config.size / 2...size.width
                                    / 2 - config.size / 2)
                            yOffset = CGFloat.random(
                                in: -size.height / 2 + config.size / 2...size.height
                                    / 2 - config.size / 2)
                        }
                    }
                }
        }

    }
}

// 气泡修饰符
struct BubblesModifier: ViewModifier {
    let configs: [BubbleConfig]
    let animate:Bool
    public init(configs: [BubbleConfig],animate:Bool) {
        self.configs = configs
        self.animate = animate
    }
    func body(content: Content) -> some View {

        content
            .background {
                ZStack {
                    ForEach(0..<configs.count, id: \.self) { index in
                        BubbleView(config: configs[index],animate: animate)
                    }
                }
            }

    }
}




extension View{
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
    public func bubbles(_ configs: [BubbleConfig], animate: Bool = false)
        -> some View
    {
        modifier(BubblesModifier(configs: configs, animate: animate))
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
        color: Color = .primary,
        size: ClosedRange<CGFloat> = 10...30,
        speed: Double = .random(in: 5.0...10.0),
        animate: Bool = false
    ) -> some View {
        let configs = (0..<count).map { _ in
            BubbleConfig(
                size: .random(in: size),
                color: color,
                opacity: .random(in: 0.3...0.7),
                speed: .random(in: speed...speed + .random(in: 0.0...10.0))
            )
        }
        return bubbles(configs, animate: animate)
    }
}

// 预览
#Preview {
    BubblesExample()
}
