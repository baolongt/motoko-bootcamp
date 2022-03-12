import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Cycles "mo:base/ExperimentalCycles";
import Option "mo:base/Option";
actor {
  // challenge 1 
  public shared({caller}) func is_anonymous() : async Bool{
    return Principal.isAnonymous(caller);
  };

  // challenge 2
  let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

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
  
  ///////////////////////////////

  let var ledger = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

  public func balance() : async Nat {
        return(Cycles.balance())
  };
  public func message_available() : async Nat {
        return(Cycles.available())
  };
  // challenge 6 this will deposit 100_000 cycle every call
  public shared({caller}) func deposit_cycles() : async Nat{
      var dep_amount:?Nat = ledger.get(caller);
      var dep_num:Nat = 0;
      if(dep_amount == null){
        ledger.put(caller, 100_000);
      }
      else {
        dep_num := Cycles.accept(100_000);
        var temp: Nat = Option.unwrap(dep_amount) + 100_000;
        var dep: ?Nat = ledger.replace(caller, temp);
      };
      return dep_num;
  };

  // challenge 7
  // public shared({caller}) func withdraw_cycles() : async (){
  //     if(ledger.get(caller) != null){
  //         Cycle.accept(100_000);
  //     };
  // };

  // challenge 8
    stable var counter_num:Int=0;
    stable var versionNumber:Nat=0;
    public func increment_counter(num : Int) : async Int{
        counter_num += num;
        return counter_num;
    };

    public func clear_counter() : async (){
        counter_num := 0;
    };

    system func preupgrade() {
      
    };

    system func postupgrade() {
      versionNumber := versionNumber + 1;
    };
};
