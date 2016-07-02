defmodule Carbon.UserView do
	use Phoenix.View, root: "lib/carbon/templates"
	use Phoenix.HTML

	def error_tag(form, field) do
		if error = form.errors[field] do
			content_tag :span, translate_error(error), class: "help-block"
		end
	end

  def translate_error({msg, opts}) do
    msg
  end
end