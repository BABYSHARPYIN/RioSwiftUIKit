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

// 深色模式预览
struct DarkModeDemo: View {
    var body: some View {
        ReadableViewDemo()
            .preferredColorScheme(.dark)
    }
}

// 预览
#Preview("Light Mode") {
    ReadableViewDemo()
}

#Preview("Dark Mode") {
    DarkModeDemo()
}
