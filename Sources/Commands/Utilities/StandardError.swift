import Darwin

struct StandardError: TextOutputStream {
    func write(_ string: String) {
        fputs(string, Darwin.stderr)
    }
}
