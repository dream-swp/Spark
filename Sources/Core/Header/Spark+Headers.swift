//
//  Spark+Headers.swift
//  Spark
//
//  Created by Dream on 2025/2/25.
//

// MARK: - Headers

/// Packaging Headers settings Request Head
public struct Headers {

    /// Save Headers data for internal use
    private var headers: [Header] = []

    /// `Headers` Initialization method
    public init() {}

    /// `Header` Initialization method
    /// - Parameter headers: [Header]
    public init(headers: [Header]) {
        headers.forEach { update($0) }
    }

    /// `Headers` Initialization method
    /// - Parameter dictionary: [String: String]
    public init(_ dictionary: [String: String]) {
        dictionary.forEach { update(Header(name: $0.key, value: $0.value)) }
    }

    /// `Headers` Initialization method
    /// - Parameter dictionary: [Header.Key: String]
    public init(_ dictionary: [Header.Key: String]) {
        dictionary.forEach { update(Header(key: $0.key, value: $0.value)) }
    }

}

extension Headers {

    /// Added request header data
    /// - Parameters:
    ///   - key: request header `key`
    ///   - value: request header `value`
    public mutating func add(key: Header.Key, value: String) {
        update(key: key, value: value)
    }

    /// Added request header data
    /// - Parameters:
    ///   - name: request header `name`
    ///   - value: request header `value`
    public mutating func add(name: String, value: String) {
        update(name: name, value: value)
    }

    /// Update request header data
    /// - Parameters:
    ///   - key: request header `key`
    ///   - value: request header `value`
    public mutating func update(key: Header.Key, value: String) {
        update(Header(key: key, value: value))
    }

    /// Update request header data
    /// - Parameters:
    ///   - name: request header `name`
    ///   - value: request header `value`
    public mutating func update(name: String, value: String) {
        update(Header(name: name, value: value))
    }

    /// Update request header data
    /// - Parameter header: Header
    public mutating func update(_ header: Header) {
        guard let index = headers.index(of: header.name) else {
            headers.append(header)
            return
        }
        headers.replaceSubrange(index...index, with: [header])
    }

    /// Remove request header data
    /// - Parameter key: request header `key`
    public mutating func remove(key: Header.Key) {
        remove(name: key.rawValue)
    }

    /// Remove request header data
    /// - Parameter name: request header `name`
    public mutating func remove(name: String) {
        guard let index = headers.index(of: name) else { return }
        headers.remove(at: index)
    }

    /// Get the request header data according to the name
    /// - Parameter key: request header `key`
    /// - Returns: request header `value`
    public func value(for key: Header.Key) -> String? {
        value(for: key.rawValue)
    }

    /// Get the request header data according to the name
    /// - Parameter name: request header `name`
    /// - Returns: request header `value`
    public func value(for name: String) -> String? {
        guard let index = headers.index(of: name) else { return nil }
        return headers[index].value
    }

    /// Request header number sorted according to the name
    public mutating func sort() {
        headers.sort { $0.name.lowercased() < $1.name.lowercased() }
    }

    /// Request header number sorted according to the name
    /// - Returns: `Header`
    public func sorted() -> Self {
        var headers = self
        headers.sort()
        return headers
    }

    /// `[Headers]` converts to dictionary data
    public var dictionary: [String: String] {
        let namesAndValues = headers.map { ($0.name, $0.value) }
        return Dictionary(namesAndValues, uniquingKeysWith: { _, last in last })
    }

    /// Get the request header data, according to the index
    /// - Parameter name: request header `name`
    /// - Returns: request header `value`
    public subscript(_ name: String) -> String? {
        get { value(for: name) }
        set {
            if let value = newValue {
                update(name: name, value: value)
            } else {
                remove(name: name)
            }
        }
    }

    /// Get the request header data, according to the index
    /// - Parameter key: request header `key`
    /// - Returns: request header `value`
    public subscript(_ key: Header.Key) -> String? {
        get { value(for: key) }
        set {
            if let value = newValue {
                update(key: key, value: value)
            } else {
                remove(key: key)
            }
        }
    }

}

// MARK: - Headers: Equatable, Hashable, Sendable
extension Headers: Equatable, Hashable, Sendable {}

// MARK: - Headers: Collection
extension Headers: Collection {

    /// first index
    public var startIndex: Int {
        headers.startIndex
    }

    /// last index
    public var endIndex: Int {
        headers.endIndex
    }

    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index immediately after `i`.
    public func index(after i: Int) -> Int {
        headers.index(after: i)
    }

    /// Returns the position immediately before the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be greater than
    ///   `startIndex`.
    /// - Returns: The index immediately before `i`.
    public func index(before i: Int) -> Int {
        headers.index(before: i)
    }

    public subscript(position: Int) -> Header {
        headers[position]
    }
}

// MARK: - Headers: ExpressibleByDictionaryLiteral
extension Headers: ExpressibleByDictionaryLiteral {

    public init(dictionaryLiteral elements: (String, String)...) {
        elements.forEach { update(name: $0.0, value: $0.1) }
    }

}

// MARK: - Headers: ExpressibleByArrayLiteral
extension Headers: ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: Header...) {
        self.init(headers: elements)
    }
}

// MARK: - Headers: Sequence
extension Headers: Sequence {

    public func makeIterator() -> IndexingIterator<[Header]> {
        headers.makeIterator()
    }
}

// MARK: - [Header]
extension [Header] {

    /// Get firstIndex
    /// - Parameter name: name
    /// - Returns: index
    func index(of name: String) -> Int? {
        let lowercasedName = name.lowercased()
        return firstIndex { $0.name.lowercased() == lowercasedName }
    }
}
// MARK: -
