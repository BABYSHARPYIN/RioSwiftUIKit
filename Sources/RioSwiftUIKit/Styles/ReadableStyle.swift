import SwiftUI

// 可读性修饰符
struct ReadableViewModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    // 根据当前主题返回适应性颜色
    private var adaptiveColor: Color {
        colorScheme == .dark ? .white : .black
    }

    func body(content: Content) -> some View {
        content
            .background {
                // 根据当前主题自适应渐变色
                LinearGradient(
                    colors: [
                        .clear,
                        adaptiveColor.opacity(0.3),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
    }

}

// 使用示例
struct ReadableViewDemo: View {
    var body: some View {
        ZStack {
            // 背景
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // 基本用法
                Text("Hello World")
                    .font(.title)
                    .padding()
                    .readable()
                    .cornerRadius(20)

                // 自定义样式
                Text("Custom Style")
                    .font(.title2)
                    .padding()
                    .readable()
                    .cornerRadius(20)

                // 组合内容
                VStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.title)
                    Text("Featured Content")
                    Text("With multiple lines\nof text")
                        .multilineTextAlignment(.center)
                }
                .padding()
                .readable()
                .cornerRadius(20)
            }
            .foregroundStyle(.white)
        }
    }
}


extension View{
    /// 为视图添加可读性增强效果
    ///
    /// 自动适应深色/浅色模式，为内容添加适当的背景效果使其更易读。
    ///
    /// Example usage:
    /// ```swift
    /// // 基本用法
    /// Text("Hello World")
    ///     .readable()
    ///
    /// // 自定义配置
    /// Text("Custom Style")
    ///     .readable(
    ///         gradientOpacity: 0.2,
    ///         padding: 12,
    ///         cornerRadius: 10
    ///     )
    /// ```
    ///
    /// - Returns: 添加了可读性增强效果的视图
    public func readable() -> some View {
        modifier(
            ReadableViewModifier()
        )
    }
}

// 预览
#Preview {
    ReadableViewDemo()
}
