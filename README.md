# NexconnChat Samples (Tuist)

This directory hosts scenario-based iOS sample apps.

## Structure

- `Apps/*`: each scenario is an independent app target.
- `Modules/CommonModule`: shared use cases and UI helpers.
- `Tuist/Package.swift`: package dependencies used by Tuist.

## Remote SDK workflow

1. Ensure `Tuist/Package.swift` points to the remote SDK repository:
   - `https://github.com/NexconnAI-Dev/nexconn-chat-sdk-ios.git`
2. Install Tuist dependencies:
   - `tuist install`
3. Generate Xcode workspace:
   - `tuist generate`
4. Open generated workspace and run any scenario app scheme.

## Runtime configuration

Edit `Modules/CommonModule/Sources/Util/SampleConfig.swift`:

- `appKey`
- `token`
- `naviServer` (optional)
- `directTargetId`
- `groupId`
- `groupName`
- `memberUserIds`

Default values in repository are intentionally sanitized (empty placeholders).
Fill in your own environment-specific values before running sample apps.

## Publish safety check

Before publishing this sample project, run:

- `bash scripts/check_samples_sanitized.sh`

The script verifies that `SampleConfig.swift` does not contain real runtime credentials.
