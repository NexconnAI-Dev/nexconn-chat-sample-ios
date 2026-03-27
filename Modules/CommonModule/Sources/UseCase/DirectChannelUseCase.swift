import Foundation
import NexconnChatSDK

public enum DirectChannelUseCase {
    public static func sendText(
        targetId: String = SampleConfig.directTargetId,
        text: String,
        completion: @escaping (_ message: Message?, _ error: NCError?) -> Void
    ) {
        guard let normalizedTargetId = normalizedNonEmpty(targetId),
              let channel = DirectChannel(channelId: normalizedTargetId) else {
            completion(nil, NCError.error(with: -1))
            return
        }
        let content = TextMessage(text: text)
        let params = SendMessageParams(content: content)
        channel.sendMessage(params: params, attachedHandler: nil, completionHandler: completion)
    }

    public static func sendLocalFile(
        targetId: String = SampleConfig.directTargetId,
        filePath: String,
        completion: @escaping (_ message: Message?, _ error: NCError?) -> Void
    ) {
        guard let normalizedTargetId = normalizedNonEmpty(targetId),
              let normalizedFilePath = normalizedNonEmpty(filePath),
              let channel = DirectChannel(channelId: normalizedTargetId) else {
            completion(nil, NCError.error(with: -1))
            return
        }
        let fileContent = FileMessage(localPath: normalizedFilePath)
        let params = SendMediaMessageParams(content: fileContent)
        channel.sendMediaMessage(
            params: params,
            attachedHandler: nil,
            progressHandler: nil,
            completionHandler: completion,
            cancelHandler: nil
        )
    }

    private static func normalizedNonEmpty(_ value: String) -> String? {
        let normalizedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return normalizedValue.isEmpty ? nil : normalizedValue
    }
}
