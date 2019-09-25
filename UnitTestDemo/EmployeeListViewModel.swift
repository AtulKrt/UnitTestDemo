//
//  EmployeeListViewModel.swift
//  UnitTestDemo
//
//  Created by Atul Kumar Tiwari-MBP on 25/09/19.
//  Copyright © 2019 Atul Kumar Tiwari-MBP. All rights reserved.
//

import Foundation
import RxSwift

internal class EmployeeListViewModel {
    internal struct Input {
        internal let viewDidLoadTrigger: Observable<Void>
        internal let segmentTapped: Observable<Int>
    }
    
    internal struct Output {
        internal let employeeList: Observable<[Employee]>
        internal let error: Observable<Error>
    }
    
    private let usecase: EmployeeUseCase
    
    internal init(usecase: EmployeeUseCase) {
        self.usecase = usecase
    }
    
    internal func transform(input: Input) -> Output {
        
        let error = NSError(domain: "com.demoapp", code: 999, userInfo: [NSLocalizedDescriptionKey: "Something wrong happened"])
        let employeeList = input.viewDidLoadTrigger.flatMapLatest { [usecase] (_) -> Observable<[Employee]> in
            usecase.getEmployeeData()
        }
        return Output(employeeList: employeeList,
                      error: Observable.just(error))
    }
}
