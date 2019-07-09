//
//  State.swift
//  StateMachine
//
//  Created by Zachary Duncan on 7/9/19.
//  Copyright © 2019 Zachary Duncan. All rights reserved.
//

import Foundation

/// Controls the look and behavior of a StateObject
@objc protocol State {
    /// Takes an Input that relates to the StateObject you're controlling. It will then
    /// determine what State the StateObject will be in next
    ///
    /// - Parameters:
    ///   - input: Some input from the user trying to manipulate the StateObject
    ///   - stateObject: The object that is being controlled by the StateMachine
    /// - Returns: The new State that the StateObject is in. It will be nil if
    /// the State is unchanged
    @objc func handle(_ input: Input, stateObject: StateObject) -> State?
    
    /// Runs only once upon entering this State
    ///
    /// - Parameter stateObject: The object that is being controlled by the StateMachine
    @objc func enter(_ stateObject: StateObject)
    
    /// Runs everytime this State handles an Input and is not exiting
    ///
    /// - Parameter stateObject: The object that is being controlled by the StateMachine
    @objc func render(_ stateObject: StateObject)
    
    /// Runs only once when changing State
    ///
    /// - Parameter stateObject: The object that is being controlled by the StateMachine
    @objc func exit(_ stateObject: StateObject)
    
    /// Objective-C compatibility method for determining if two States are the same
    ///
    /// - Parameter state: Object that encapsulates the look and behavior of a StateObject
    /// - Returns: Result of comparison
    @objc func isState(_ state: State.Type) -> Bool
    
    /// Objective-C compatibility method for determining if two States are the same
    ///
    /// - Parameter state: Object that encapsulates the look and behavior of a StateObject
    /// - Returns: Result of comparison
    @objc func equals(_ state: State) -> Bool
}

extension State {
    static func ==(left: State, right: State) -> Bool {
        return left.isState(type(of: right))
    }
    
    static func !=(left: State, right: State) -> Bool {
        return !(left.isState(type(of: right)))
    }
}
