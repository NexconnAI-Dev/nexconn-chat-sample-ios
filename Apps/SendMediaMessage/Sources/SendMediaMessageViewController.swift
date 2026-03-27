import UIKit
import CommonModule

final class SendMediaMessageViewController: LogOutputViewController {
    private var didInitialize = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Send Media Message"
        addActionButton(title: "1. Initialize & Connect", action: #selector(onSetup))
        addActionButton(title: "2. Send File Message", action: #selector(onSendFile))
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
    private func onSendFile() {
        guard let path = createTemporaryFile() else {
            appendLog("Local file creation failed. Send aborted.")
            return
        }
        DirectChannelUseCase.sendLocalFile(filePath: path) { [weak self] message, error in
            guard let self else { return }
            if let error {
                self.appendLog("Send failed: \(error.localizedDescription)")
                return
            }
            self.appendLog("Sent successfully, messageId=\(message?.messageId ?? "")")
        }
    }

    private func createTemporaryFile() -> String? {
        let data = Data("Sample media payload".utf8)
        let fileName = "sample-\(Int(Date().timeIntervalSince1970)).txt"
        let path = (NSTemporaryDirectory() as NSString).appendingPathComponent(fileName)
        do {
            try data.write(to: URL(fileURLWithPath: path), options: .atomic)
            return path
        } catch {
            appendLog("Create temporary file failed: \(error.localizedDescription)")
            return nil
        }
    }
}
