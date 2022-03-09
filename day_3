import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Char "mo:base/Char";
import Iter  "mo:base/Iter";
import Array  "mo:base/Array";
import Debug  "mo:base/Debug";
import Int "mo:base/Int";
import Option "mo:base/Option";
actor {
    ////////////
    private func swap (arr : [Nat], i : Nat, j : Nat) : async [Nat]{
        var mutable_arr = Array.thaw<Nat>(arr);
        var temp: Nat = mutable_arr[i];
        mutable_arr[i] := mutable_arr[j];
        mutable_arr[j] := temp;
        return Array.freeze(mutable_arr);
    };

    public func init_count(n : Nat): async [Nat]{
        var f = func( x : Nat) : Nat { return x;};
        return Array.tabulate<Nat>(n, f);
    };

    public func seven (arr : [Nat]): async Text{
        for(i in Iter.range(0, arr.size() - 1)){
            if(arr[i] == 7){
                return "Seven is found"
            }
        };
        return "Seven not found";
    };


    public func nat_opt_to_nat(n: ?Nat, m: Nat) : async Nat{
        return Option.get<Nat>(n, m);
    };

    public func day_of_the_week (n: Nat): async ?Text{
        var result: ?Text = null;
        result := switch n{
            case 1 ?"Moday";
            case 2 ?"Tuesday";
            case 3 ?"Wednesday";
            case 4 ?"Thursday";
            case 5 ?"Friday";
            case 6 ?"Saturday";
            case 7 ?"Sunday";
            case default null;
        };
        return result;
    };

    public func populate_array(arr : [?Nat]) : async [Nat]{
        return Array.map<?Nat, Nat>(arr, func (num : ?Nat) : Nat{
          if(num == null){
            return 0;
          }
          else return Option.unwrap(num);
        });
    };

    public func sum_of_array(arr : [Nat]) : async Nat{
        var sum:Nat = 0;
        var new_arr:[Nat] = Array.map<Nat, Nat>(arr,  func(num : Nat) : Nat{
          sum := sum + num;
          return sum;
        });
        return sum;
    };  

    public func squared_array(arr: [Nat]) : async [Nat]{
        return Array.map<Nat, Nat>(arr, func (num : Nat) : Nat{
          return num ** 2;
        });
    };

    public func increase_by_index(arr: [Nat]) : async [Nat]{
        return Array.mapEntries<Nat, Nat>(arr,func (num : Nat, index) : Nat{
          return index + num;
        });
    };

    private func contains<A>(array : [A], a : A, f : (A, A) -> Bool) : async Bool{
      for(item in Array.vals<A>(array)){
        if(a == item){
          return true;
        };
      };
      return false;
    };

}
