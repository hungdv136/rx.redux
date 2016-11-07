//
//  ThunkMiddleware.swift
//  Redux
//
//  Created by Chu Cuoi on 10/5/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

public typealias AsyncAction = (DispatchFunction, GetState) -> Any

public struct AsyncActionWrapper: Action {
    public let action: AsyncAction
}

public extension StoreType {
    public func dispatch(action: @escaping AsyncAction) -> Any {
        return dispatch(action: AsyncActionWrapper(action: action))
    }
}

public struct ThunkMiddleware: Middleware {
    public func process(dispatch: @escaping DispatchFunction, getState: @escaping GetState) -> (@escaping DispatchFunction) -> DispatchFunction {
        return { next in
            return { action in
                if let actionWrapper = action as? AsyncActionWrapper {
                    return actionWrapper.action(dispatch, getState)
                }
                return next(action)
            }
        }
    }
}
