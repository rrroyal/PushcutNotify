//
//  String+.swift
//  notify
//
//  Created by royal on 02/08/2020.
//

import Foundation

extension String {
	func colorize(effect: Int = 0, color: Int) -> String {
		return "\u{001B}[\(effect);\(color)m\(self)"
	}
}
