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

    /// 获取设备的安全区域边距值
    ///
    /// 这个属性用于获取当前设备的安全区域插入值，适用于不同iOS版本：
    /// - 在 iOS 15 及以上版本，使用 UIWindowScene API
    /// - 在 iOS 15 以下版本，使用 UIApplication.windows API
    ///
    /// 安全区域通常用于：
    /// - 避免内容被刘海屏、Home Indicator等系统UI遮挡
    /// - 确保视图内容在可视区域内正确显示
    /// - 适配不同设备的屏幕布局
    ///
    /// - Returns: UIEdgeInsets 包含以下值：
    ///   - top: 顶部安全区域高度
    ///   - bottom: 底部安全区域高度
    ///   - left: 左侧安全区域宽度
    ///   - right: 右侧安全区域宽度
    ///
    /// - Note: 如果无法获取安全区域值（例如在App启动初期），将返回 .zero
    ///
    /// 使用示例:
    /// ```
    /// let topPadding = safeAreaInsets.top
    /// let bottomPadding = safeAreaInsets.bottom
    /// ```
    public var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 15.0, *) {
            let scene =
                UIApplication.shared.connectedScenes.first as? UIWindowScene
            return scene?.windows.first?.safeAreaInsets ?? .zero
        } else {
            return UIApplication.shared.windows.first?.safeAreaInsets ?? .zero
        }
    }
}
