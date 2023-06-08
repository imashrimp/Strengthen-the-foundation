//
//  ActorListViewModel.swift
//  movieApp
//
//  Created by 권현석 on 2023/06/08.
//

import Foundation

class ActorListViewModel {
    
    var filteredActorList: [PeopleList] = []
    var searchKeyword: String = ""
    let actorListAPINetworking = APINetworking()
    
    func actorAPICall(completion: @escaping () -> Void) {
        actorListAPINetworking.callActorListAPI(keyword: searchKeyword) { actors in
            self.filteredActorList = actors.peopleListResult.peopleList
            completion()
        }
    }
}
