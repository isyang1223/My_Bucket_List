//
//  AddItemTableViewControllerDelegate.swift
//  My Bucket List
//
//  Created by Ian Yang on 3/18/18.
//  Copyright © 2018 Ian Yang. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by contoller: AddItemTableViewController)
    
}
