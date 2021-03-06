import RxSwift
import RxCocoa

protocol ITemplate__Repository {
}

protocol ITemplate__Navigator {
    // When need navigate to other screen and dont care the next step
}

protocol ITemplate__LocalNavigator {
    // Sometime need push/present simple popup, viewcontroller to get input/select/...
    // and pop/dimiss right away. Dispite call viewcontroller to do this.
    // May create this instance so viewmodel can call directly
}

class Template__ViewModel: ViewModelType {
    // MARK: - Properties
    let repository: ITemplate__Repository
    let navigator: ITemplate__Navigator
    let localNavigator: ITemplate__LocalNavigator?
    
    private let disposeBag = DisposeBag()

    // MARK: - LifeCycle
    init(repository: ITemplate__Repository, navigator: ITemplate__Navigator, localNavigator: ITemplate__LocalNavigator? = nil) {
        self.repository = repository
        self.navigator = navigator
        self.localNavigator = localNavigator
    }

    // MARK: - Public
    func transform(input: Input) -> Output {

        return Output()
    }
}

extension Template__ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
    }
}
