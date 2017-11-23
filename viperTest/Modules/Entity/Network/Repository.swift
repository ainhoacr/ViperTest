//
//  Repository.swift
//  viperTest
//
//  Created by Ainhoa Calviño on 11/11/17.
//  Copyright © 2017 Ainhoa. All rights reserved.
//

import Foundation
import ObjectMapper

public final class Repository: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let fork = "fork"
        static let descriptionValue = "description"
        static let owner = "owner"
        static let name = "name"
    }
    
    // MARK: Properties
    public var fork: Bool? = false
    public var descriptionValue: String?
    public var owner: Owner?
    public var name: String?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
        
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        fork <- map[SerializationKeys.fork]
        descriptionValue <- map[SerializationKeys.descriptionValue]
        owner <- map[SerializationKeys.owner]
        name <- map[SerializationKeys.name]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary[SerializationKeys.fork] = fork
        if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
        if let value = owner { dictionary[SerializationKeys.owner] = value.dictionaryRepresentation() }
        if let value = name { dictionary[SerializationKeys.name] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.fork = aDecoder.decodeBool(forKey: SerializationKeys.fork)
        self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
        self.owner = aDecoder.decodeObject(forKey: SerializationKeys.owner) as? Owner
        self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(fork, forKey: SerializationKeys.fork)
        aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
        aCoder.encode(owner, forKey: SerializationKeys.owner)
        aCoder.encode(name, forKey: SerializationKeys.name)
    }
    
}

