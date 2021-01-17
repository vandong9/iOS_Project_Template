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

class RandomPersonViewController: BaseViewController {
    // MARK: Properties
    
    var viewModel: ViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadTrigger = PublishSubject<Void>()
                
        let input = ViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input: input)
                
        loadTrigger.onNext(Void())
        
    }
}

