import UIKit
import CommonModule
import NexconnChatSDK

final class ChannelListViewController: LogOutputViewController {
    private var didInitialize = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Channel List"
        addActionButton(title: "1. Initialize & Connect", action: #selector(onSetup))
        addActionButton(title: "2. Fetch Direct + Group Channels", action: #selector(onFetch))
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
    private func onFetch() {
        ChannelListUseCase.fetchRecentDirectAndGroup { [weak self] channels, error in
            guard let self else { return }
            if let error {
                self.appendLog("Query failed: \(error.localizedDescription)")
                return
            }
            let list = channels ?? []
            self.appendLog("Query succeeded, count=\(list.count)")
            list.forEach { channel in
                self.appendLog("- \(self.channelTypeText(channel.channelType)) / \(channel.channelId)")
            }
        }
    }

    private func channelTypeText(_ type: ChannelType) -> String {
        switch type {
        case .direct:
            return "direct"
        case .group:
            return "group"
        case .open:
            return "open"
        case .system:
            return "system"
        case .community:
            return "community"
        }
    }
}
