return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
    font = "JetBrains Mono",

    init = function()
        local wk = require("which-key")
        wk.register({
            ["<leader>sc"] = {":Silicon<CR>", "Snapshot Code"},
            {mode = "v"}
        })
    end,

	config = function()
		require("silicon").setup({
		-- Configuration here, or leave empty to use defaults

            background_image = "/home/wanjares/Pictures/bgbf.jpg",
            to_clipboard = true,
            window_title = function()
	            return vim.fn.fnamemodify(
	                vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
                    ":t"
	            )
	        end,
            output = function()
                    return "./" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "code.png"
                end,
		})
	    end,

}
