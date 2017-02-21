//
//  TextVC.swift
//  TextView
//
//  Created by 唐小虎 on 17/2/21.
//  Copyright © 2017年 demaxiyaH. All rights reserved.
//

import UIKit

class TextVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

	private var saveTF: UITextField!
	private var saveDistance: CGFloat!

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupNoti()
//		changeVCFrame()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	private func setupUI() {
		automaticallyAdjustsScrollViewInsets = true
		view.backgroundColor = UIColor.whiteColor()
		tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height)
		view.addSubview(tableView)

		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "test", style: .Done, target: self, action: #selector(TextVC.click))

	}

	private func setupNoti() {
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextVC.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextVC.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextVC.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextVC.keyboardDidHide(_:)), name: UIKeyboardDidHideNotification, object: nil)
	}

	@objc private func click() {

	}

	@objc private func keyboardWillShow(noti: NSNotification) {

		guard let keyFrame = noti.userInfo!["UIKeyboardFrameEndUserInfoKey"] else {
			return
		}
//        // 获取键盘的高度
		print(keyFrame.CGRectValue())

		print(saveTF.frame)
		if saveTF.frame.origin.y == 0.0 { // 获取父控件的frame
			if let superCell = saveTF.superview { // containView
				print(superCell.frame)
				if superCell.frame.origin.y == 0.0 {
					if let superSuperCell = superCell.superview {
						print(superSuperCell.frame)

						if superSuperCell.frame.origin.y > keyFrame.CGRectValue().origin.y { // 说明会被键盘挡住,让当前控制器滚动一定的距离

							let needScrollDistance: CGFloat = superSuperCell.frame.origin.y - keyFrame.CGRectValue().origin.y + saveTF.frame.height
							saveDistance = needScrollDistance
							changeVCFrame(needScrollDistance)
//                            tableView.scro

						}
					}
				}
			}
		}
	}

	@objc private func keyboardDidShow(noti: NSNotification) {

	}

	@objc private func keyboardWillHide(noti: NSNotification) {

		changeVCFrame(automaticallyAdjustsScrollViewInsets == true ? -64 : 0)

	}

	@objc private func keyboardDidHide(noti: NSNotification) {

	}

	private func changeVCFrame(changeY: CGFloat) {
		// 获取当前导航控制器的展示的控制器
		if let vc = navigationController?.childViewControllers.first as? TextVC {
			vc.tableView.setContentOffset(CGPoint(x: 0, y: changeY), animated: true)
		}
	}

	private func setupKeyBoard(noti: NSNotification, changeY: CGFloat) {

	}

	// MARK: -----tableViewDelegate

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return 11
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		var cell = tableView.dequeueReusableCellWithIdentifier(identifyStr)
		if cell == nil {
			cell = UITableViewCell(style: .Default, reuseIdentifier: identifyStr)
		}
		if indexPath.row != 10 {
			cell?.textLabel?.text = "我是文字\(indexPath.row)"
		} else {
			testTF.frame = CGRect(x: 50, y: 0, width: 200, height: 44)
			cell?.contentView.addSubview(testTF)
			saveTF = testTF

		}
		return cell!

	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 44
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		testTF.resignFirstResponder()
	}

	private lazy var identifyStr: String = "cell"

	private lazy var testTF: UITextField = {
		let result = UITextField()
//		result.delegate = self
		result.borderStyle = .RoundedRect
		return result
	}()

	private lazy var tableView: UITableView = {
		let result = UITableView()
		result.delegate = self
		result.dataSource = self
		result.backgroundColor = UIColor.whiteColor()
		return result
	}()

}
