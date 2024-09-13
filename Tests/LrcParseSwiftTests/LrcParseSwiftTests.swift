import Testing
@testable import LrcParseSwift

@Test func parseLine() async throws {
    let line = "[00:11.96] When I was a young boy"
    let expected = (11.96, "When I was a young boy")
    
    let actual = try LrcDecoder().decode(from: line)
    
    #expect(actual.count == 1)
    #expect(expected == actual.first!)
}

@Test func parse() async throws {
    let verse = """
    [00:11.96] When I was a young boy
    [00:15.49] My father took me into the city
    [00:19.77] To see a marching band
    [00:24.45] He said, "Son, when you grow up
    [00:27.74] Would you be the savior of the broken
    [00:32.85] The beaten and the damned?"
    [00:37.21] He said, "Will you defeat them?
    [00:40.68] Your demons, and all the non-believers
    [00:45.04] The plans that they have made?"
    [00:49.70] "Because one day, I'll leave you a phantom
    [00:55.13] To lead you in the summer
    [00:58.29] To join the black parade"
    """
    
    let expected = [
        (11.96, "When I was a young boy"),
        (15.49, "My father took me into the city"),
        (19.77, "To see a marching band"),
        (24.45, "He said, \"Son, when you grow up"),
        (27.74, "Would you be the savior of the broken"),
        (32.85, "The beaten and the damned?\""),
        (37.21, "He said, \"Will you defeat them?"),
        (40.68, "Your demons, and all the non-believers"),
        (45.04, "The plans that they have made?\""),
        (49.70, "\"Because one day, I'll leave you a phantom"),
        (55.13, "To lead you in the summer"),
        (58.29, "To join the black parade\"")
    ]
    
    let actual = try LrcDecoder().decode(from: verse)
    
    #expect(expected.count == actual.count)
    
    for i in 0..<actual.count {
        #expect(expected[i] == actual[i])
    }
}
