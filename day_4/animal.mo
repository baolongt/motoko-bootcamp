import Text "mo:base/Text";
import Nat "mo:base/Nat";

module {
    public type Animal = {
        speice : Text;
        energy : Nat;
    };

    // Challenge 3
    public func animal_sleep(a: Animal) : Animal{
        let update_animal : Animal = {
            speice = a.speice;
            energy = a.energy+10;
        };
        return update_animal; 
    };
    
}