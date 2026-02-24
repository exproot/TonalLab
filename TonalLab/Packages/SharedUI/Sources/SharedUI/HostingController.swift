//
//  HostingController.swift
//  SharedUI
//
//  Created by Ertan Yağmur on 21.02.2026.
//

import SwiftUI

open class HostingController<Content>: UIHostingController<Content> where Content: View {
  
  public override init(rootView: Content) {
    super.init(rootView: rootView)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    preconditionFailure("init(coder:) not implemented")
  }
  
}
