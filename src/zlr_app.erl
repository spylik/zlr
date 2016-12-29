%% --------------------------------------------------------------------------------
%% File:    zlr_app.erl
%% @author  Oleksii Semilietov <spylik@gmail.com>
%% --------------------------------------------------------------------------------

-module(zlr_app).
-behaviour(application).

-export([
        start/2,
        stop/1
    ]).

% @doc start application and start cowboy listerner
-spec start(Type, Args) -> Result when
    Type :: application:start_type(),
    Args :: term(),
    Result :: {'ok', pid()} | {'ok', pid(), State :: term()} | {'error', Reason :: term()}.

start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", zlr, []}
		]}
	]),

	{ok, _} = cowboy:start_clear(http, 10, [{port, 8080}], #{
		env => #{dispatch => Dispatch}
	}).

% @doc stop application (we stopping cowboy listener here)
-spec stop(State) -> Result when
    State :: term(),
    Result :: ok.

stop(_State) ->
    _ = cowboy:stop_listener(http),
    ok.
