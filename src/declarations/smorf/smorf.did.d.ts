import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface _SERVICE {
  'create' : ActorMethod<[string], string>,
  'get_canister_name' : ActorMethod<[], string>,
  'get_cycles_balance' : ActorMethod<[], bigint>,
  'get_my_cycles_balance' : ActorMethod<[], bigint>,
  'get_state_size' : ActorMethod<[], bigint>,
  'greet' : ActorMethod<[string], string>,
  'list_daos' : ActorMethod<[], Array<[Principal, Principal]>>,
  'test' : ActorMethod<[], string>,
  'whoami' : ActorMethod<[], string>,
}
