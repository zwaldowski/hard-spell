import ArgumentParser
import Foundation
import Spelling

public struct CheckSpelling: ParsableCommand {

    @Argument(help: "Path to file to check")
    var input: URL

    public init() {}

    public func run() throws {
        let checker = try SpellCheck(contentsOf: input)
        let misspellings = checker.run()
        var output = StandardError()
        for misspelling in misspellings {
            print(misspelling, to: &output)
        }
    }

}
