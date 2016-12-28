{application, test_server,
 [{description, "test RPC server"},
  {vsn, "1.0"},
  {modules, [tr_app,
             tr_sup,
             tr_server]},
  {registered, [tr_sup]},
  {application, [kernel, stdlib]},
  {mod, {tr_app, []}}
]}.
