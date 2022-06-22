%%%-------------------------------------------------------------------
%% @doc sentinel public API
%% @end
%%%-------------------------------------------------------------------

-module(sentinel_app).

-behaviour(application).

-export([start/2, stop/1]).


-spec start(application:start_type(), any()) -> kz_types:startapp_ret().
start(_StartType, _StartArgs) -> sentinel_sup:start_link().

-spec stop(any()) -> 'ok'.
stop(_State) ->
    'ok'.

%% internal functions
