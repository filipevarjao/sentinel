-module(sentinel_server).
-behaviour(gen_server).

-export([start_link/0, set_new_group_leader/1, stop_watch/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

%% state
-record(state, {group_leader :: pid()}).
-type state() :: #state{}.

%% API functioncs

-spec start_link() -> kz_types:startlink_ret().
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
-spec init([]) -> {'ok', state()}.
init(_) ->
    lager:info("starting sentinel server"),
    GroupLeader = erlang:group_leader(),
    {'ok', #state{group_leader=GroupLeader}}.

%% @hidden
-spec handle_call(any(), kz_term:pid_ref(), state()) -> kz_types:handle_call_ret_state(state()).
handle_call(_Request, _From, State) ->
    {'reply', 'ok', State}.

%% @hidden
-spec handle_cast(any(), state()) -> kz_types:handle_cast_ret_state(state()).
handle_cast({'add', Pid}, State) ->
    erlang:group_leader(self(), Pid),
    % handle_msgs(),
    {'noreply', State};
handle_cast(_Msg, State) ->
    {'noreply', State}.

%% @hidden
-spec handle_info(any(), state()) -> kz_types:handle_info_ret_state(state()).
handle_info(S, State) ->
    lager:error("[FILIPE-DEBUG] SOMETHING ~p~n", [S]),
    {'noreply', State}.

%% @hidden
-spec terminate(any(), state()) -> 'ok'.
terminate(_Reason, _State) -> 'ok'.

%% intercal functions

% -spec handle_msgs() -> {'io_reply', any(), any()} | 'ok'.
% handle_msgs() ->
%     receive
%         {'io_request',From,To,'getopts'} ->
%             reply(From, To, 'undefined'),
%             handle_msgs();
%         {'io_request',From,To,Msg} ->
%             lager:error("[FILIPE-DEBUG] Msg ~p~n", [Msg]),
%             reply(From, To, Msg),
%             handle_msgs();
%         Msg ->
%             lager:error("unhandled ~p~n", [Msg]),
%             erlang:error('unhandled', [Msg])
%     end.

% -spec reply(pid(), any(), any()) -> {'io_reply', any(), any()}.
% reply(From, ReplyAs, Reply) ->
%     From ! {'io_reply', ReplyAs, Reply}.

% handle_msg({'put_chars',_Encoding,_,_, _}) ->
% handle_msg({'get_chars',_Encoding,_,_, _}) ->
% handle_msg({'get_line',_Encoding,_,_, _}) ->