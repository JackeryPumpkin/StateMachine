//
//  StateMachine.swift
//  StateMachine
//
//  Created by Zachary Duncan on 7/9/19.
//  Copyright © 2019 Zachary Duncan. All rights reserved.
//

import Foundation

/// This is the master controller for the flow of States and Inputs in a StateObject.
@objcMembers public class StateMachine: NSObject {
    /// The StateObject's current State
    var state: State { return _state }
    private var _state: State
    
    /// The State that the StateObject was in before the current one
    var lastState: State { return _lastState }
    private var _lastState: State
    
    /// The State that the StateObject was in initially
    let firstState: State
    
    /// The StateObject handling Input from the user to determine State
    private var stateObject: StateObject?
    
    /// Creates a new StateMachine which tracks the first, last and current State
    /// of the StateObject.
    ///
    /// - Parameters:
    ///   - state: Used as the StateMachine's first State
    ///   - stateObject: This is the object that will handle user Input to determine its
    /// look and behavior based on its State
    init(with state: State, for stateObject: StateObject?) {
        _state = state
        _lastState = state
        self.firstState = state
        self.stateObject = stateObject
    }
    
    /// Processes the supplied Input to determine the next State to be in
    ///
    /// - Parameter input: A request from the user as to what behavior they want
    /// from the StateObject
    func handle(_ input: Input) {
        guard let stateObject = stateObject else { return }
        let newState = _state.handle(input, stateObject: stateObject)
        
        if let newState = newState {
            setLastState(_state)
            _state.exit(stateObject)
            _state = newState
            _state.enter(stateObject)
        }
        
        _state.render(stateObject)
    }
    
    /// Exits current State and re-enters the StateObject's initial State
    func toFirstState() {
        guard let stateObject = stateObject else { return }
        setLastState(_state)
        _state.exit(stateObject)
        _state = firstState
        _state.enter(stateObject)
        _state.render(stateObject)
    }
    
    /// Exits current State and re-enters the StateObject's previous one
    func toLastState() {
        guard let stateObject = stateObject else { return }
        _state.exit(stateObject)
        _state = _lastState
        _state.enter(stateObject)
        _state.render(stateObject)
    }
    
    /// Regardless of the current state, the StateMachine will enter the
    /// given state
    ///
    /// - Parameter newState: State to be used as the new current State
    func force(_ newState: State) {
        guard let stateObject = stateObject else { return }
        setLastState(_state)
        _state.exit(stateObject)
        _state = newState
        _state.enter(stateObject)
        _state.render(stateObject)
    }
    
    /// Sets a new StateObject for the StateMachine to use if it can
    /// and returns a Bool with its success or failure
    ///
    /// - Parameter stateObject: The object that will handle user Input to determine its
    /// look and behavior based on its State
    /// - Returns: Confirmation that the StateObject supplied was valid
    func newStateObject(_ stateObject: StateObject?) -> Bool {
        if let object = stateObject {
            self.stateObject = object
            return true
        } else {
            return false
        }
    }
    
    /// Sets a new StateObject for the StateMachine to use from a compliant ViewController
    /// if it can and returns a Bool with its success or failure
    ///
    /// - Parameter viewController: A UIViewController that will be converted to a StateObject
    /// which handles user Input to determine its look and behavior based on its State
    /// - Returns: Confirmation that the UIViewController converted successfully to a StateObject
    func newStateObject(viewController: UIViewController) -> Bool {
        if let object = viewController as? StateObject {
            self.stateObject = object
            return true
        } else {
            return false
        }
    }
    
    /// Sets the lastState property to a supplied State, ensuring that it is not
    /// the same State as the state property
    ///
    /// - Parameter state: The State which is to be set
    private func setLastState(_ state: State) {
        if !_lastState.equals(state) {
            _lastState = state
        }
    }
}
