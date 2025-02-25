
import Foundation

public struct Spark : @unchecked Sendable {
    
    /// `Request Modifier`
    public typealias RequestModifier = (inout URLRequest) throws -> Void
    
    public static let `default` = Spark()
    
    private init() { }

}



