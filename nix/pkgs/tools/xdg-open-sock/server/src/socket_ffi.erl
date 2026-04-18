-module(socket_ffi).

-export([
    to_erl_tcp_options/1,
    close/1
]).

to_erl_tcp_options(Options) ->
    lists:map(fun(A) -> to_erl_tcp_option(A) end, Options).

% use UDS
to_erl_tcp_option(local) -> local;
% handle data as binary
to_erl_tcp_option(binary) -> binary;
% zero packet header
to_erl_tcp_option(zero_packet_header) -> {packet, 0};
% socket path
to_erl_tcp_option({uds_path, Path}) -> {ifaddr, {local, Path}};
% recv manually
to_erl_tcp_option(active_mode_passive) -> {active, false};
% reuse addr
to_erl_tcp_option(reuse_addr) -> {reuseaddr, true}.

close(Socket) ->
    case gen_tcp:close(Socket) of
        ok -> {ok, nil};
        {error, Reason} -> {error, Reason}
end.
