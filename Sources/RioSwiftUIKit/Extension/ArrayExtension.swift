//
//  ArrayExtension.swift
//  RioSwiftUIKit
//
//  Created by Rio on 2025/2/8.
//


// 数组安全访问扩展
public extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
