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
        <div style=\"position: fixed; z-index: -99; width: 100%; height: 100%\">
            <iframe frameborder=\"0\" height=\"100%\" width=\"100%\" src=\"https://youtube.com/embed/ZzkymYbhUCs?autoplay=1&controls=0&showinfo=0&autohide=1\"></iframe>
        </div></body</html>">>, 
    Req).
