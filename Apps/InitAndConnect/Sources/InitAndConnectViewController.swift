import UIKit
import CommonModule

final class InitAndConnectViewController: LogOutputViewController {
    private var didInitialize = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Init & Connect"
        addActionButton(title: "1. Initialize SDK", action: #selector(onInitialize))
        addActionButton(title: "2. Connect", action: #selector(onConnect))
        addActionButton(title: "3. Disconnect", action: #selector(onDisconnect))
        appendLog("Please configure SampleConfig in CommonModule first.")
    }

    @objc
    private func onInitialize() {
        guard !didInitialize else {
            appendLog("SDK already initialized. Skipped.")
            return
        }
        EnvironmentUseCase.initializeSDK()
        didInitialize = true
        appendLog("SDK initialization completed.")
    }

    @objc
    private func onConnect() {
        if !didInitialize { onInitialize() }
        ConnectionUseCase.connect { [weak self] userId, error in
            guard let self else { return }
            if let error {
                self.appendLog("Connection failed: \(error.localizedDescription) (\(error.code))")
                return
            }
            self.appendLog("Connected successfully, userId=\(userId ?? "")")
        }
    }

    @objc
    private func onDisconnect() {
        ConnectionUseCase.disconnect()
        appendLog("Disconnected.")
    }
}
