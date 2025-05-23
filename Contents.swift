import Foundation
// to run the file from command line/terminal paste and run : "swift ~/Desktop/Assignment_1_IOS.playground/Contents.swift"

// Enum representing possible types of Item Type
enum ItemType
{
    case raw , manufactured , imported
}

// Enum representing possible error types to handle error effectively
enum InputError : Error{
    case InvalidName
    case InvalidPrice
    case InvalidQuanity
}

// Struct Item representing the attributes of an Item
struct Item
{
    var itemName : String
    var itemPrice : Double
    var itemQuantity : Int
    var itemType : ItemType
    var salesTax : Double
    var finalPrice : Double
}

// Class ItemPrice representing logic for calculating item price
class ItemPrice {
    
    func itemPrice(type : ItemType , cost : Double)->(Double, Double) {
        var tax : Double
        var totalPrice : Double
        switch type
        {
        case .raw :
            tax = 0.125 * cost
            totalPrice = 1.125 * cost
        case .manufactured :
            tax = 0.1475 * cost
            totalPrice = cost * 1.1475
        case .imported :
             var subtotal = cost * 1.10
            var surcharge : Double
            var importDuty = 0.10 * cost
    
            if subtotal <= 100 { surcharge = 5}

            else if  subtotal > 100 && subtotal <= 200 { surcharge = 10}

            else {surcharge = 0.05 * subtotal}
            tax = importDuty + surcharge
            totalPrice = cost + tax
        }
        return (tax , totalPrice)
    }
}

// Array of struct item to store each item
class Main{
    
    // Method to validated name input
    func getValidatedName(_ input : String? ) throws ->String
    {
        guard let name = input else {
            throw InputError.InvalidName
        }
        return name
    }
    
    // Method to validate Price input
    func getValidatedPrice(_ input : String) throws->Double
    {
        guard let price = Double(input) , price > 0 else{
            throw InputError.InvalidPrice
        }
        return price
    }
    
    // Method to validate Quantity input
    func getValidatedQuantity(_ input: String) throws ->Int
    {
        guard let quantity = Int(input) , quantity > 0 else {
            throw InputError.InvalidQuanity
        }
        return quantity
    }
    
    // Method to start execution of the program
    func start (){
        var items: [Item] = []
        
        // While loop that continues until the user is adding new items to the array
        while true {
            // Prompt for item details
            var name = ""
            print("Enter item name:")
            while true{
                let input = readLine() ?? ""
                do {
                    name = try getValidatedName(input)
                    break
                }
                catch
                {
                    print("Invalid name , please enter a valid name")
                }
            }
            
            var price = 0.0
            print("Enter price:")
            while true {
                let input = readLine() ?? ""
                do {
                    price = try getValidatedPrice(input)
                    break
                }
                catch
                {
                    print("Invalid price , please enter valid price")
                }
            }
           
            var quantity = 1
            print("Enter quantity:")
            while true {
                let input = readLine() ?? ""
                do {
                    quantity = try getValidatedQuantity(input)
                    break
                }
                catch
                {
                    print("Invalid quantity , please enter valid qunatity")
                }
            }
            
            // Prompt for item type and handle enum conversion
            
            var type: ItemType?
            while type == nil {
                print("Enter item type (raw, manufactured, imported):")
                let typeString = readLine()?.lowercased() ?? ""
                switch typeString {
                case "raw":
                    type = .raw
                case "manufactured":
                    type = .manufactured
                case "imported":
                    type = .imported
                default:
                    print("Invalid item type. Please enter 'raw', 'manufactured', or 'imported'.")
                }
            }
            
            
            // Create item and add to array
            if let itemType = type {
                var obj = ItemPrice()
                var (x,y) = obj.itemPrice(type : itemType, cost: price)
                let item = Item(itemName: name, itemPrice: price, itemQuantity: quantity, itemType: itemType , salesTax: x , finalPrice : y)
                items.append(item)
            }
            
            // Ask user if they want to add another
            print("Do you want to add another item? (yes/no)")
            let response = readLine()?.lowercased() ?? "no"
            if response != "yes" && response != "y" && response != "Yes" && response != "YES" {
                break
            }
        }
        
        // Output the items with their details
        for item in items {
            print("Item: \(item.itemName), Price: \(item.itemPrice), Quantity: \(item.itemQuantity), Type: \(item.itemType) , Sales Tax : \(item.salesTax), final prize : \(item.finalPrice)")
        }
        
    }
}

// Program Entry point
var obj = Main()
obj.start()

