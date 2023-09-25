//
//  Error.swift
//  TechTask_BRH
//
//  Created by wiljan S on 9/25/23.
//


import Foundation

enum AppError: Error {
    case networkError(String)
    case dataValidation(String)
   
}
