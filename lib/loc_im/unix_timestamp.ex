defmodule LocIm.UnixTimestamp do
  @epoch {{1970,1,1},{0,0,0}}

  def datetime_to_timestamp(ecto_datetime) do
    erl_datetime = Ecto.DateTime.to_erl(ecto_datetime)
    epoch_seconds = :calendar.datetime_to_gregorian_seconds(@epoch)
    :calendar.datetime_to_gregorian_seconds(erl_datetime) - epoch_seconds
  end
end