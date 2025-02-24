//
//  Spark+Headers.swift
//  Spark
//
//  Created by Dream on 2025/2/25.
//


public extension Spark {
    
    struct Headers {
        
        
        /// Save Headers data for internal use
        private var headers: [Header] = []
        
        /// `Headers` Initialization method
        public init() {}
        
//        /// `DSHeader` Initialization method
//        /// - Parameter headers: [DSHeader]
        public init(headers: [Header]) {
             headers.forEach { update($0) }
        }
//        
//        /// `DSHeader` Initialization method
//        /// - Parameter dictionary: [name : value]
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
    
    
}

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

extension Spark.Headers: ExpressibleByDictionaryLiteral {
    
    public init(dictionaryLiteral elements: (String, String)...) {
        elements.forEach { update(name: $0.0, value: $0.1) }
    }
    
}

extension Spark.Headers: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Spark.Header...) {
        self.init(headers: elements)
    }
}

extension Spark.Headers: Sequence {
    
    public func makeIterator() ->  IndexingIterator<[Spark.Header]> {
        headers.makeIterator()
    }
}

extension Array where Element == Spark.Header {

    func index(of name: String) -> Int? {
        let lowercasedName = name.lowercased()
        return firstIndex { $0.name.lowercased() == lowercasedName }
    }
}
