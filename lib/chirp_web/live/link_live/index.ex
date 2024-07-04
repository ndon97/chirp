defmodule ChirpWeb.LinkLive.Index do
  use ChirpWeb, :live_view

  alias Chirp.Links
  # alias Chirp.Links.Link

  def mount(_params, _session, socket) do
    changeset = Links.Link.changeset(%Links.Link{})
    user_id = socket.assigns.current_user.id

    socket =
      socket
      |> assign(:links, Links.list_links(user_id))
      |> assign(:form, to_form(changeset))

    {:ok, socket}
  end

  @spec handle_event(<<_::48>>, map(), map()) :: {:noreply, map()}
  def handle_event("submit", %{"link" => link_params}, socket) do
    user_id = socket.assigns.current_user.id

    params =
      link_params
      |> Map.put("user_id", user_id)

    case Links.create_link(params) do
      {:ok, link} ->
        socket =
          socket
          |> assign(:links, [link | socket.assigns.links])

        {:noreply, socket}

      {:error, changeset} ->
        socket =
          socket
          |> assign(:form, to_form(changeset))

        {:noreply, socket}
    end
  end
end
