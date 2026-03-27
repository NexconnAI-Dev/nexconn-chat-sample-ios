import UIKit
import CommonModule

final class GroupMembersViewController: LogOutputViewController {
    private var didInitialize = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Group Members"
        addActionButton(title: "1. Initialize & Connect", action: #selector(onSetup))
        addActionButton(title: "2. Fetch Selected Members", action: #selector(onFetchMembers))
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
    private func onFetchMembers() {
        let userIds = SampleConfig.memberUserIds.isEmpty
            ? [SampleConfig.directTargetId]
            : SampleConfig.memberUserIds
        GroupChannelUseCase.getMembers(userIds: userIds) { [weak self] members, error in
            guard let self else { return }
            if let error {
                self.appendLog("Fetch failed: \(error.localizedDescription)")
                return
            }
            let list = members ?? []
            self.appendLog("Fetch succeeded, count=\(list.count)")
            list.forEach { member in
                self.appendLog("- userId=\(member.userId), role=\(member.role.rawValue)")
            }
        }
    }
}
