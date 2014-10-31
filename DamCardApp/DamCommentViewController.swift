//
//  DamCommentViewController.swift
//  DamCardApp
//
//  Created by Fumitoshi Ogata on 2014/10/30.
//  Copyright (c) 2014年 Fumitoshi Ogata. All rights reserved.
//
import UIKit

class DamCommentViewController: UIViewController,DamCommentViewControllerDelegate,UIViewControllerTransitioningDelegate {

    var damId:Int? = 0
    var commentData:NSArray = NSArray()

    @IBOutlet var commentList: UITableView!
    @IBOutlet var writeButton: UIButton!
    @IBAction func writeButtonDidTouch(sender: AnyObject) {
        //モーダルを表示する        
        let controller: UINavigationController! = self.storyboard?.instantiateViewControllerWithIdentifier("NavigationController") as? UINavigationController
        controller.modalPresentationStyle = .Custom
        controller.transitioningDelegate = self
        
        //ViewControllerにパラメータをsetする
        var writeCommentViewController = controller.viewControllers![0] as WriteCommentViewController
        writeCommentViewController.delegate = self
        writeCommentViewController.damId = self.damId

        self.presentViewController(controller, animated: true, completion: {
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Parseからデータの取得
    func loadData(){
        Parse.setApplicationId("dBzkl9gkGPsQoyRHq5WOv9wzbUmK9QEhJXBpO6mf",clientKey: "HtkhZciPZ3p5M8elvwJBrI1ORvhBgU95bOSjCRJ2")

        var query:PFQuery = PFQuery(className: "DamComments")
        query.whereKey("DamId",equalTo:self.damId)
        query.limit = 999
        //query.orderByAscending("createdAt")
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            if error != nil{
                print(error)
            }else{
                self.commentData = objects
                self.commentList.reloadData()
            }
        }
    }
    
    func reloadCommentListTable(writeCommentViewController:WriteCommentViewController){
        loadData()
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        return self.commentData.count as Int
    }
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = self.commentData[indexPath.row]["Comment"] as String?
        return cell
    }
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    }
    
}


class CustomPresentationController: UIPresentationController {
    
    // 呼び出し元の View Controller の上に重ねるオーバーレイ View
    var overlay: UIView!
    
    // 表示トランジション開始前に呼ばれる
    override func presentationTransitionWillBegin() {
        let containerView = self.containerView
        let presented = self.presentedViewController
        
        self.overlay = UIView(frame: containerView.bounds)
        self.overlay.gestureRecognizers = [UITapGestureRecognizer(target: self, action: "overlayDidTouch:")]
        self.overlay.backgroundColor = UIColor.blackColor()
        self.overlay.alpha = 0.0
        containerView.insertSubview(self.overlay, atIndex: 0)
        
        // トランジションを実行
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({
            [unowned self] context in
            self.overlay.alpha = 0.5
            }, completion: nil)
    }
    
    // 非表示トランジション開始前に呼ばれる
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator()?.animateAlongsideTransition({
            [unowned self] context in
            self.overlay.alpha = 0.0
            }, completion: nil)
    }
    
    // 非表示トランジション開始後に呼ばれる
    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            self.overlay.removeFromSuperview()
        }
    }
    
    // 子のコンテナのサイズを返す
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width * 4/5, height: parentSize.height)
    }
    
    // 呼び出し先の View Controller の Frame を返す
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var presentedViewFrame = CGRectZero
        let containerBounds = self.containerView.bounds
        presentedViewFrame.size = self.sizeForChildContentContainer(self.presentedViewController, withParentContainerSize: containerBounds.size)
        //presentedViewFrame.origin.x = containerBounds.size.width - presentedViewFrame.size.width
        presentedViewFrame.origin.x = 30
        //presentedViewFrame.origin.y = containerBounds.size.height - presentedViewFrame.size.height
        presentedViewFrame.origin.y = 200
        return presentedViewFrame
    }
    
    // レイアウト開始前に呼ばれる
    override func containerViewWillLayoutSubviews() {
        overlay.frame = self.containerView.bounds
        self.presentedView().frame = self.frameOfPresentedViewInContainerView()
    }
    
    // レイアウト開始後に呼ばれる
    override func containerViewDidLayoutSubviews() {
    }
    
    // オーバーレイの View をタッチしたときに呼ばれる
    func overlayDidTouch(sender: AnyObject) {
        self.presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
}


