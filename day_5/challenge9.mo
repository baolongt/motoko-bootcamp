import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Cycles "mo:base/ExperimentalCycles";
import Option "mo:base/Option";
import Iter "mo:base/Iter";
actor{
    stable var data_storage: [(Principal, Nat)] = [] ;
    // challenge 2
    var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    system func preupgrade() {
        data_storage := Iter.(favoriteNumber.entries());
    };

    system func postupgrade() {
        if(data_storage.size() > 0){
            favoriteNumber = HashMap.fromIter(data_storage.vals(), 1, Principal.equal, Principal.hash);
            data_storage := [];
        }
    };
  

  // challenge 3 + 4
  public shared({caller}) func add_favorite_number(n : Nat) : async Text{
    if(favoriteNumber.get(caller) == null){
      favoriteNumber.put(caller, n);
      return "You've successfully registered your number";
    }
    else return "You've already registered your number";
  };

  public shared({caller}) func show_favorite_number() : async ?Nat{
    return favoriteNumber.get(caller);
  };

  // challenge 5
  public shared({caller}) func update_favorite_number(n : Nat) : async (){
    var previous: ?Nat = favoriteNumber.replace(caller, n);
  };

  public shared({caller}) func delete_favorite_number() : async (){
    var previous: ?Nat = favoriteNumber.remove(caller);
  };
}