defmodule TemplateDisplay do
  require EEx

  EEx.function_from_file :def, :template_index, "templates/index_page.eex"

end
