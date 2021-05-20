//
//  Utils.swift
//  Learn-to-py
//
//  Created by Pato on 04/05/21.
//
import Foundation

extension Sequence where Iterator.Element == NSAttributedString {
    func joined(with separator: NSAttributedString) -> NSAttributedString {
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if r.length > 0 {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }

    func joined(with separator: String = "") -> NSAttributedString {
        return self.joined(with: NSAttributedString(string: separator))
    }
}

func pathURL(name: String, format: String) -> URL {
    let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let path = dir.appendingPathComponent(name).appendingPathExtension(format)
    
    return path
}
