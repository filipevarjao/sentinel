%%%-------------------------------------------------------------------
%% @doc sentinel public API
%% @end
%%%-------------------------------------------------------------------

-module(sentinel_app).

-behaviour(application).

-export([start/2, stop/1]).

-spec start(application:start_type(), any()) -> kz_types:startapp_ret().
start(_StartType, _StartArgs) ->
    code:add_path("/home/2600hz/.asdf/installs/elixir/1.10/bin/../lib/elixir/ebin"),
    % code:add_path("/home/2600hz/kazoo5/deps/bigbrother/ebin"),
    application:ensure_all_started(elixir),
    % application:ensure_all_started(bigbrother),
    sentinel_sup:start_link().

-spec stop(any()) -> any().
stop(_State) ->
    'ok'.

%% internal functions
% [{bigbrother,
% [
%   {'Elixir.BigbrotherWeb.Endpoint',
%    [
%      {'url', [{'host', 'localhost'}]},
%      {'secret_key_base', "76R5Gef5BOWWPJrLjQzHEJSY1/+NrydBrJhumQbkOPNUFWLSBbfd0ltuw1SFWPOP"},
%      {'render_errors', [
%             {'view', 'Elixir.BigbrotherWeb.ErrorView'},
%             {'accepts', [{"html", "json"}]},
%             {'layout', 'false'}
%           ]},
%      {'pubsub_server', 'Elixir.Bigbrother.PubSub'},
%      {'live_view', [{'signing_salt', "cq7P64uf"}]},
%      {'http', [{'port', 4000}]},
%      {'debug_errors', 'true'},
%      {'code_reloader', 'true'},
%      {'server', 'true'},
%      {'check_origin', 'false'},
%      {'watchers', [
%             {'node', [
%                           "node_modules/webpack/bin/webpack.js",
%                           "--mode",
%                           "development",
%                           "--watch-stdin",
%                           {'cd', "/home/filipe/workspace/bigbrother/assets"}
%                         ]}
%           ]},
%      {'live_reload', [
%             {'patterns', ["~r/priv\/static\/.*(js|css|png|jpeg|jpg|gif|svg)$/",
%                          "~r/priv\/gettext\/.*(po)$/",
%                          "~r/lib\/bigbrother_web\/(live|views)\/.*(ex)$/",
%                          "~r/lib\/bigbrother_web\/templates\/.*(eex)$/"]}
%           ]}]}]
% }]