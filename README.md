# NexconnChat iOS Samples

This directory contains Tuist-based iOS sample projects that demonstrate common NexconnChat SDK integration patterns and core messaging capabilities.

## Project Structure

- `Apps/*`: Each scenario is an independent app target.
- `Modules/CommonModule`: Shared use cases and reusable UI helpers.
- `Tuist/Package.swift`: SPM dependency declarations used by Tuist.

## Requirements

- Xcode 15 or later
- Tuist (latest version recommended)
- Network access to GitHub and dependency artifact URLs

## Quick Start

Run the following commands in the `Samples` directory:

1. Install dependencies  
   `tuist install`
2. Generate the workspace  
   `tuist generate`
3. Open the workspace  
   `NexconnChatSamples.xcworkspace`
4. Select any scheme and run

## Sample Apps

- `InitAndConnect`: SDK initialization and connection flow
- `ChannelList`: Channel list and basic channel operations
- `SendTextMessage`: Sending text messages
- `SendMediaMessage`: Sending media messages
- `CreateGroupAndSend`: Creating a group and sending messages
- `GroupMembers`: Group member operations
- `NoDisturbSetting`: Do-not-disturb settings

## SDK Dependency

The samples use the remote SPM SDK dependency defined in `Tuist/Package.swift`:

- `https://github.com/NexconnAI-Dev/nexconn-chat-sdk-ios.git`

## Runtime Configuration

Before running the samples, configure `Modules/CommonModule/Sources/Util/SampleConfig.swift`:

- `appKey`: App key
- `token`: User connection token
- `naviServer`: Navigation server URL (optional)
- `directTargetId`: Target user ID for direct chat
- `groupId`: Group ID
- `groupName`: Group name
- `memberUserIds`: Group member user ID list

The repository keeps sanitized placeholders (empty strings / empty array) by default. Replace them with your real test environment values before running.

## Troubleshooting

- **Dependency fetch failed**: Make sure your network can access GitHub and dependency artifact URLs.
- **Build issues after generation**: Run `tuist clean`, then rerun `tuist install && tuist generate`.
