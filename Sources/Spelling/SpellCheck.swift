import AppKit

public struct SpellCheck {

    public struct Misspelling {
        public let word: Substring
        public let source: URL?
    }

    let string: String
    let source: URL?
    let checker = NSSpellChecker()

    public init(contentsOf url: URL) throws {
        self.source = url
        self.string = try String(contentsOf: url)
    }

    public init<S>(string: S) where S: StringProtocol {
        self.source = nil
        self.string = String(string)
    }

    public func run() -> [Misspelling] {
        var options = [NSSpellChecker.OptionKey: Any]()
        options[.documentURL] = source

        let checkingResults = checker.check(string, range: NSRange(0 ..< string.utf16.count), types: NSTextCheckingResult.CheckingType.spelling.rawValue, options: options, inSpellDocumentWithTag: 0, orthography: nil, wordCount: nil)

        return checkingResults.compactMap { (result) in
            guard result.resultType == .spelling,
                  let range = Range(result.range, in: string) else { return nil }
            return Misspelling(word: string[range], source: source)
        }
    }

}

// MARK: -

extension SpellCheck.Misspelling: CustomDebugStringConvertible {
    public var debugDescription: String {
        String(word)
    }
}
