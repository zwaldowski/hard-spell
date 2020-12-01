import Foundation
import Spelling

extension SpellCheck.Misspelling: Diagnostic {
    public var errorDescription: String? {
        "Unknown word (\(word))"
    }

    public var start: SourceLocation? {
        SourceLocation(word.startIndex, in: word.base, source: source)
    }

    public var end: SourceLocation? {
        SourceLocation(word.endIndex, in: word.base, source: source)
    }
}
