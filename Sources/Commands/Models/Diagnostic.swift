import Foundation

public protocol Diagnostic: LocalizedError, CustomStringConvertible {
    var start: SourceLocation? { get }
    var end: SourceLocation? { get }
}

public extension Diagnostic {
    var start: SourceLocation? { nil }
    var end: SourceLocation? { nil }

    var commandLineDescription: String {
        var result = ""
        if let location = start ?? end {
            result += "\(location) - "
        }
        result += localizedDescription
        return result
    }

    var description: String {
        commandLineDescription
    }
}
