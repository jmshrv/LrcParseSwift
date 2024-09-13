import Foundation

public struct LrcDecoder {
    /// Whether or not to skip leading whitespace. For example, the lyric `[00:11.96] When I was a young boy` will be
    /// decoded as "When I was a young boy" when `true`, and " When I was a young boy" when false.
    public var skipLeadingWhitespace = true
    
    public func decode(from lrc: String) throws -> [(TimeInterval, String)] {
        return try lrc.split { $0.isNewline }
            .map { try decodeLine(String($0)) }
    }
    
    private func decodeLine(_ line: String) throws -> (TimeInterval, String) {
        let regex = /(\[.*\])(.*)/
        
        guard let match = try regex.wholeMatch(in: line) else {
            throw LrcDecodeError.invalidLine(line)
        }
        
        let timestamp = try parseTimestamp(String(match.1))
        let lyric = if skipLeadingWhitespace {
            match.2.trimmingPrefix { $0.isWhitespace }
        } else {
            match.2
        }
        
        return (timestamp, String(lyric))
    }
    
    private func parseTimestamp(_ timestamp: String) throws -> TimeInterval {
        let regex = /\[(\d+):(\d+)\.(\d+)\]/
        
        guard let match = try regex.wholeMatch(in: timestamp) else {
            throw LrcDecodeError.invalidTimestamp(timestamp)
        }
        
        guard let minutes = Double(match.1), let seconds = Double(match.2), let centis = Double(match.3) else {
            throw LrcDecodeError.invalidTimestamp(timestamp)
        }
        
        return (minutes * 60) + seconds + (centis / 100)
    }
}
