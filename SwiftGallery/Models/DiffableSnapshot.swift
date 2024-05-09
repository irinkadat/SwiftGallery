//
//  DiffableSnapshot.swift
//  SwiftGallery
//
//  Created by Irinka Datoshvili on 09.05.24.
//

import Foundation

struct DiffableSnapshot<SectionIdentifier: Hashable, ItemIdentifier: Hashable> {
    struct Section {
        let identifier: SectionIdentifier
        var items: [ItemIdentifier]
    }
    
    var sections: [Section]
    
    init() {
        sections = []
    }
    
    mutating func appendSection(_ section: Section) {
        sections.append(section)
    }
    
    mutating func appendItems(_ items: [ItemIdentifier], toSectionWithIdentifier identifier: SectionIdentifier) {
        guard let index = sections.firstIndex(where: { $0.identifier == identifier }) else {
            return
        }
        sections[index].items.append(contentsOf: items)
    }
}
