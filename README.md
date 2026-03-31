# SwiftUI macOS @Environment 环境注入

## 简介

演示 SwiftUI 中 @Environment 和 @EnvironmentObject 的用法，用于在视图层级中共享数据。

## 快速开始

```bash
cd swiftui-macos-environment-demo
xcodegen generate
open SwiftUIEnvironmentDemo.xcodeproj
# Cmd+R 运行
```

## 概念讲解

### 定义可观察对象

```swift
class AppSettings: ObservableObject {
    @Published var username = ""
    @Published var isPremium = false
}
```

### 在根视图注入

```swift
@StateObject private var settings = AppSettings()

var body: some Scene {
    Window("App") {
        ContentView()
            .environmentObject(settings)  // 注入
    }
}
```

### 在子组件中获取

```swift
struct ChildView: View {
    @EnvironmentObject var settings: AppSettings  // 自动获取

    var body: some View {
        Text(settings.username)
    }
}
```

### 内置环境值

SwiftUI 提供了很多内置的环境值：

```swift
@Environment(\.colorScheme) var colorScheme  // 浅色/深色
@Environment(\.managedObjectContext) var context  // Core Data
@Environment(\.openWindow) var openWindow  // 窗口管理
```

## 完整示例

```swift
class Settings: ObservableObject {
    @Published var username = ""
}

@main
struct MyApp: App {
    @StateObject private var settings = Settings()

    var body: some Scene {
        Window("App") {
            ContentView()
                .environmentObject(settings)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var settings: Settings

    var body: some View {
        VStack {
            TextField("用户名", text: $settings.username)
            ChildView()
        }
    }
}
```

## 完整讲解（中文）

### @Environment vs @EnvironmentObject

| 特性 | @Environment | @EnvironmentObject |
|------|--------------|-------------------|
| 用途 | 获取系统/框架值 | 共享自定义对象 |
| 定义方式 | 系统预设 | 需创建 ObservableObject |
| 注入方式 | 自动可用 | 需 .environmentObject() |

### 使用场景

- **全局设置**：用户偏好、主题、语言
- **共享状态**：登录用户信息、全局配置
- **系统服务**：文件管理、窗口管理

### 注意事项

1. 子组件通过 `@EnvironmentObject` 获取
2. 父组件用 `.environmentObject()` 注入
3. 类型必须匹配
4. 适合深度嵌套的组件树
