import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import List "mo:base/List";
import HTTP "http";
//Challenge 1
actor{
  var TokenIndex : Nat;
  type Error  = {
    #Anonymous;
    #NotEnoughCycle;
  };

  //Challenge 2
  let registry = HashMap.HashMap<Nat, Principal>(0, Principal.equal, Principal.hash);

  //Challenge 3
  public type Result = Result.Result;
  stable var nextTokenIndex : Nat = 0;

  type Result<Bool , Text> = {#ok: Bool; #err : Text};

  public shared ({caller}) func mint() : async Result<Bool, Text> {
    if(Principal.isAnonymous(caller)){
      return #err("Anonymous wallet cannot mint");
    } else {
      registry.put(nextTokenIndex, caller); 
      nextTokenIndex += 1;
      return #ok(true);
      }
    };

    //Challenge 4
    public shared ({caller}) func transfer(receive_wallet: Principal, t: tokenIndex) : async Result<Bool, Text>{
      if (tokenIndex < registry.size()){
        return #err("NFT's id does not exist.");
      }
      if (Principal.isAnonymous(receive_wallet)){
        return #err("Invalid Principal ID");
      }
      switch(?registry.replace(tokenIndex, receive_wallet)){
      case (null)
        return #err("Not Exist");
      case (?id)
        return #ok(true);
    };

    //Challenge 5 
    public type List<Nat> = ?(TokenIndex, List<Nat>);

    public shared ({caller}) func balance() : async List<Nat>{
      var nft_list = List.nil<Nat>();
      for((K, V)) in registry.entries()){
        if(caller == V){
          nft_list := list.push(V);
        }
      }
      return nft_list;
    }

    //Challenge 6
    public query func http_request(request : HTTP.Request) : async HTTP.Response {
      let lastToken = registry.size(); // Nat
      let lastPrID = registry.get(lastToken - 1); // Principal
      let lastPrID1 = Option.get(lastPrID, Principal.fromText("2vxsx-fae"));

      let response = {
        body = Text.encodeUtf8("Token: " # Nat.toText(lastToken - 1) # ", Principal: " # Principal.toText(lastPrID1)) ;
        headers = [("Content-Type", "text/html; charset=UTF-8")];
        status_code = 200 : Nat16;
        streaming_strategy = null
        };
       return(response);
    };


    ///Challenge 7
    stable var data_storage: [(Nat, Principal)] = [] ;
    system func preupgrade() {
        data_storage := Iter.(favoriteNumber.entries());
    };
    system func postupgrade() {
        if(data_storage.size() > 0){
            registry = HashMap.fromIter(data_storage.vals(), 1, Principal.equal, Principal.hash);
            data_storage := [];
        }
    };
}

