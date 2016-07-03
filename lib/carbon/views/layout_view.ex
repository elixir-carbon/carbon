defmodule Carbon.LayoutView do
	use Phoenix.View, root: "lib/carbon/templates"
	use Phoenix.HTML
  import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

end