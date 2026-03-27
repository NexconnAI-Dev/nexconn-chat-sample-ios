import Foundation
import NexconnChatSDK

public enum NoDisturbUseCase {
    public static func setForChannelType(
        channelType: ChannelType,
        level: ChannelNoDisturbLevel,
        completion: @escaping (_ error: NCError?) -> Void
    ) {
        let params = ChannelTypeNoDisturbLevelParams()
        params.channelType = channelType
        params.level = level
        BaseChannel.setChannelTypeNoDisturbLevel(params: params, completion: completion)
    }

    public static func setForDirectChannel(
        channelId: String,
        level: ChannelNoDisturbLevel,
        completion: @escaping (_ error: NCError?) -> Void
    ) {
        guard let normalizedChannelId = normalizedNonEmpty(channelId),
              let channel = DirectChannel(channelId: normalizedChannelId) else {
            completion(NCError.error(with: -1))
            return
        }
        channel.setNoDisturbLevel(level, completion: completion)
    }

    public static func setForGroupChannel(
        channelId: String,
        level: ChannelNoDisturbLevel,
        completion: @escaping (_ error: NCError?) -> Void
    ) {
        guard let normalizedChannelId = normalizedNonEmpty(channelId),
              let channel = GroupChannel(channelId: normalizedChannelId) else {
            completion(NCError.error(with: -1))
            return
        }
        channel.setNoDisturbLevel(level, completion: completion)
    }

    private static func normalizedNonEmpty(_ value: String) -> String? {
        let normalizedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return normalizedValue.isEmpty ? nil : normalizedValue
    }
}
