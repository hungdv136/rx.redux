//
//  Store.swift
//  Redux
//
//  Created by Chu Cuoi on 10/5/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol StoreType {
    associatedtype State: StateType
    
    var state: Driver<State> { get }
    func getState() -> State
    func dispatch(_ action: Action) -> Any
}


public class Store<T: StateType>: StoreType {
    public init(state: T, reducer: AnyReducer, middlewares: [Middleware] = []) {
        stateVar = Variable(state)
        self.reducer = reducer
        
        let dispatch: DispatchFunction = { [unowned self] in
            self.dispatch($0)
        }
        let getState: GetState = { [unowned self] in
            self.getState()
        }
        dispatchFunction = middlewares.reversed().reduce({ [unowned self] action in
            self.dispatchCore(action: action)
        }) { composed, middleware in
            return middleware.process(getState: getState, dispatch: dispatch)(composed)
        }
    }
    
    public func getState() -> T {
        return stateVar.value
    }
    
    @discardableResult
    public func dispatch(_ action: Action) -> Any {
        return dispatchFunction(action)
    }
    
    private func dispatchCore(action: Action) -> Any {
        guard !isDispatching else {
            fatalError("Redux:IllegalDispatchFromReducer - Reducers may not dispatch actions.")
        }
        
        isDispatching = true
        
        defer { isDispatching = false }
        
        stateVar.value = reducer._handleAction(state: stateVar.value, action: action) as! T
        
        return action
    }
    
    //MARK: Properties
    
    private let stateVar: Variable<T>
    
    public var state: Driver<T> {
        return stateVar.asDriver()
    }
    
    private let reducer: AnyReducer
    private var dispatchFunction: ((Action) -> Any)!
    private var isDispatching = false
}
