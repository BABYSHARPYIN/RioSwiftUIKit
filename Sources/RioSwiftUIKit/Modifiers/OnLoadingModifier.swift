//
//  LoadingModifier.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/2/7.
//

import SwiftUI

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
            withAnimation {
                isLoading = false
            }
        }
    }

    var body: some View {
        VStack {
            Text(text.first!)
            Button("Switch Language") {
                isLoading = true
            }

        }

        

        //默认加载的版本
        .onLoading(isLoading: isLoading) {
            await task()
        }

        //自定义 loading 视图版本
        //        .onLoading(isLoading: isLoading) {
        //            // 自定义加载视图
        //            Text("友商是__")
        //                .foregroundStyle(.white)
        //
        //        } perform: {
        //            await task()
        //        }

    }

}

#Preview {
    OnLoadingView()
}
