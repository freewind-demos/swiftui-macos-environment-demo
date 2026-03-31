import SwiftUI

@main
struct EnvironmentApp: App {
    @StateObject private var appSettings = AppSettings()

    var body: some Scene {
        Window("@Environment 环境注入", id: "main") {
            ContentView()
                .environmentObject(appSettings)  // 注入环境对象
        }
        .defaultSize(width: 500, height: 500)
    }
}
