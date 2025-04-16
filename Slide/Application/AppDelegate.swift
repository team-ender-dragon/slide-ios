import UIKit
import UserNotifications
import FirebaseCore
import FirebaseMessaging

// - UNUserNotificationCenter: Local Notification Configuration
// - Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        return true
    }
    
    @MainActor
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any]
    ) async -> UIBackgroundFetchResult {
        return .newData
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("\(#file) - \(error)")
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken else {
            print("\(#file) - FCM Token is nil")
            return
        }
        print("\(#file) - fcmToken: \(fcmToken)")
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: ["token": fcmToken]
        )
        // TODO: If necessary send token to application server.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        return [.list, .banner, .sound, .badge]
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print("\(#file) - \(response)")
    }
}
