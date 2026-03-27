import Foundation
import NexconnChatSDK

public enum ChannelListUseCase {
    public static func fetchRecentDirectAndGroup(
        pageSize: Int32 = 20,
        completion: @escaping (_ channels: [BaseChannel]?, _ error: NCError?) -> Void
    ) {
        let params = ChannelsQueryParams()
        params.setChannelTypes([.direct, .group])
        params.pageSize = pageSize
        let query = BaseChannel.createChannelsQuery(params: params)
        query.loadNextPage { page, error in
            completion(page?.data, error)
        }
    }
}
