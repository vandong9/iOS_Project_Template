//
//  ViewModel.swift
//  ProjectTemplate
//
//  Created by dongha on 09/12/2020.
//

import RxSwift
import RxCocoa

protocol IRepository {
}

protocol INavigator {
}

class ViewModel: ViewModelType {
    // MARK: - Properties
    let repository: IRepository
    let navigator: INavigator
    
    private let disposeBag = DisposeBag()

    // MARK: - LifeCycle
    init(repository: IRepository, navigator: INavigator) {
        self.repository = repository
        self.navigator = navigator
    }

    // MARK: - Public
    func transform(input: Input) -> Output {

        
        return Output()
    }
}

extension ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
    }
}
