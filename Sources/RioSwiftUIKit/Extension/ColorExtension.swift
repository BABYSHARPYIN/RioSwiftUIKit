//
//  ColorExtension.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/1/14.
//

import Foundation
import SwiftUI

extension Color {
    /// 使用十六进制字符串创建颜色
    /// - Parameter hex: 十六进制颜色字符串，支持以下格式：
    ///   - RGB: 3位十六进制值 (例如: "FFF")
    ///   - RGB: 6位十六进制值 (例如: "FFFFFF")
    ///   - ARGB: 8位十六进制值 (例如: "FFFFFFFF")
    public init(hex: String) {
        let hex = hex.trimmingCharacters(
            in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a: UInt64
        let r: UInt64
        let g: UInt64
        let b: UInt64
        switch hex.count {
        case 3:  // RGB (12-bit)
            (a, r, g, b) = (
                255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17
            )
        case 6:  // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:  // ARGB (32-bit)
            (a, r, g, b) = (
                int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF
            )
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    /// 生成随机颜色
    /// - Returns: 具有随机 RGB 值的颜色
    public static func random() -> Color {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}
