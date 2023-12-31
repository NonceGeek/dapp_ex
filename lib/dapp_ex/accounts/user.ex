defmodule DappEx.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :address, :string
    field :nickname, :string
    field :avatar_url, :string
    field :bio, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    required_fields = ~w(address)a
    optional_fields = ~w(nickname avatar_url bio email)a

    user
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
