defmodule ChirpWeb.LinkLive.Index do
  use ChirpWeb, :live_view

  alias Chirp.Links
  alias Chirp.Links.Link

  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_user.id

    socket =
      socket
      |> assign(:links, Links.list_links(user_id))

    {:ok, socket}
  end
end
