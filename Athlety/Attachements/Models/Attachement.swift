//
//  Attachement.swift
//  Athlety
//
//  Created by Stefan Cimander on 09.06.23.
//

import Foundation

struct Attachement {
    let name: String
    let url: URL
    let type: AttachementType
}

enum AttachementType {
    case pdf
    case unknown(extension: String)
}
