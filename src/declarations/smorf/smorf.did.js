export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'create' : IDL.Func([IDL.Text], [IDL.Text], []),
    'get_canister_name' : IDL.Func([], [IDL.Text], []),
    'get_cycles_balance' : IDL.Func([], [IDL.Nat], []),
    'get_my_cycles_balance' : IDL.Func([], [IDL.Nat], []),
    'get_state_size' : IDL.Func([], [IDL.Nat], []),
    'greet' : IDL.Func([IDL.Text], [IDL.Text], []),
    'list_daos' : IDL.Func(
        [],
        [IDL.Vec(IDL.Tuple(IDL.Principal, IDL.Principal))],
        [],
      ),
    'test' : IDL.Func([], [IDL.Text], []),
    'whoami' : IDL.Func([], [IDL.Text], []),
  });
};
export const init = ({ IDL }) => { return []; };
