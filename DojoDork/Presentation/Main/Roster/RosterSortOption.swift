//
// Created by Eric Ziegler on 4/26/25
//  

import Foundation

enum RosterSortOption: String, CaseIterable, Identifiable {
    case nameAscending = "Name (A-Z)"
    case nameDescending = "Name (Z-A)"
    case classCountDescending = "Most Classes"
    case classCountAscending = "Fewest Classes"
    
    var id: String { rawValue }
}
