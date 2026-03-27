import ProjectDescription

let project = Project(
    name: "CommonModule",
    targets: [
        .target(
            name: "CommonModule",
            destinations: .iOS,
            product: .framework,
            bundleId: "ai.nexconn.chat.CommonModule",
            deploymentTargets: .iOS("13.0"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .external(name: "NexconnChat")
            ],
            settings: .settings(
                base: SettingsDictionary()
                    .automaticCodeSigning(devTeam: "T7DYH4JM86"),
                defaultSettings: .recommended
            )
        )
    ]
)
