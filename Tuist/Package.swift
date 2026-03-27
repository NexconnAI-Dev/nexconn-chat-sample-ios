// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [:]
)
#endif

let package = Package(
    name: "NexconnChatSamples",
    dependencies: [
        // Remote SDK dependency from GitHub with fixed version.
        .package(url: "https://github.com/NexconnAI-Dev/nexconn-chat-sdk-ios.git", exact: "26.1.0")
    ]
)
