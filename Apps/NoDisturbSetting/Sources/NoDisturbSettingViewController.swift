import UIKit
import CommonModule
import NexconnChatSDK

final class NoDisturbSettingViewController: LogOutputViewController {
    private var didInitialize = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "No Disturb Setting"
        addActionButton(title: "1. Initialize & Connect", action: #selector(onSetup))
        addActionButton(title: "2. Set Direct DND", action: #selector(onSetDirect))
        addActionButton(title: "3. Set Group DND", action: #selector(onSetGroup))
        addActionButton(title: "4. Set DND by Channel Type", action: #selector(onSetTypeLevel))
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
    private func onSetDirect() {
        NoDisturbUseCase.setForDirectChannel(
            channelId: SampleConfig.directTargetId,
            level: .muted
        ) { [weak self] error in
            guard let self else { return }
            if let error {
                self.appendLog("Set direct DND failed: \(error.localizedDescription)")
                return
            }
            self.appendLog("Direct channel DND set to muted.")
        }
    }

    @objc
    private func onSetGroup() {
        NoDisturbUseCase.setForGroupChannel(
            channelId: SampleConfig.groupId,
            level: .mention
        ) { [weak self] error in
            guard let self else { return }
            if let error {
                self.appendLog("Set group DND failed: \(error.localizedDescription)")
                return
            }
            self.appendLog("Group channel DND set to mention.")
        }
    }

    @objc
    private func onSetTypeLevel() {
        NoDisturbUseCase.setForChannelType(
            channelType: .group,
            level: .mentionAll
        ) { [weak self] error in
            guard let self else { return }
            if let error {
                self.appendLog("Set DND by type failed: \(error.localizedDescription)")
                return
            }
            self.appendLog("Group channel type DND set to mentionAll.")
        }
    }
}
