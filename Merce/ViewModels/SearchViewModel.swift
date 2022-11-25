//
//  SearchViewModel.swift
//  Merce
//
//  Created by Mark Rachapoom on 2022/11/15.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class SearchViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var searchResults: [MerceUser] = []
    @Published var allArtists: [MerceUser] = []
    
    func fetchSearch(from searchText: String) -> Void {
        
        let formattedSearchText = searchText.lowercased().trimmingCharacters(in: .whitespaces)
        
        db.collection("users").whereField("keywordsForLookup", arrayContains: formattedSearchText).getDocuments { snapshot, error in
            guard error == nil else { return }
            guard let documents = snapshot?.documents else { return }
            self.searchResults = documents.compactMap({ queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: MerceUser.self)
            })
        }
    }
    
    func fetchAllArtists() -> Void {
        db.collection("users").whereField("type", isEqualTo: "artist").getDocuments { snapshot, error in
            guard error == nil else { return }
            guard let documents = snapshot?.documents else { return }
            let fetchedAllArtists = documents.compactMap({ queryDocSnapshot in
                let fetchedArtist = try? queryDocSnapshot.data(as: MerceUser.self)
                return fetchedArtist
            })
            self.allArtists = fetchedAllArtists
            self.searchResults = fetchedAllArtists
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


extension String {
    /// Mark -> [m, ma, mar, mark]
    func generateStringSequence() -> [String] {
        guard self.count > 0 else { return [] }
        var sequences: [String] = []
        for i in 1...self.count {
            sequences.append(String(self.prefix(i)).lowercased())
        }
        return sequences
    }
    
    func generateWordsSplitBySpace() -> [String] {
        guard self.count > 0 else { return [] }
        var sequences: [String] = []
        
        // ["Mark", "Rachapoom"]
        self.split(separator: " ").forEach { word in
            sequences.append(String(word.lowercased()))
        }
        
        // markrachapoom: join the word
        let joinedArrayString = sequences.joined().lowercased()
        sequences.append(joinedArrayString)
        
        return sequences
    }
}
