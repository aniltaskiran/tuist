import Foundation

/// A workspace representation.
///
/// A workspace manifest needs to be defined in a `Workspace.swift` manifest file.
/// ```swift
/// import ProjectDescription
///
/// let workspace = Workspace(
///     name: "Workspace",
///     projects: ["Projects/**"]
/// )
/// ```

public struct Workspace: Codable, Equatable {
    /// The name of the workspace. Also, the file name of the generated Xcode workspace.
    public let name: String

    /// The paths (or glob patterns) to manifest projects.
    public let projects: [Path]

    /// The custom schemes for the workspace. Default schemes for each target are generated by default.
    public let schemes: [Scheme]

    /// The custom file header template for Xcode built-in file templates.
    public let fileHeaderTemplate: FileHeaderTemplate?

    /// The additional files for the workspace. For project's additional files, see ``Project/additionalFiles``.
    public let additionalFiles: [FileElement]

    /// The generation configuration of the workspace.
    public let generationOptions: GenerationOptions

    public init(
        name: String,
        projects: [Path],
        schemes: [Scheme] = [],
        fileHeaderTemplate: FileHeaderTemplate? = nil,
        additionalFiles: [FileElement] = [],
        generationOptions: GenerationOptions = .options()
    ) {
        self.name = name
        self.projects = projects
        self.schemes = schemes
        self.fileHeaderTemplate = fileHeaderTemplate
        self.additionalFiles = additionalFiles
        self.generationOptions = generationOptions
        dumpIfNeeded(self)
    }
}
