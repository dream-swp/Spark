//
//  Spark+Headers.swift
//  Spark
//
//  Created by Dream on 2025/2/25.
//

// MARK: - Spark.Headers
public extension Spark {
    
    /// Packaging Headers settings Request Head
    struct Headers {
        
        /// Save Headers data for internal use
        private var headers: [Header] = []
        
        /// `Spark.Headers` Initialization method
        public init() {}
        
        /// `Spark.Header` Initialization method
        /// - Parameter headers: [Header]
        public init(headers: [Header]) {
             headers.forEach { update($0) }
        }

        /// `Spark.Headers` Initialization method
        /// - Parameter dictionary: [String: String]
         public init(_ dictionary: [String: String]) {
             dictionary.forEach { update(Header(name: $0.key, value: $0.value)) }
         }
        
    }
}

public extension Spark.Headers {
    
    mutating func update(_ header: Spark.Header) {
        guard let index = headers.index(of: header.name) else {
            headers.append(header)
            return
        }
        headers.replaceSubrange(index...index, with: [header])
    }
    
    mutating func update(name: String, value: String) {
        update(Spark.Header(name: name, value: value))
    }
    
    
    /// `[Spark.Headers]` converts to dictionary data
    var dictionary: [String: String] {
        let namesAndValues = headers.map { ($0.name, $0.value) }
        return Dictionary(namesAndValues, uniquingKeysWith: { _, last in last })
    }
    
}

// MARK: - Spark.Headers: Equatable, Hashable, Sendable
extension Spark.Headers: Equatable, Hashable, Sendable { }

// MARK: - Spark.Headers: Collection
extension Spark.Headers: Collection {
    public var endIndex: Int {
        headers.endIndex
    }
    
    public var startIndex: Int {
        headers.startIndex
    }
    
    public func index(after i: Int) -> Int {
        headers.index(after: i)
    }
    
    public subscript(position: Int) -> Spark.Header {
        headers[position]
    }
}

// MARK: - Spark.Headers: ExpressibleByDictionaryLiteral
extension Spark.Headers: ExpressibleByDictionaryLiteral {
    
    public init(dictionaryLiteral elements: (String, String)...) {
        elements.forEach { update(name: $0.0, value: $0.1) }
    }
    
}

// MARK: - Spark.Headers: ExpressibleByArrayLiteral
extension Spark.Headers: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Spark.Header...) {
        self.init(headers: elements)
    }
}

// MARK: - Spark.Headers: Sequence
extension Spark.Headers: Sequence {
    
    public func makeIterator() ->  IndexingIterator<[Spark.Header]> {
        headers.makeIterator()
    }
}

// MARK: - [Spark.Header]
extension [Spark.Header] {
    func index(of name: String) -> Int? {
        let lowercasedName = name.lowercased()
        return firstIndex { $0.name.lowercased() == lowercasedName }
    }
}
// MARK: -
