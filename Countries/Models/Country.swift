//
//  Country.swift
//  Countries
//
//  Copyright © 2017 Shariar Razm. All rights reserved.
//

import Foundation

struct Country: Decodable {
	let name: String
	let nativeName: String
	let capital: String
	let region: String
    let flag: String
    let latlng: [Double]
	let translations: Translation
    let languages: [Language]
}
