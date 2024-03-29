defmodule SoftieWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  use Phoenix.HTML

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_tag(%{errors: errors}, field) do
    if Keyword.has_key?(errors, field) do
      content_tag :span, class: "help-block" do
        [
          "#{String.capitalize(Atom.to_string(field))} ",
          Enum.map(Keyword.get_values(errors, field), fn (error) ->
            translate_error(error)
          end)
        ]
      end
    end
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(SoftieWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(SoftieWeb.Gettext, "errors", msg, opts)
    end
  end

  def state_class(form, field) do
    if form.errors[field] do
      "is-error"
    else
      "is-success"
    end
  end
end
