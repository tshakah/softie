defmodule SoftieWeb.TagView do
  use SoftieWeb, :view

  def display(tag) do
    "#{tag.scope}::#{tag.name}"
  end
end
