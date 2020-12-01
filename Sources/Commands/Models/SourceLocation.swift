import Foundation

public struct SourceLocation: Hashable {
    public let line: Int
    public let column: Int
    public let source: URL?

    public init(line: Int, column: Int, source: URL? = nil) {
        self.line = line
        self.column = column
        self.source = source
    }
}

extension SourceLocation: CustomStringConvertible {
    public var description: String {
        var description = ""
        if let path = source?.relativePath, !path.isEmpty {
            description += "\(path):"
        }
        description += "\(line):\(column)"
        return description
    }
}

extension SourceLocation: Comparable {
    public static func < (lhs: SourceLocation, rhs: SourceLocation) -> Bool {
        if lhs.line < rhs.line {
            return true
        } else if lhs.line == rhs.line {
            return lhs.column < rhs.column
        } else {
            return false
        }
    }
}

extension SourceLocation {
    init(_ location: String.Index, in string: String, source: URL? = nil) {
        let range = string.lineRange(for: location ..< location)
        let column = 1 + string[range.lowerBound ..< location].count
        var line = 1
        string.enumerateSubstrings(in: ..<range.lowerBound, options: [.byLines, .substringNotRequired]) { _, _, _, _ in
            line += 1
        }
        self.init(line: line, column: column, source: source)
    }
}

public typealias SourceRange = Range<SourceLocation>

extension SourceRange {
    init(_ range: Range<String.Index>, in string: String, source: URL? = nil) {
        self = SourceLocation(range.lowerBound, in: string, source: source) ..< SourceLocation(range.upperBound, in: string, source: source)
    }
}
