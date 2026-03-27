import Foundation
import NexconnChatSDK

public enum EnvironmentUseCase {
    public static func initializeSDK() {
        let params = InitParams(appKey: SampleConfig.appKey)
        params.naviServer = SampleConfig.naviServer
        NCEngine.initialize(params)
    }
}
