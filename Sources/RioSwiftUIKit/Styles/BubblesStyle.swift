import SwiftUI

// 气泡配置
public struct BubbleConfig {
    var size: CGFloat
    var color: Color
    var opacity: Double
    var speed: Double

    public init(
        size: CGFloat = 20,
        color: Color = .primary,
        opacity: Double = 0.5,
        speed: Double = 1.0
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
    @State private var isAnimating = false
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0

    init(config: BubbleConfig) {
        self.config = config
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
                    withAnimation(
                        .easeInOut(duration: 2 * config.speed)
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

// 气泡修饰符
struct BubblesModifier: ViewModifier {
    let configs: [BubbleConfig]
    public init(configs: [BubbleConfig]) {
        self.configs = configs
    }
    func body(content: Content) -> some View {

        content
            .background {
                ZStack {
                    ForEach(0..<configs.count, id: \.self) { index in
                        BubbleView(config: configs[index])
                    }
                }
            }

    }
}



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
            .bubbles(count: 10)
            .border(.black)
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

// 预览
#Preview {
    BubblesExample()
}
