%%%-------------------------------------------------------------------
%% @doc sentinel top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(sentinel_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

-spec start_link() -> kz_types:startlink_ret().
start_link() ->
    supervisor:start_link({'local', ?SERVER}, ?MODULE, []).

-spec init([]) -> kz_types:sup_init_ret().
init([]) ->
    SupFlags = #{strategy => 'one_for_one',
                 intensity => 0,
                 period => 1},
    ChildSpecs = child('sentinel_server'),
    {'ok', {SupFlags, [ChildSpecs]}}.

%% internal functions

child(Module) ->
	{Module, {Module, 'start_link', []},
	 'permanent', 2000, 'worker', [Module]}.