import SwiftUI

// 可观察的设置对象
class AppSettings: ObservableObject {
    @Published var username = ""
    @Published var isPremium = false
    @Published var theme = "light"
}

// 主视图
struct ContentView: View {
    @EnvironmentObject var settings: AppSettings  // 从环境获取

    var body: some View {
        VStack(spacing: 20) {
            Text("@Environment 示例")
                .font(.headline)

            // 显示环境对象的内容
            Form {
                Section("用户信息") {
                    TextField("用户名", text: $settings.username)
                        .textFieldStyle(.roundedBorder)

                    Toggle("Premium 会员", isOn: $settings.isPremium)
                }

                Section("主题") {
                    Picker("选择主题", selection: $settings.theme) {
                        Text("浅色").tag("light")
                        Text("深色").tag("dark")
                    }
                }
            }

            Divider()

            // 子组件也能访问环境对象
            ChildView()
        }
        .padding()
    }
}

// 子组件 - 通过 @EnvironmentObject 自动获取
struct ChildView: View {
    @EnvironmentObject var settings: AppSettings

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("子组件 - 也能访问环境对象")
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack {
                Text("用户名: \(settings.username.isEmpty ? "未设置" : settings.username)")
                Spacer()
                Text("Premium: \(settings.isPremium ? "是" : "否")")
            }
            .font(.caption)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
    }
}
