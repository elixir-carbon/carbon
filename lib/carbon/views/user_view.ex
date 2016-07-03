defmodule Carbon.UserView do
	use Carbon.Web, :view

	def error_tag(form, field) do
		if error = form.errors[field] do
			content_tag :span, translate_error(error), class: "help-block"
		end
	end

  def translate_error({msg, _opts}) do
    msg
  end
end