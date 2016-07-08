defmodule Carbon.UserView do
  use Carbon.Web, :view

  def error_tag(form, field) do
    if error = form.errors[field] do
      content_tag :span, translate_error(error), class: "help-block"
    end
  end

  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(TshirtStore.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(TshirtStore.Gettext, "errors", msg, opts)
    end
  end
end
