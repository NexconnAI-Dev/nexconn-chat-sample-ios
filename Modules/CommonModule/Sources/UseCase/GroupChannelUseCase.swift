import Foundation
import NexconnChatSDK

public enum GroupChannelUseCase {
    public static func createGroup(
        groupId: String = SampleConfig.groupId,
        groupName: String = SampleConfig.groupName,
        inviteeUserIds: [String] = SampleConfig.memberUserIds,
        completion: @escaping (_ processCode: Int, _ errorKeys: [String]?, _ error: NCError?) -> Void
    ) {
        guard let normalizedGroupId = normalizedNonEmpty(groupId),
              let normalizedGroupName = normalizedNonEmpty(groupName) else {
            completion(0, nil, NCError.error(with: -1))
            return
        }
        let params = CreateGroupParams(groupId: normalizedGroupId, groupName: normalizedGroupName)
        params.inviteeUserIds = inviteeUserIds
        GroupChannel.createGroup(params: params, completion: completion)
    }

    public static func sendText(
        groupId: String = SampleConfig.groupId,
        text: String,
        completion: @escaping (_ message: Message?, _ error: NCError?) -> Void
    ) {
        guard let normalizedGroupId = normalizedNonEmpty(groupId),
              let channel = GroupChannel(channelId: normalizedGroupId) else {
            completion(nil, NCError.error(with: -1))
            return
        }
        let content = TextMessage(text: text)
        let params = SendMessageParams(content: content)
        channel.sendMessage(params: params, attachedHandler: nil, completionHandler: completion)
    }

    public static func getMembers(
        groupId: String = SampleConfig.groupId,
        userIds: [String],
        completion: @escaping (_ members: [GroupMemberInfo]?, _ error: NCError?) -> Void
    ) {
        guard let normalizedGroupId = normalizedNonEmpty(groupId),
              let channel = GroupChannel(channelId: normalizedGroupId) else {
            completion(nil, NCError.error(with: -1))
            return
        }
        channel.getMembers(userIds: userIds, completion: completion)
    }

    private static func normalizedNonEmpty(_ value: String) -> String? {
        let normalizedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return normalizedValue.isEmpty ? nil : normalizedValue
    }
}
