%%%-------------------------------------------------------------------
%% @doc sentinel public API
%% @end
%%%-------------------------------------------------------------------

-module(sentinel_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    sentinel_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
