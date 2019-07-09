//
//  StateObject.swift
//  StateMachine
//
//  Created by Zachary Duncan on 7/9/19.
//  Copyright © 2019 Zachary Duncan. All rights reserved.
//

import Foundation

/// Applied to any object for which you need to control its various states.
/// Subclass to add custom properties and methods that you want the StateMachine
/// to be able to reference and/or manipulate.
///
/// If applying to a view Controller you could add references to various UI
/// elements whose usage you'd like to be limited per State.
@objc protocol StateObject {
    @objc var stateMachine: StateMachine! { get set }
    @objc func handle(_ input: Input)
}
