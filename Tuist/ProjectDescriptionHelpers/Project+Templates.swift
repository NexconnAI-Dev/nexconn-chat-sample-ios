import ProjectDescription

extension Project {
    public static func app(name: String) -> Project {
        Project(
            name: name,
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .app,
                    bundleId: "ai.nexconn.chat.sample.\(name.lowercased())",
                    deploymentTargets: .iOS("13.0"),
                    infoPlist: .extendingDefault(
                        with: [
                            "CFBundleShortVersionString": "1.0",
                            "CFBundleVersion": "1",
                            "UILaunchStoryboardName": "LaunchScreen"
                        ]
                    ),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    dependencies: [
                        .project(
                            target: "CommonModule",
                            path: .relativeToRoot("Modules/CommonModule")
                        )
                    ],
                    settings: .settings(
                        base: SettingsDictionary()
                            .automaticCodeSigning(devTeam: "T7DYH4JM86"),
                        defaultSettings: .recommended
                    )
                )
            ]
        )
    }
}
