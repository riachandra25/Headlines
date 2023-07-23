//
//  Date+Extension.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation
extension Date {
    
  // convert date to formatted string
  func convertDateToString() -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd/MM/yyyy"
      return dateFormatter.string(from: self)
  }
}
