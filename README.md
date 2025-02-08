# RioSwiftUIKit

A lightweight, elegant SwiftUI extension library that provides a collection of commonly used view modifiers and utilities.

[![Swift](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platforms-iOS%2014.0+-blue.svg)](https://developer.apple.com/ios/)
[![SPM](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Features

- 🎨 Rich Visual Effects
- 🔄 Animation Utilities
- 💡 Enhanced Readability
- 🛠 Easy to Use
- 📱 iOS 14.0+ Support
- 🎯 SwiftUI Native

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/RioSwiftUIKit.git", from: "1.0.0")
]
```

## Usage

### View Extensions

#### Reverse Mask Effect
```swift
Color.blue
    .frame(width: 200, height: 200)
    .reverseMask {
        Circle()
            .frame(width: 100, height: 100)
    }
```

#### Light Stroke Effect
```swift
RoundedRectangle(cornerRadius: 12)
    .frame(width: 200, height: 100)
    .lightStroke(
        contentShape: RoundedRectangle(cornerRadius: 12),
        strokeLineWidth: 2,
        gradientColors: [.white, .clear, .white]
    )
```

#### Ambilight Effect
```swift
RoundedRectangle(cornerRadius: 12)
    .fill(.blue)
    .frame(width: 200, height: 100)
    .ambilightStyle(
        contentShape: RoundedRectangle(cornerRadius: 12),
        colors: [.red, .blue, .green],
        blur: 20,
        animate: true
    )
```

#### Shake Animation
```swift
Text("Shake me!")
    .onShake(amplitude: 5) {
        print("View was shaken!")
    }
```

#### Shimmer Effect
```swift
Text("Loading...")
    .shimmer(
        contentShape: RoundedRectangle(cornerRadius: 12),
        animate: true,
        color: .white
    )
```

#### Loading State
```swift
Button("Load Data") {
    isLoading = true
}
.onLoading(isLoading: isLoading) {
    VStack {
        ProgressView()
        Text("Processing...")
    }
} perform: {
    await loadDataTask()
}
```

#### Bubble Effect
```swift
Text("Bubble Effect")
    .bubbles(
        count: 15,
        color: .blue,
        size: 10...30,
        animate: true
    )
```

#### Break Style Effect
```swift
Text("Glitch Effect")
    .breakStyle(offsetLevel: 5)
```

#### Readable Background
```swift
Text("Enhanced Readability")
    .readable()
```

### Color Extensions

#### Hex Color Initialization
```swift
Color(hex: "#FF5733")
// or
Color(hex: "FF5733")
```

#### Random Color Generation
```swift
let randomColor = Color.random()
```

### Array Extensions

#### Safe Subscript Access
```swift
let array = [1, 2, 3]
let element = array[safe: 5] // Returns nil instead of crashing
```

## Requirements

- iOS 14.0+
- Swift 5.5+
- Xcode 13.0+

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

RioSwiftUIKit is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Author

Rio

## Support

If you like this project, please ⭐️ star this repo and share it with others.

---

Made with ❤️ by Rio



# RioSwiftUIKit

一个轻量级、优雅的 SwiftUI 扩展库，提供了一系列常用的视图修饰符和实用工具。

[English](README.md) | 中文

[![Swift](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platforms-iOS%2014.0+-blue.svg)](https://developer.apple.com/ios/)
[![SPM](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 特性

- 🎨 丰富的视觉效果
- 🔄 动画工具集
- 💡 增强可读性
- 🛠 使用简便
- 📱 支持 iOS 14.0+
- 🎯 原生 SwiftUI 支持

## 安装

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/RioSwiftUIKit.git", from: "1.0.0")
]
```

## 使用方法

### 视图扩展

#### 反向遮罩效果
```swift
Color.blue
    .frame(width: 200, height: 200)
    .reverseMask {
        Circle()
            .frame(width: 100, height: 100)
    }
```

#### 光效描边
```swift
RoundedRectangle(cornerRadius: 12)
    .frame(width: 200, height: 100)
    .lightStroke(
        contentShape: RoundedRectangle(cornerRadius: 12),
        strokeLineWidth: 2,
        gradientColors: [.white, .clear, .white]
    )
```

#### 环形光效果
```swift
RoundedRectangle(cornerRadius: 12)
    .fill(.blue)
    .frame(width: 200, height: 100)
    .ambilightStyle(
        contentShape: RoundedRectangle(cornerRadius: 12),
        colors: [.red, .blue, .green],
        blur: 20,
        animate: true
    )
```

#### 抖动动画
```swift
Text("抖动效果")
    .onShake(amplitude: 5) {
        print("视图被抖动！")
    }
```

#### 光泽扫过效果
```swift
Text("加载中...")
    .shimmer(
        contentShape: RoundedRectangle(cornerRadius: 12),
        animate: true,
        color: .white
    )
```

#### 加载状态
```swift
Button("加载数据") {
    isLoading = true
}
.onLoading(isLoading: isLoading) {
    VStack {
        ProgressView()
        Text("处理中...")
    }
} perform: {
    await loadDataTask()
}
```

#### 气泡效果
```swift
Text("气泡效果")
    .bubbles(
        count: 15,
        color: .blue,
        size: 10...30,
        animate: true
    )
```

#### 故障风格效果
```swift
Text("故障效果")
    .breakStyle(offsetLevel: 5)
```

#### 可读性背景
```swift
Text("增强可读性")
    .readable()
```

### 颜色扩展

#### 十六进制颜色初始化
```swift
Color(hex: "#FF5733")
// 或
Color(hex: "FF5733")
```

#### 随机颜色生成
```swift
let randomColor = Color.random()
```

### 数组扩展

#### 安全下标访问
```swift
let array = [1, 2, 3]
let element = array[safe: 5] // 返回 nil 而不是崩溃
```

## 系统要求

- iOS 14.0+
- Swift 5.5+
- Xcode 13.0+

## 示例项目

查看和运行 `Example` 目录中的示例项目，了解所有可用的功能。

## 贡献

欢迎提交 Pull Request 来贡献代码！

## 待办事项

- [ ] macOS 支持
- [ ] 更多动画效果
- [ ] 单元测试覆盖
- [ ] 文档完善

## 许可证

RioSwiftUIKit 基于 MIT 许可证开源。查看 [LICENSE](LICENSE) 文件了解更多信息。

## 作者

Rio

## 支持

如果你喜欢这个项目，请给这个仓库一个 ⭐️ star，并分享给其他人。

## 更新日志

### 1.0.0

- 初始发布
- 基础视图修饰符
- 动画效果
- 实用工具扩展

---

用 ❤️ 制作 by Rio
