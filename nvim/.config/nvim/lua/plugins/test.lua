return {
  { "nvim-neotest/neotest-plenary",
  "olimorris/neotest-phpunit",
  "nvim-neotest/neotest-python",
  "marilari88/neotest-vitest" },
  {
    "nvim-neotest/neotest",
    opts = { adapters = 
    { 
    "neotest-plenary",
    "neotest-python",
   "neotest-vitest",
   "neotest-phpunit" 
    }
     },
  },
}
