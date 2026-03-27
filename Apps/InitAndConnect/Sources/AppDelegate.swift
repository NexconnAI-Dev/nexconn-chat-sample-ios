import UIKit
import CommonModule

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        BaseAppearance.apply()

        let root = UINavigationController(rootViewController: InitAndConnectViewController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        return true
    }
}
