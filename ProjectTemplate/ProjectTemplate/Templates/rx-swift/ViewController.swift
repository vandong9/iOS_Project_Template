//
//  ViewController.swift
//  ProjectTemplate
//
//  Created by dongha on 09/12/2020.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class Template__ViewController: BaseViewController {
    // MARK: Properties
    var viewModel: Template__ViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // MARK: - Private Functions
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let loadTrigger = PublishSubject<Void>()
                
        let input = Template__ViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input: input)
                
        loadTrigger.onNext(Void())

    }
}

