//
//  NetworkProvider.swift
//  UnitTestDemo
//
//  Created by Atul Kumar Tiwari-MBP on 25/09/19.
//  Copyright © 2019 Atul Kumar Tiwari-MBP. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import RxSwift

public enum EmployeeTarget {
    case getData
}

extension EmployeeTarget: TargetType {
    public var baseURL: URL {
        return URL(string: "http://dummy.restapiexample.com/api/v1")!
    }
    
    public var path: String {
        return "/employees"
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}

internal protocol EmployeeUseCase{
     func getEmployeeData() -> Observable<[Employee]>
}

internal class DefaultEmployeeUseCase: EmployeeUseCase {
    
    private let provider = MoyaProvider<EmployeeTarget>()
    
    internal func getEmployeeData() -> Observable<[Employee]> {
        return provider.rx.request(.getData)
        .asObservable()
        .map([Employee].self)
    }
}
