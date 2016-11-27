import UIKit
import Firebase
import FirebaseDatabase

class OrderIsPrepare : UITableViewController {
    
    
   
   
    @IBOutlet var PrepareTable: UITableView!

    
    var CartRes = [Res_Info]()
    var CartMeal = [MealModel]()
    var GuestToOrder = [OrderGuestModel]()
    var MealToOrder = [MealModel]()
    var Guest_Count : String?
    var ResUID : String?
    var GuestCount : String?

    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
  CatchResUID()
        self.CartRes.removeAll()
        self.CartMeal.removeAll()
        self.PrepareTable.reloadData()
     
  
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getvalueToDictionary(){
        let Guest_Uid = FIRAuth.auth()?.currentUser?.uid
        print(ResUID)
        
        FIRDatabase.database().reference().child("UserStore").child(ResUID!).observeEventType(.Value, withBlock: {(snapshot) in
            print (snapshot)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let Cart_Res = Res_Info()
                Cart_Res.setValuesForKeysWithDictionary(dictionary)
                print(Cart_Res)
                self.CartRes.append(Cart_Res)
                print(Cart_Res.StoreID)
                print(Cart_Res.StoreLoc)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }})
        FIRDatabase.database().reference().child("UserStore").child(ResUID!).child("StoreOrder").child(Guest_Uid!).child("OrderMeal").observeEventType(.ChildAdded, withBlock: {(snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let Cart_Meal = MealModel()
                Cart_Meal.setValuesForKeysWithDictionary(dictionary)
                self.CartMeal.append(Cart_Meal)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }})
        FIRDatabase.database().reference().child("UserStore").child(ResUID!).child("StoreOrder").child(Guest_Uid!).child("OrderGuest").observeEventType(.Value, withBlock: {(snapshot) in
            print(snapshot.value)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let GuestCount = OrderGuestModel()
                GuestCount.setValuesForKeysWithDictionary(dictionary)
                self.Guest_Count = GuestCount.GuestCount
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }})

    }
    func removeCart(){
        let Guest_Uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("UserGuest").child(Guest_Uid!).child("GuestCart").removeValue()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (CartMeal.count)
        return CartMeal.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
        if indexPath.row == 0 {
            let Cart_Res = CartRes[indexPath.row]
            print(CartRes)
            self.tableView.rowHeight = 381
            let cell = PrepareTable.dequeueReusableCellWithIdentifier("ResOrder" , forIndexPath:  indexPath) as! PrepareResCell
            let  Cart_Meal = CartMeal[indexPath.row]
            cell.ResNameInOrder.text = Cart_Res.StoreID
            cell.ResLocInOrder.text = Cart_Res.StoreLoc
//            cell.ResTel.text = Cart_Res.Res_Tel
            cell.GuestCountInOrder.text = Guest_Count
            cell.MealNameInOrder.text = Cart_Meal.MealID
            cell.MealCountInOrder.text = Cart_Meal.MealCount
            cell.MealPriceInOrder.text = Cart_Meal.MealPrice
            cell.StorePic.sd_setImageWithURL(NSURL(string: Cart_Res.StorePic!))
            cell.MealPic.sd_setImageWithURL(NSURL(string: Cart_Meal.MealPic!))
                
            
            return cell
        }else{
            self.tableView.rowHeight = 95
            let cell = PrepareTable.dequeueReusableCellWithIdentifier("MealOrder", forIndexPath:  indexPath) as! PrepareMealCell
            let  Cart_Meal = CartMeal[indexPath.row]
            cell.MealNameInOrder.text = Cart_Meal.MealID
            cell.MealCountInOrder.text = Cart_Meal.MealCount
            cell.MealPriceOrder.text = Cart_Meal.MealPrice
            cell.MealPic.sd_setImageWithURL(NSURL(string: Cart_Meal.MealPic!))
            return cell
        }
    }
        func CatchResUID(){
        let UserUID = FIRAuth.auth()?.currentUser?.uid
        
FIRDatabase.database().reference().child("UserGuest").child(UserUID!).child("GuestCart").child("CartStore").observeEventType(.Value, withBlock: {(snapshot) in
    print (snapshot.value)
            if let dicrionary = snapshot.value as? [String:AnyObject]{
            
                let GetUid = CartResInfo()
                GetUid.setValuesForKeysWithDictionary(dicrionary)
                self.ResUID = GetUid.OrderUIDForStore
                print(self.ResUID)
                self.getvalueToDictionary()
    }
    
        })
        
    }
}