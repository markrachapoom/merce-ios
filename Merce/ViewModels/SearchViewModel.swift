//
//  SearchViewModel.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/15.
//

import Foundation


class SearchViewModel: ObservableObject {
    
    @Published var searchResults: [MerceUser] = []
    
    func fetchSearch(from searchText: String) -> Void {
        
        let allFetchedResults = MerceUser.allEntrepreneurs
        
        guard !searchText.isEmpty else {
            searchResults = allFetchedResults
            return
        }
        
        let filteredResults = allFetchedResults.filter { user in
            
            let isUsernameFound: Bool = user.username?.trimAndLowercase().contains(searchText.trimAndLowercase()) ?? false
            let isGivenNameFound: Bool = user.name?.trimAndLowercase().contains(searchText.trimAndLowercase()) ?? false
            return isUsernameFound || isGivenNameFound
        }
        
        self.searchResults = filteredResults
    }
    
}
