//
//  Input.swift
//  StateMachine
//
//  Created by Zachary Duncan on 7/9/19.
//  Copyright © 2019 Zachary Duncan. All rights reserved.
//

import Foundation

/// This is meant to be subclassed into a collection of static user input properties
/// specific to the StateObject
///
/// e.g. GamepadInput, VehicleInput, ElevatorInput
@objcMembers public class Input: NSObject {
    let debugString: String
    
    static func ==(left: Input, right: Input) -> Bool {
        return left === right
    }
    
    /// Objective-C compatibility method for determining if two States are the same
    ///
    /// - Parameter input: Some input from the user trying to manipulate the StateObject
    /// - Returns: Result of comparison
    func equals(_ input: Input) -> Bool {
        return self == input
    }
    
    init(_ inputString: String) {
        debugString = "[STATE MACHINE]  > Input: \(inputString)"
    }
}

@objcMembers public class PlanInput: Input {
    static let INIT = Input("INIT")
    
    static let FIELD_INTERACTION = Input("FIELD_INTERACTION")
    static let EDIT = Input("EDIT")
    static let DISCARD = Input("DISCARD")
    static let CANCEL = Input("CANCEL")
    static let DONE = Input("DONE")
    static let PRINT = Input("PRINT")
    static let PRINT_SELECTED = Input("PRINT_SELECTED")
    static let PRINT_DATA_SYNCED = Input("PRINT_DATA_SYNCED")
    static let CREATE_TEMPLATE = Input("CREATE_TEMPLATE")
    static let SYNC_COMPLETE = Input("SYNC_COMPLETE")
    static let EXIT = Input("EXIT")
}
