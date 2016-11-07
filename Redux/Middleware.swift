//
//  Middleware.swift
//  Redux
//
//  Created by Chu Cuoi on 10/5/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

public typealias DispatchFunction = (Action) -> Any
public typealias GetState = () -> StateType?

public protocol Middleware {
    func process(dispatch: @escaping DispatchFunction, getState: @escaping GetState) -> (@escaping DispatchFunction) -> DispatchFunction
}
