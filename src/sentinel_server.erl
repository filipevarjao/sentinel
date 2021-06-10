-module(sentinel_server).
-behaviour(gen_server).

-export([start_link/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

%% state
-record(state, {}).

%% API functioncs

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%% gen_server functioncs

%% @hidden
init(_) -> {ok, #state{}}.

%% @hidden
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

%% @hidden
handle_cast(_Msg, State) ->
    {noreply, State}.

%% @hidden
handle_info(_, State) ->
    {noreply, State}.

%% @hidden
terminate(_Reason, _State) -> ok.