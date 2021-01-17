//
//  Repository.swift
//  ProjectTemplate
//
//  Created by dongha on 09/12/2020.
//

protocol ILocalService {
}

protocol IAPIRequester {
}



final class DefaultFavoritePersonRepository: IRepository {
    // MARK: - Properties
    
    private let apiReqester: IAPIRequester
    private let localService: ILocalService
    
    // MARK: - LifeCycle
    init(apiReqester: IAPIRequester, localService: ILocalService) {
        self.apiReqester = apiReqester
        self.localService = localService
    }

    // MARK: - Public

}
