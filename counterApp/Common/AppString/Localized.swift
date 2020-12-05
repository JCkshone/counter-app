//
//  Localized.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import Foundation

extension String {
    
    public func localized(usingFile fileName: String) -> String {
        localized(usingFile: fileName, withComment: "")
    }

    public func localized(usingFile fileName: String, bundleLanguage: String? = nil, withComment comment: String) -> String {
        
        if let bundleLanguage = bundleLanguage,
            let path = Bundle.main.path(forResource: bundleLanguage, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            
            return NSLocalizedString(self, tableName: fileName, bundle: bundle, value: "", comment: comment)
            
        } else {
            return NSLocalizedString(self, tableName: fileName, bundle: Bundle.main, value: "", comment: comment)
        }
    }
}
