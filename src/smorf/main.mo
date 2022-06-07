import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import List "mo:base/List";
import Text "mo:base/Text";
import Option "mo:base/Option";
import Map "mo:base/HashMap";
import Time "mo:base/Time";
import Cycles "mo:base/ExperimentalCycles";
import Iter "mo:base/Iter";

import Dao "./dao";

actor smorf {
  private var admins_daos = Map.HashMap<Principal, Principal>(10, Principal.equal, Principal.hash);

  public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  ///dynamically create dao canister 
  public shared ({ caller }) func create(name: Text) : async Text {
    assert not Principal.isAnonymous(caller);

    let admin: Principal = caller;

    Cycles.add(1_000_000_000_000);
    let dao = await Dao.Dao(name, admin, Time.now());
    let dao_id: Principal = Principal.fromActor(dao);

    //add to owners_daos hashmap
    admins_daos.put(admin, dao_id);
    let admins_daos_size = admins_daos.size();

    return 
      "admin: " # Principal.toText(admin) # 
      ", dao: " # Principal.toText(dao_id) # 
      ", size: " # Nat.toText(admins_daos_size);
  };

  public func list_daos(): async [(Principal, Principal)]{
    let r = Iter.toArray<(Principal, Principal)>(admins_daos.entries());
    r
  };

  public func get_cycles_balance(): async Nat {
    return Cycles.balance();
  };

  //call exteral canister by Principal
  public shared ({caller}) func get_canister_name(): async Text {
    assert not Principal.isAnonymous(caller);

    let canister = admins_daos.get(caller);

    if (canister == null) {
      return "error get canister by caller"
    };

    let dao_canister = Option.get(canister, Principal.fromText("error"));

    let bucket = actor(Principal.toText(dao_canister)): Dao.Dao;
    let name = await bucket.get_dao_name();

    return name;
  };

  public func get_state_size(): async Nat {
    return admins_daos.size();
  };

  // Reflects the [caller]'s identity by returning (a future of) its principal. 
  // Useful for debugging. 
  public shared({ caller }) func whoami(): async Text {
    return Principal.toText(caller);
  };

  public shared ({ caller }) func get_my_cycles_balance(): async Nat {
    return Cycles.balance();
  };

  ///create list and add to it
  public func test() : async Text {
    let l1 : List.List<Text> = List.nil<Text>();
    let listing = List.push("test", l1);
    let e1 = List.get(listing, 0);
    let element_text = Option.get(e1, "default");
    return "err: " # element_text;
  };
};
