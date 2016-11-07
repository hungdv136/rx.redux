//
//  Reducer.swift
//  Redux
//
//  Created by Chu Cuoi on 10/5/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

public protocol AnyReducer {
    func _handleAction(state: StateType, action: Action) -> StateType
}

public protocol Reducer: AnyReducer {
    associatedtype State: StateType
    
    func handleAction(state: State, action: Action) -> State
}

public extension Reducer {
    public func _handleAction(state: StateType, action: Action) -> StateType {
        guard let typedState = state as? State else { return state }
        return handleAction(state: typedState, action: action)
    }
}

final public class CombinedReducer: AnyReducer {
    public init(reducers: AnyReducer...) {
        self.reducers = reducers
    }
    
    public func _handleAction(state: StateType, action: Action) -> StateType {
        return reducers.reduce(state) {
            $1._handleAction(state: $0, action: action)
        }
    }
    
    private let reducers: [AnyReducer]
}
