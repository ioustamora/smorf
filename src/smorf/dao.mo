import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Map "mo:base/HashMap";
import Bool "mo:base/Bool";
import List "mo:base/List";
import Option "mo:base/Option";
import Nat "mo:base/Nat";

import Cycles "mo:base/ExperimentalCycles";

import Types "./types";

actor class Dao(name: Text, admin: Principal, created: Time.Time) {

    private let MAX_USERS = 1_000;
    private let MAX_PROPOSALS_PER_USER = 100;
    private let MAX_COMMENTS_PER_PROPOSAL = 100;
    private let MAX_DESCRIPTION_CHARS = 500;
    private let MAX_COMMENT_CHARS = 500;

    private var dao_name: Text = name;
    private var dao_admin: Principal = admin;
    private var dao_created: Time.Time = created;

    private var registration_fee: Nat = 1;
    private var registration_balance: Nat = 100;

    private var new_proposal_fee: Nat = 1;

    private var users = Map.HashMap<Principal, Types.Balance>(10, Principal.equal, Principal.hash);
    private var user_proposal = Map.HashMap<Principal, Types.Proposal>(10, Principal.equal, Principal.hash);
    private var next_proposal_id: Nat = 1;

    //users
    public shared ({caller}) func register_user(): async Text {
        assert not Principal.isAnonymous(caller);

        let user: Principal = caller;

        if (user == dao_admin) {
            return "user is admin of this dao";
        };

        if (is_registered(user)) {
            return "user alredy registered";
        };

        users.put(user, registration_balance);

        return Principal.toText(user);
    };
    private func is_registered(user: Principal): Bool {
        let is_user = users.get(user);
        if (is_user == null) {
            return false;
        };
        return true;
    };
    private func update_balance(user: Principal, new_balance: Types.Balance): Types.Balance {
        let result = users.replace(user, new_balance);
        let res = Option.get(result, 0);
        if (res != new_balance) {
            return res;
        };
        return 0;
    }; 
    public shared ({caller}) func remove_user(user: Principal): async Bool {
        assert not Principal.isAnonymous(caller);
        assert caller == dao_admin;
        assert not (user == dao_admin);

        return false;
    };
    //end users

    //proposals
    public shared ({caller}) func add_proposal(proposal: Types.Proposal): async Types.ProposalId {
        assert not Principal.isAnonymous(caller);

        let votes: List.List<Types.Vote> = List.nil<Types.Vote>();
        return 0;
    };
    private func can_add_proposal(user: Principal): Bool {
        return false;
    };
    public shared ({caller}) func vote(proposal: Types.Proposal): async Bool {
        assert not Principal.isAnonymous(caller);

        return false;
    };
    private func can_vote(user: Principal, proposal_id: Types.ProposalId): Bool {
        return false;
    };
    //end proposals

    public func get_dao_name() : async Text {
        return dao_name;
    };

    public func get_dao_admin() : async Text {
        return Principal.toText(dao_admin);
    };

    public func get_cycles_balance() : async Nat {
        return Cycles.balance();
    };
};