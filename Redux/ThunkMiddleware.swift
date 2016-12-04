//
//  ThunkMiddleware.swift
//  Redux
//
//  Created by Chu Cuoi on 10/5/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

public typealias AsyncActionCreator = (GetState, DispatchFunction) -> Any
public typealias ActionCreator = (GetState, DispatchFunction) -> Void

public struct AsyncActionWrapper: Action {
    public let action: AsyncActionCreator
}

public struct ActionWrapper: Action {
    public let action: ActionCreator
}

public extension StoreType {
    
    @discardableResult
    public func dispatch(_ action: @escaping AsyncActionCreator) -> Any {
        return dispatch(AsyncActionWrapper(action: action))
    }
    
    public func dispatch(_ action: @escaping ActionCreator) {
        _ = dispatch(ActionWrapper(action: action))
    }
}

public struct ThunkMiddleware: Middleware {
    public func process(getState: @escaping GetState, dispatch: @escaping DispatchFunction) -> (@escaping DispatchFunction) -> DispatchFunction {
        return { next in
            return { action in
                if let actionWrapper = action as? AsyncActionWrapper {
                    return actionWrapper.action(getState, dispatch)
                }
                else if let actionWrapper = action as? ActionWrapper {
                    return actionWrapper.action(getState, dispatch)
                }
                return next(action)
            }
        }
    }
}
