//
//  Sequence.swift
//  Athlety
//
//  Created by Stefan Lipp on 23.01.26.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
