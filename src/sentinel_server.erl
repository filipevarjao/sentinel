-module(sentinel_server).
-behaviour(gen_server).

-export([start_link/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

%% state
-record(state, {skt :: any()}).
-type state() :: #state{}.

-define(PORT, 8789).
% -define(Length, 1024).

%% API functioncs

-spec start_link() -> kz_types:startlink_ret().
start_link() ->
    gen_server:start_link({'local', ?MODULE}, ?MODULE, [], []).

%% gen_server functioncs

%% @hidden
-spec init([]) -> {'ok', state()}.
init(_) ->
    lager:info("starting sentinel server"),
    {'ok', Socket} = gen_udp:open(?PORT),
    % {'module', _} = code:ensure_loaded('webhooks_sentinel'),
    io:format('user', "starting sentinel server~n", []),
    {'ok', #state{skt=Socket}}.

%% @hidden
-spec handle_call(any(), kz_term:pid_ref(), state()) -> kz_types:handle_call_ret_state(state()).
handle_call(_Request, _From, State) ->
    {'reply', 'ok', State}.

%% @hidden
-spec handle_cast(any(), state()) -> kz_types:handle_cast_ret_state(state()).
handle_cast(_Msg, State) ->
    {'noreply', State}.

%% @hidden
-spec handle_info(any(), state()) -> kz_types:handle_info_ret_state(state()).
handle_info({'udp',Socket,_Host,_, Msg}, #state{skt=Socket}=State) ->
    fire_request(Msg),
    {'noreply', State};
handle_info(_Something, State) ->
    {'noreply', State}.

%% @hidden
-spec terminate(any(), state()) -> 'ok'.
terminate(_Reason, #state{skt=Socket}) ->
    gen_udp:close(Socket).

%% intercal functions

fire_request(SocketMessage) ->
    Headers = [{<<"Content-Type">>, <<"form-data">>}],
    kz_http:req('post',
                <<"http://192.168.0.145:8080/events">>,
                Headers,
                erlang:list_to_binary(SocketMessage)
               ).