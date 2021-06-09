//
//  ListPresenter.swift
//  SyncracyTest
//
//  Created by Anil on 02/04/21.
//

import Foundation

protocol ListPresentationLogic {
    func presentList(response: ListModel.Process.Response)
}

class ListPresenter: ListPresentationLogic{
    
    weak var viewController : ListVCLogic?
    func presentList(response:ListModel.Process.Response) {
        let viewModel = ListModel.Process.ViewModel(success: response.success, msg: response.msg, list: response.list)
        viewController?.displayLogic(viewModel: viewModel)
    }
}
