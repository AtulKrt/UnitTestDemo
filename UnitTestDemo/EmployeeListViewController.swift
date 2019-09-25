//
//  EmployeeListViewController.swift
//  UnitTestDemo
//
//  Created by Atul Kumar Tiwari-iOS on 12/08/19.
//  Copyright © 2019 Tokopedia. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

internal class EmployeeListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewmodel = EmployeeListViewModel(usecase: DefaultEmployeeUseCase())
    
    @IBOutlet private var segmentControl: UISegmentedControl!
    @IBOutlet private var employeeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
        bindViewModel()
    }
    
    private func initialSetUp() {

        employeeTableView.rx.setDelegate(self).disposed(by: disposeBag)
        employeeTableView.estimatedRowHeight = 160
        employeeTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindUI() {
        
    }
    
    private func bindViewModel() {
        
        
        let input = EmployeeListViewModel.Input(viewDidLoadTrigger: Observable.just(()),
                                                segmentTapped: segmentControl.rx.selectedSegmentIndex.asObservable())
        let output = viewmodel.transform(input: input)
        output.employeeList.asDriver(onErrorJustReturn: [])
            .drive(employeeTableView.rx.items(cellIdentifier: "EmployeeCell", cellType: EmployeeCell.self)) { index,model,cell   in
                cell.populate(with: model)
        }.disposed(by: disposeBag)
        
        output.error.asDriver(onErrorJustReturn: MyError())
            .drive(onNext: { (error) in
                print(error)
            }).disposed(by: disposeBag)
    }

}

extension EmployeeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let actiom  = UITableViewRowAction(style: .normal, title: "Save") { (action, indexPath) in
            print()
        }
        
        let delete  = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            print()
        }
        return [actiom, delete]
    }
    
}

struct MyError: Error {
    
}
