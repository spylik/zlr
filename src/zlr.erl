%% --------------------------------------------------------------------------------
%% File:    zlr.erl
%% @author  Oleksii Semilietov <spylik@gmail.com>
%% --------------------------------------------------------------------------------

-module(zlr).

-define(NOTEST, true).
-ifdef(TEST).
    -compile(export_all).
-endif.

-export([init/2]).

-spec init(Req,Opts) -> Result when
    Req     :: cowboy_req:req(),
    Opts    :: cowboy_req:body_opts(),
    Result  :: {ok, cowboy_req:req(), Opts}.
    
init(Req0, Opts) ->
    Method = cowboy_req:method(Req0),
    #{wait := Wait} = cowboy_req:match_qs([{'wait', [], 'undefined'}], Req0),
    case Wait of
        'undefined' -> ok;
        Time -> timer:sleep(binary_to_integer(Time))
    end,
    Req = process_req(Method, Req0),
    {ok, Req, Opts}.

-spec process_req(Method, Req) -> Reply when
    Method  :: cowboy_req:method(),
    Req     :: cowboy_req:req(),
    Reply   :: cowboy_req:reply().

process_req(_Method, Req) ->
    cowboy_req:reply(200, #{<<"content-type">> => <<"text/html; charset=utf-8">>}, 
        <<"
        <!DOCTYPE html>
        <html lang=\"en\"><body>
        Hey Phu! <a href = \"http://www.seeyouspacecowboy.com/\">See your universe</a></body</html>">>, 
    Req).
