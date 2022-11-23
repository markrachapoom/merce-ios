//
//  SearchViewModel.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/15.
//

import Foundation
import FirebaseFirestore


class SearchViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var searchResults: [MerceUser] = []
    
    func fetchSearch(from searchText: String) -> Void {
        db.collection("users").whereField("keywordsForLookup", arrayContains: searchText).getDocuments { snapshot, error in
            guard error == nil else { return }
            guard let documents = snapshot?.documents else { return }
            self.searchResults = documents.compactMap({ queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: MerceUser.self)
            })
        }
    }
    
    
    func fetchLocalSearch(from searchText: String) -> Void {
        
        let allFetchedResults = MerceUser.allEntrepreneurs
        
        guard !searchText.isEmpty else {
            searchResults = allFetchedResults
            return
        }
        
        let filteredResults = allFetchedResults.filter { user in
            
            let isUsernameFound: Bool = user.username?.trimAndLowercase().contains(searchText.trimAndLowercase()) ?? false
            let isGivenNameFound: Bool = user.givenName?.trimAndLowercase().contains(searchText.trimAndLowercase()) ?? false
            return isUsernameFound || isGivenNameFound
        }
        
        self.searchResults = filteredResults
    }
    
}
