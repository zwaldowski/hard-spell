import Foundation
import ArgumentParser

extension URL: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(fileURLWithPath: argument)
    }

    public var defaultValueDescription: String {
        relativeString
    }

    public static var defaultCompletionKind: CompletionKind {
        .file()
    }
}
