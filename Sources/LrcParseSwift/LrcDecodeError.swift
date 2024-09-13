//
//  LrcDecodeError.swift
//  LrcParseSwift
//
//  Created by James on 13/09/2024.
//

public enum LrcDecodeError: Error {
    case invalidLine(_ line: String)
    case invalidTimestamp(_ timestamp: String)
}
