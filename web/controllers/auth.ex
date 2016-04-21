defmodule LocIm.Auth do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Phoenix.Controller

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  # https://graph.facebook.com/endpoint?key=value&amp;access_token=app_id|app_secret
  # /me?fields=id,name,user_birthday,email,
  def call(conn, repo) do
    case conn.params do
      %{"auth_token" => auth_token} ->
        case user = LocIm.Repo.get_by(LocIm.User, auth_token: auth_token) do
          nil -> invalid_auth_token(conn)
          user -> put_current_user(conn, user)
        end
      %{"fb_user_id" => fb_user_id, "fb_token" => fb_token} = params ->
        IO.puts "\n\n\n 2 \n\n\n"
        IO.puts "\n\n\n IN AUTH \n\n\n"
        IO.puts "\n\n\n #{inspect fb_user_id} \n\n\n"
        IO.puts "\n\n\n #{inspect fb_token} \n\n\n"
        IO.puts "\n\n\n #{inspect params} \n\n\n"
        IO.puts "\n\n\n ARE YOU PRUD OF ME \n\n\n"
        # LocIm.Api.UserController.create(conn, params)
        conn
      other -> 
        IO.puts "\n\n\n ELSER \n\n\n"
        IO.puts "\n\n\n #{inspect other} \n\n\n"
        invalid_auth_token(conn, "Please provide an auth_token") |> halt
    end
  end

  defp put_current_user(conn, user) do
    token = Phoenix.Token.sign(conn, "user socket", user.id)

    conn
    |> assign(:current_user, user)
    |> assign(:user_token, token)
  end

  defp invalid_auth_token(conn, message \\ "invalid auth_token") do
    conn = conn
    |> put_status(422)
    |> json(%{message: message})
    |> halt
    conn
  end
    # %{"auth_token" => auth_token} = conn.params
    # %{"auth_token" => "123", 
    # user_id = get_session(conn, :user_id)
    # cond do
    #   user = conn.assigns[:current_user] ->
    #     IO.puts "\n\n\n 1 \n\n\n"
    #     put_current_user(conn, user)
    #   user = user_id && repo.get(LocIm.User, user_id) ->
    #     IO.puts "\n\n\n 2 \n\n\n"
    #     put_current_user(conn, user)
    #   true ->
    #     IO.puts "\n\n\n 3 \n\n\n"
    #     assign(conn, :current_user, nil)
    # end
    # conn
  # end

  # def login(conn, user) do
  #   conn
  #   |> put_current_user(user)
  #   |> put_session(:user_id, user.id)
  #   |> configure_session(renew: true)
  # end

  # def logout_by_username_and_pass(conn, username, given_pass, opts) do
  #   repo = Keyword.fetch!(opts, :repo)
  #   user = repo.get_by(LocIm.User, username: username)

  #   cond do
  #     user && checkpw(given_pass, user.password_hash) ->
  #       {:ok, login(conn, user)}
  #     user ->
  #       {:error, :unauthorized, conn}
  #     true ->
  #       dummy_checkpw()
  #       {:error, :not_found, conn}
  #   end
  # end

  # def authenticate_user(conn, _opts) do
  #   if conn.assigns.current_user do
  #     conn
  #   else
  #     conn
  #     |> put_flash(:error, "You must be logged in to access the page.")
  #     |> redirect(to: Helpers.page_path(conn, :index))
  #     |> halt
  #   end
  # end

  
end