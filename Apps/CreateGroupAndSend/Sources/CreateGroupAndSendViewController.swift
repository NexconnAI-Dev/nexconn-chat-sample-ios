import UIKit
import CommonModule

final class CreateGroupAndSendViewController: LogOutputViewController {
    private var didInitialize = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Group & Send"
        addActionButton(title: "1. Initialize & Connect", action: #selector(onSetup))
        addActionButton(title: "2. Create Group Channel", action: #selector(onCreateGroup))
        addActionButton(title: "3. Send Group Message", action: #selector(onSendGroupMessage))
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
    private func onCreateGroup() {
        GroupChannelUseCase.createGroup { [weak self] processCode, errorKeys, error in
            guard let self else { return }
            if let error {
                self.appendLog("Create group failed: \(error.localizedDescription), keys=\(errorKeys ?? [])")
                return
            }
            self.appendLog("Group created successfully, processCode=\(processCode)")
        }
    }

    @objc
    private func onSendGroupMessage() {
        GroupChannelUseCase.sendText(text: "Hello from CreateGroupAndSend sample.") { [weak self] message, error in
            guard let self else { return }
            if let error {
                self.appendLog("Group message send failed: \(error.localizedDescription)")
                return
            }
            self.appendLog("Group message sent successfully, messageId=\(message?.messageId ?? "")")
        }
    }
}
