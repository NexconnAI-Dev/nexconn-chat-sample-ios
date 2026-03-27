import UIKit
import CommonModule

final class SendTextMessageViewController: LogOutputViewController {
    private var didInitialize = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Send Text Message"
        addActionButton(title: "1. Initialize & Connect", action: #selector(onSetup))
        addActionButton(title: "2. Send Text Message", action: #selector(onSendText))
    }

    @objc
    private func onSetup() {
        if !didInitialize {
            EnvironmentUseCase.initializeSDK()
            didInitialize = true
        }
        ConnectionUseCase.connect { [weak self] userId, error in
            guard let self else { return }
            if let error {
                self.appendLog("Connection failed: \(error.localizedDescription)")
                return
            }
            self.appendLog("Connected successfully, userId=\(userId ?? "")")
        }
    }

    @objc
    private func onSendText() {
        DirectChannelUseCase.sendText(text: "Hello from SendTextMessage sample.") { [weak self] message, error in
            guard let self else { return }
            if let error {
                self.appendLog("Send failed: \(error.localizedDescription)")
                return
            }
            self.appendLog("Sent successfully, messageId=\(message?.messageId ?? "")")
        }
    }
}
