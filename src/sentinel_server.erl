-module(sentinel_server).
-behaviour(gen_server).

-export([start_link/0, set_new_group_leader/1, stop_watch/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

%% state
-record(state, {group_leader :: pid()}).

%% API functioncs

start_link() ->
    gen_server:start_link({'local', ?MODULE}, ?MODULE, [], []).

-spec set_new_group_leader(pid()) -> 'ok'.
set_new_group_leader(Pid) ->
    gen_server:cast(?MODULE, {'add', Pid}).

-spec stop_watch() -> 'ok'.
stop_watch() ->
    erlang:group_leader('io'),
    'ok'.

%% gen_server functioncs

%% @hidden
init(_) ->
    lager:info("starting sentinel server"),
    GroupLeader = erlang:group_leader(),
    {'ok', #state{group_leader=GroupLeader}}.

%% @hidden
handle_call(_Request, _From, State) ->
    {'reply', 'ok', State}.

%% @hidden
handle_cast({'add', Pid}, State) ->
    erlang:group_leader(self(), Pid),
    handle_msgs(),
    {'noreply', State};
handle_cast(_Msg, State) ->
    {'noreply', State}.

%% @hidden
handle_info(_, State) ->
    {'noreply', State}.

%% @hidden
terminate(_Reason, _State) -> 'ok'.

%% intercal functions

-spec handle_msgs() -> {'io_reply', any(), any()} | 'ok'.
handle_msgs() ->
    receive
        'die' ->
            'ok';
        {'io_request',From,To,Msg} ->
            reply(From, To, Msg),
            handle_msgs();
        Msg ->
            io:format("Unhandled ~p~n", [Msg]),
            erlang:error('unhandled', [Msg])
    end.

-spec reply(pid(), any(), 'ok') -> {'io_reply', any(), any()}.
reply(From, ReplyAs, Reply) ->
    From ! {'io_reply', ReplyAs, Reply}.

% handle_msg({'put_chars',_Encoding,_,_, _}) ->
% handle_msg({'get_chars',_Encoding,_,_, _}) ->
% handle_msg({'get_line',_Encoding,_,_, _}) ->