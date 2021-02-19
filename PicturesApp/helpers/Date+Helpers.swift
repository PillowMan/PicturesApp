//
//  String+Helpers.swift
//  PicturesApp
//
//  Created by Дмитрий Григорьев on 18.02.2021.
//

import Foundation

extension Date {
    func toString() -> String? {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formater.timeZone = .current
        formater.locale = .current
        return formater.string(from: self)
    }
}
