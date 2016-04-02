ExUnit.start

Mix.Task.run "ecto.create", ~w(-r LocIm.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r LocIm.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(LocIm.Repo)

