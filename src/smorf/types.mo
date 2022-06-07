import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import List "mo:base/List";
import Time "mo:base/Time";

module {
    public type Balance = Nat;
    public type ProposalId = Nat;
    public type Proposal = {
        votes: List.List<Vote>;
        state: ProposalState;
        created: Time.Time;
    };
    public type ProposalState = {
        #open;
        #rejected;
        #accepted;
    };
    public type Vote = {
        user: Principal;
        state: VoteState;
        balance: Nat;
    };
    public type VoteState = {
        #yes;
        #no;
    };
};