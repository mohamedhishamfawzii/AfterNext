
import Foundation
class Arena {
    var name : String
    var location: String
    var rating : Int
    var price: String
    var hours : [Bool]
    var number : String
    init(name:String,location:String,price:String,number:String) {
        self.hours = [Bool](repeatElement(false,count: 8))
        self.name = name
        self.location = location
        self.price = price
        self.rating = 0
        self.number = number
    }
}
