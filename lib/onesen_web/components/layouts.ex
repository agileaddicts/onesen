defmodule OnesenWeb.Layouts do
  use OnesenWeb, :html

  embed_templates "layouts/*"
  embed_templates "layouts/partials/*"
end
