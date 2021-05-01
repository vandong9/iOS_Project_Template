import RxSwift
import RxCocoa

protocol IIntroRepository {
}

protocol IIntroNavigator {
    // When need navigate to other screen and dont care the next step
}

protocol IIntroLocalNavigator {
    // Sometime need push/present simple popup, viewcontroller to get input/select/...
    // and pop/dimiss right away. Dispite call viewcontroller to do this.
    // May create this instance so viewmodel can call directly
}

class IntroViewModel: ViewModelType {
    // MARK: - Properties
    let repository: IIntroRepository
    let navigator: IIntroNavigator
    let localNavigator: IIntroLocalNavigator?
    
    private let disposeBag = DisposeBag()

    // MARK: - LifeCycle
    init(repository: IIntroRepository, navigator: IIntroNavigator, localNavigator: IIntroLocalNavigator? = nil) {
        self.repository = repository
        self.navigator = navigator
        self.localNavigator = localNavigator
    }

    // MARK: - Public
    func transform(input: Input) -> Output {

        return Output()
    }
}

extension IntroViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
    }
}
