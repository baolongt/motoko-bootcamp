import Custom "custom";
import Animal "animal";
import List "mo:base/List";
actor {
    // Challenge 1
    public type Human = Custom.Human;
    public func fun(): async Human {
        let human : Human = {
            name: "Long";
            age: "21";
        };
        return human;
    };
    
    // Challenge 2
    public type Animal = Animal.Animal;
    var animal : Animal = {speice = "fox"; energy = 10}; 

    // Challenge 4
    public func create_animal_then_takes_a_break(speice: Text, energy : Nat): async Animal{
        let animal : Animal.Animal = {
            speice = speice;
            energy = energy;
        };
        return Animal.animal_sleep(animal);
    };

    // Challenge 5
    private type List<T> = List.List<T>;
    private var animal_arr : [Animal] = [{speice= ""; energy = 0}];
    private var animals: List<Animal> = List.fromArray<Animal>(animal_arr);

    // Challenge 6
    public func push_animal(a: Animal): async (){
        animal_list := List.push(a, animals);
    };

    public func get_animal(): async [Animal]{
        return List.toArray(animals);
    };

}