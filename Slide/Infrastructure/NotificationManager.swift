import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    func tryRequestNotificationPermission() async throws {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        
        if settings.authorizationStatus == .notDetermined {
            _ = try await requestNotificationPermission()
        }
    }
    
    func requestNotificationPermission() async throws -> Bool {
        return try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
    }
    
    func scheduleNotification() async throws {
        let content = UNMutableNotificationContent()
        content.title = "Hello!"
        content.body = "이건 SwiftUI에서 보낸 알림이에요."
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        try await UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        // 곧 다가올 알림 지우기
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        // 현재 사용자 폰에 떠 있는 알림 지우기
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func deleteBadgeNumber() {
        // badge 삭제하기
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
}
