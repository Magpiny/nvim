return {
  {
    'echasnovski/mini.surround',
    branch = 'stable',
    config = function()
      require('mini.surround').setup({
        search_method = 'cover_or_next',
      })
    end,
  },
  {
    'echasnovski/mini.comment',
    branch = 'stable',
    config = function()
      require('mini.comment').setup({})
    end,
  }
}

