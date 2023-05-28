return {
  {
    "ahmedkhalf/project.nvim",
    opts = {
      detection_methods = { "lsp", "pattern" },
      patterns = { "~/proyectos/", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    },
  },
}
