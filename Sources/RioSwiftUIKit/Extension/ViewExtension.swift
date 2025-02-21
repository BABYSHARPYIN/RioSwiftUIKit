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
}
