import Foundation
import NexconnChatSDK

public enum ConnectionUseCase {
    public static func connect(completion: @escaping (_ userId: String?, _ error: NCError?) -> Void) {
        let params = ConnectParams(token: SampleConfig.token)
        params.timeout = 15
        NCEngine.connect(
            params: params,
            databaseOpenedHandler: nil,
            completionHandler: completion
        )
    }

    public static func disconnect() {
        NCEngine.disconnect(disablePush: false)
    }
}
