//
//  Protocols.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/8/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

public protocol Hideable: class { }

public extension Hideable where Self: UIView {
  
  func hide() {
    self.alpha = 0
    self.isHidden = true
  }
  
  func unHide() {
    self.isHidden = false
    self.alpha = 1.0
  }

}
