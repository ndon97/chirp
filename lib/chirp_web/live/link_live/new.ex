defmodule ChirpWeb.LinkLive.New do
  use ChirpWeb, :live_view

  alias Chirp.Links
  # alias Chirp.Links.Link

  def mount(_params, _session, socket) do
    changeset = Links.Link.changeset(%Links.Link{})

    socket =
      socket
      |> assign(:form, to_form(changeset))

    {:ok, socket}
  end

  def handle_event("submit", %{"link" => link_params}, socket) do
    user_id = socket.assigns.current_user.id

    params =
      link_params
      |> Map.put("user_id", user_id)

    case Links.create_link(params) do
      {:ok, _link} ->
        socket =
          socket
          |> put_flash(:info, "Link created successfully")
          |> push_navigate(to: ~p"/links")

        {:noreply, socket}

      {:error, changeset} ->
        socket =
          socket
          |> assign(:form, to_form(changeset))

        {:noreply, socket}
    end
  end
end