//
//  LightweightCommand.swift
//  SwiftCLI
//
//  Created by Jake Heiser on 7/25/14.
//  Copyright (c) 2014 jakeheis. All rights reserved.
//

/// Can be instantiated and configured as a fully functional command rather
/// than manually implementing CommandType. Should only be used for simple commands
public class LightweightCommand: OptionCommand {
    
    public var name: String = ""
    public var shortDescription: String = ""
    public var arguments: [(String, Arg)] = []
    
    public var failOnUnrecognizedOptions = true
    public var unrecognizedOptionsPrintingBehavior: UnrecognizedOptionsPrintingBehavior = .printAll
    
    public typealias ExecutionBlock = (_ arguments: [String: Arg]) throws -> ()
    public typealias OptionsSetupBlock = (_ options: OptionRegistry) -> ()
    
    public var executionBlock: ExecutionBlock? = nil
    public var optionsSetupBlock: OptionsSetupBlock? = nil
    
    public init(name: String) {
        self.name = name
    }
    
    public func setupOptions(options: OptionRegistry) {
        optionsSetupBlock?(options)
    }
    
    public func execute() throws {
        var dict: [String: Arg] = [:]
        for arg in arguments {
            dict[arg.0] = arg.1
        }
        try executionBlock?(dict)
    }
    
}
