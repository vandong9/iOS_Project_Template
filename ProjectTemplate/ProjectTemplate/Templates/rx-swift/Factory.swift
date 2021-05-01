import Foundation

class Template__SceneFactory {
    class func Template__Scene(navigator: ITemplate__Navigator) -> Template__ViewController {
        let vc = Template__ViewController()
        vc.viewModel = Template__ViewModel(repository: DefaultTemplate__Repository(), navigator: navigator)
        return vc
    }
    
    class func Template__Scene(navigator: ITemplate__Navigator, navigationController: BaseNavigationController) -> Template__ViewController {
        let vc = Template__ViewController()
        vc.viewModel = Template__ViewModel(repository: DefaultTemplate__Repository(), navigator: navigator, localNavigator: DefaultTemplate__LocalNavigator(navigationController: navigationController))
        return vc
    }
}
