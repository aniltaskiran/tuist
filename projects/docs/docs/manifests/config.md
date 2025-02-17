---
title: Config.swift
slug: '/manifests/config'
description: This page documents how to use the Config manifest file to configure Tuist's functionalities globally.
---

Tuist can be configured through a `Config.swift` manifest.
When Tuist is executed, it traverses up the directories to find a `Tuist` directory that contains a `Config.swift` file.
Defining a configuration manifest **is not required** but recommended to ensure a consistent behavior across all the projects that are part of the repository.

The example below shows a project that has a global `Config.swift` file that will be used when Tuist is run from any of the subdirectories:

```bash
/.git
.gitignore
/Tuist/Config.swift # Configuration manifest
/Framework/Project.swift
/App/Project.swift
```

That way, when Tuist runs in any of the subdirectories, it'll use the root configuration.

The structure is similar to the project manifest. We need to create a root variable, `config` of type `Config`:

```swift
import ProjectDescription

let config = Config(
    compatibleXcodeVersions: ["10.3"],
    swiftVersion: "5.4.0",
    generationOptions: .options(
        xcodeProjectName: "SomePrefix-\(.projectName)-SomeSuffix",
        organizationName: "Tuist",
        developmentRegion: "de"
    )
)
```

### Config

It allows configuring Tuist and share the configuration across several projects.

| Property                  | Description                                                                                                                    | Type                                                    | Required | Default |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------- | -------- | ------- |
| `compatibleXcodeVersions` | Set the versions of Xcode that the project is compatible with.                                                                 | [`CompatibleXcodeVersions`](#compatible-xcode-versions) | No       | `.all`  |
| `swiftVersion`            | The specified version of Swift that will be used by Tuist. When `nil` is passed then Tuist will use the environment’s version. | Version                                                 | No       |         |
| `generationOptions`       | Options to configure the generation of Xcode projects.                                                                         | [`[GenerationOption]`](#generationoption)               | No       | `[]`    |

### Compatible Xcode versions

This object represents the versions of Xcode the project is compatible with. If a developer tries to generate a project and its selected Xcode version is not compatible with the project, Tuist will yield an error:

| Case                               | Description                                                                                                                    |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `.all`                             | The project is compatible with any version of Xcode.                                                                           |
| `.exact(Version)`                  | The project is compatible with a specific version of Xcode.                                                                    |
| `.upToNextMajor(Version)`          | The project is compatible with any version of Xcode from the specified version up to but not including the next major version. |
| `.upToNextMinor(Version)`          | The project is compatible with any version of Xcode from the specified version up to but not including the next minor version. |
| `.list([CompatibleXcodeVersions])` | The project is compatible with a list of Xcode versions.                                                                       |

:::note ExpressibleByArrayLiteral and ExpressibleByStringLiteral
Note that 'Version' can also be initialized with a string that represents the supported Xcode version.
Note that 'CompatibleXcodeVersions' can also be initialized with a string or array of strings that represent the supported Xcode versions.
:::

### GenerationOption

Generation options allow customizing the generation of Xcode projects.

| Property                                       | Description                                                                                                                                                                                                                                                                                                                                                        |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `templateMacros(IDETemplateMacros)`        | Apply IDE Template macros to your project.                                                                                                                                                                                                                                                                                                                         |
| `resolveDependenciesWithSystemScm`         | Resolve SPM dependencies using your system's SCM credentials, instead of Xcode accounts.                                                                                                                                                                                                                                                                           |
| `disablePackageVersionLocking`             | Disables locking Swift packages. This can speed up generation but does increase risk if packages are not locked in their declarations.                                                                                                                                                                                                                             |

### TemplateString

Allows a string with interpolated properties to be specified. For example, `Prefix-\(.projectname)`.

| Case           | Description                      |
| -------------- | -------------------------------- |
| `.projectName` | The name of the current project. |
