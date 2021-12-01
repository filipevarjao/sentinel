DEPS = telemetry telemetry_poller jason phoenix_html plug_cowboy phoenix phoenix_live_dashboard bigbrother cowboy_telemetry
FETCH_AS=https://github.com/

DEP_PLUGINS = elixir.mk mix.mk
BUILD_DEPS = elixir.mk mix.mk
dep_elixir.mk = git https://github.com/botsunit/elixir.mk.git master
dep_mix.mk = git https://github.com/botsunit/mix.mk.git master

dep_telemetry = git $(FETCH_AS)filipevarjao/telemetry main
dep_telemetry_poller = git $(FETCH_AS)filipevarjao/telemetry_poller main
dep_jason = git $(FETCH_AS)filipevarjao/jason master
dep_phoenix_html = git $(FETCH_AS)phoenixframework/phoenix_html.git master
dep_plug_cowboy = git $(FETCH_AS)elixir-plug/plug_cowboy master
dep_phoenix = git $(FETCH_AS)phoenixframework/phoenix master
dep_phoenix_live_dashboard = git $(FETCH_AS)phoenixframework/phoenix_live_dashboard master
#dep_phoenix_live_view = git $(FETCH_AS)phoenixframework/phoenix_live_view master
dep_bigbrother = git $(FETCH_AS)filipevarjao/bigbrother main

dep_cowboy_telemetry = git $(FETCH_AS)/beam-telemetry/cowboy_telemetry