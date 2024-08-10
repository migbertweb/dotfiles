-- configuracion de gitsings
return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      current_line_blame = true, -- mostrar blame en la linea
      numhl = true,
      linehl = false,
    },
  },
}
