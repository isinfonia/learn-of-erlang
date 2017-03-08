{application, simple_cache,
 [{description, "A simple caching system"},
  {vsn, "1.0"},
  {module, [sc_app,
            sc_sup]},
  {registered, [sc_sup]},
  {application, [kernel, stdlib, mnesia, resource_discovery]},
  {mod, {sc_app, []}}
]}.
