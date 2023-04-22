defmodule OffBroadwayRedisStream.RedisClient do
  @moduledoc false

  defmodule ConnectionError do
    @moduledoc false

    @type t :: %__MODULE__{reason: atom}

    defexception [:reason, :message]
  end

  @type id :: String.t()
  @type message :: [any()]

  @callback init(config :: keyword) :: {:ok, any} | {:error, any}

  @callback fetch(
              demand :: pos_integer,
              last_id :: id,
              config :: map
            ) :: {:ok, messages :: [message()]} | {:error, ConnectionError.t()} | {:error, any}

  @callback consumers_info(config :: map) ::
              {:ok, any} | {:error, ConnectionError.t()} | {:error, any}

  @callback create_group(offset :: String.t(), config :: map) ::
              :ok | {:error, ConnectionError.t()} | {:error, any}

  @callback pending(
              consumer :: String.t(),
              count :: pos_integer(),
              config :: map
            ) :: {:ok, any} | {:error, ConnectionError.t()} | {:error, any}

  @callback claim(
              idle :: pos_integer,
              ids :: [id],
              config :: map
            ) :: {:ok, messages :: [message()]} | {:error, ConnectionError.t()} | {:error, any}

  @callback ack(ids :: [id], config :: map) ::
              :ok | {:error, ConnectionError.t()} | {:error, any}

  @callback delete_message(ids :: [id], config :: map) ::
              :ok | {:error, ConnectionError.t()} | {:error, any}

  @callback delete_consumers(consumers :: [String.t()], config :: map) ::
              :ok | {:error, ConnectionError.t()} | {:error, any}
end
