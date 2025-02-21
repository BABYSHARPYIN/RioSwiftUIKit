//
//  LoadingModifier.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/2/7.
//

import SwiftUI

// 使用示例
struct OnLoadingView: View {
    @State private var isLoading = false
    @State private var text = ["Hello, World!", "你好,世界!"]
    private func task() async {
        // 模拟异步任务
        try? await Task.sleep(nanoseconds: 2_000_000_000)  // 2秒
        text.reverse()

        // 完成后更新状态
        await MainActor.run {
            isLoading = false
        }
    }

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.thinMaterial)
                .frame(width: 100, height: 100)
                .ambilightStyle(
                    contentShape: RoundedRectangle(cornerRadius: 20)
                )
                .overlay {
                    Image(systemName: "person")
                        .resizable().aspectRatio(contentMode: .fit).frame(
                            width: 50, height: 50
                        )
                        .foregroundStyle(.white.opacity(0.5))
                }
                .shimmer(contentShape: RoundedRectangle(cornerRadius: 20))

            Text(text.first!)

            Button("Switch Language") {
                isLoading = true
            }
        }
        //默认加载的版本
        .onLoading(isLoading: isLoading) {
            await task()
        }
    }

}

// 定义 Loading 视图修饰符
public struct OnLoadingModifier: ViewModifier {
    // loading 状态
    let isLoading: Bool
    // loading 文案
    let loadingText: String
    // loading 时执行的任务
    let task: () async -> Void
    // 自定义的 loading 页面
    let loadingView: (() -> AnyView)?

    public init(
        isLoading: Bool, loadingText: String, task: @escaping () async -> Void,
        loadingView: (() -> AnyView)?, isShowingLoader: Bool = false
    ) {
        self.isLoading = isLoading
        self.loadingText = loadingText
        self.task = task
        self.loadingView = loadingView
        self.isShowingLoader = isShowingLoader
    }

    // 内部状态，用于控制 loading 视图的显示
    @State private var isShowingLoader = false

    public func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)  // 在 loading 时禁用内容交互

            if isLoading && isShowingLoader {
                // loading 遮罩层
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)

                if let customView = loadingView {
                    // 使用自定义 loading 视图
                    customView()
                } else {
                    // 默认 loading 指示器
                    defaultLoadingView
                }
            }
        }
        .onChange(of: isLoading) { newValue in
            if newValue {
                // 显示 loading 并执行任务
                withAnimation {
                    isShowingLoader = true
                }

                // 在后台执行任务
                Task {
                    await task()
                }
            } else {
                // 隐藏 loading
                withAnimation {
                    isShowingLoader = false
                }
            }
        }
    }

    private var defaultLoadingView: some View {
        // loading 指示器
        VStack {
            ProgressView()
                .progressViewStyle(
                    CircularProgressViewStyle(tint: .white)
                )
                .scaleEffect(1.5)

            Text(loadingText)
                .foregroundColor(.white)
                .padding(.top, 10)
        }
        .frame(width: 120, height: 120)
        .background(Color.black.opacity(0.7))
        .cornerRadius(10)
    }
}

extension View {
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
}

#Preview {
    OnLoadingView()
}
