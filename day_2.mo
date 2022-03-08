import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Char "mo:base/Char";
import Iter  "mo:base/Iter";
import Array  "mo:base/Array";
import Debug  "mo:base/Debug";
import Int "mo:base/Int"
actor {
    // challenge 1
    public func nat_to_nat8(n:Nat) : async Nat8{
        if(n > 255) {
            return 255;
        };
        return Nat8.fromNat(n);
    };

    // challenge 2 
    public func max_number_with_n_bits(n:Nat) : async Nat{
        return 2**n;
    };

    // challenge 3
    public func decimal_to_bits(n:Nat) : async Text{
        var bit_string:Text = "";
        var devider:Nat = n;
        while(devider > 1){
            bit_string :=  Text.concat(Nat.toText(devider % 2), bit_string );
            devider := devider / 2;
        };
        return Text.concat( Nat.toText(devider), bit_string);
    };

    // challenge 4
    public func capitalize_character(c:Char) : async Text{
        if(Char.isLowercase(c)){
            return Char.toText(
                        Char.fromNat32(
                            Char.toNat32(c)-32
                            )
                        );
        };
        return Char.toText(c);
    };
    
    //challenge 5
    public func capitalize_text(input : Text) : async Text{
        var upper_text:Text = "";
        for(c in input.chars()){
            if(Char.isLowercase(c)){
                var upper_char:Text = await capitalize_character(c);
                upper_text := upper_text # upper_char;
            }
            else {
                upper_text := upper_text # Char.toText(c);
            }
        };
        return upper_text;
    };

    //challenge 6
    public func is_inside(t: Text, c: Char) : async Bool{
        return Text.contains(t, #char c);
    };

    //challenge 7
    public func trim_whitespace(t: Text) : async Text{
        return Text.trim(t, #text " ");
    };

    //challenge 8
    public func duplicated_character(t: Text) : async Text{
        var arr_text:[Char] = Iter.toArray(t.chars());
        var size:Nat = arr_text.size();
        var character_index:Nat = 0;
        for(i in Iter.range(0, size-1)){
          character_index := i;
          for(j in Iter.range(i+1, size-1)){
            if(arr_text[i] == arr_text[j]){
              character_index := j;
            } 
          };
          if(character_index != i){
            var result: Char =  arr_text[character_index];
            return Char.toText(result);
          };
        };
        return t;
    };

    //challenge 9
    public func size_in_bytes(t : Text) : async Nat{
      return t.size() * 8;
    };

    //challenge 10
     public func bubble_sort (arr : [Nat]) : async [Nat]{
        var new_arr : [var Nat] = Array.thaw<Nat>(arr);
        var i:Nat = 0;
        var size:Nat = arr.size();
        for(i in Iter.range(0, size-1)){
          for(j in Iter.revRange(size-1, i)){
              var index:Nat = Int.abs(j);
              var pre_index:Nat = Int.abs(j-1);
             if(new_arr[pre_index] > new_arr[index]){
                var temp:Nat = new_arr[pre_index];
                new_arr[pre_index] := new_arr[index];
                new_arr[index] := temp;
              };
          };
        };
        return Array.freeze(new_arr);
    };
}