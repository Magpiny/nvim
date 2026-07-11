-- =============================================================================
-- avante.nvim configuration
-- Author:    Magpiny (Wanjare), Kenya
-- Stack:     C++23 | wxWidgets | CMake | CachyOS
-- Providers: ollama (local, default) | claude (cloud) | moonshot (cloud)
-- =============================================================================

return {
	"yetone/avante.nvim",
	build = "make",
	event = "VeryLazy",
	version = false,

	---@module 'avante'
	---@type avante.Config
	opts = {
		-- Project-specific instructions file — place avante.md in each project root
		-- This is where you document project architecture for avante to consume
		instructions_file = "avante.md",

		-- ── Default provider: local ollama ──────────────────────────────────────
		-- Use local model by default — free, private, no API costs
		-- Switch to claude or moonshot for complex multi-file refactors
		provider = "ollama",

		-- ── Auto-suggestions provider ───────────────────────────────────────────
		-- Use local model for inline suggestions — keeps it free and fast
		auto_suggestions_provider = "ollama",

		-- ── Provider definitions ─────────────────────────────────────────────────
		providers = {

			-- ── Local: Ollama (magpiny-coder) ──────────────────────────────────
			-- Your custom Modelfile — tuned for C++23, your projects, your hardware
			-- Run: ollama create magpiny-coder -f Modelfile
			ollama = {
				endpoint = "http://localhost:11434", -- OpenAI-compatible endpoint
				model = "ornith:latest", -- your custom Modelfile model
				timeout = 90000, -- 90s — local model can be slow on cold start
				extra_request_body = {
					temperature = 0.15, -- matches your Modelfile — deterministic code
					max_tokens = 4096, -- matches num_predict in Modelfile
					options = {
						num_ctx = 32768, -- full context window
						num_thread = 14, -- Ryzen 7 Pro 7840U — 14 of 16 threads
						num_gpu = 20, -- RDNA3 iGPU conservative offload
					},
				},
			},

			-- ── Cloud: Anthropic Claude ─────────────────────────────────────────
			-- Best for: large refactors, architecture reviews, explaining complex bugs
			-- Switch with: :AvanteSwitchProvider claude
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514",
				timeout = 60000,
				extra_request_body = {
					temperature = 0.15, -- match local — consistent behaviour
					max_tokens = 16000,
				},
			},

			-- ── Cloud: Moonshot / Kimi ──────────────────────────────────────────
			-- Best for: very long context (128K) — entire codebase in one shot
			-- Switch with: :AvanteSwitchProvider moonshot
			moonshot = {
				endpoint = "https://api.moonshot.ai/v1",
				model = "kimi-k2-0711-preview",
				timeout = 60000,
				extra_request_body = {
					temperature = 0.15,
					max_tokens = 32768,
				},
			},
		},

		-- ── Behaviour ────────────────────────────────────────────────────────────
		behaviour = {
			auto_suggestions = false, -- turn on if you want inline ghost completions
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false, -- always review diffs before applying
			support_paste_from_clipboard = true,
		},

		-- ── File selector ────────────────────────────────────────────────────────
		-- Use telescope — already in your Neovim setup
		file_selector = {
			provider = "telescope",
		},

		-- ── UI hints ─────────────────────────────────────────────────────────────
		hints = {
			enabled = true,
		},

		-- ── Windows layout ───────────────────────────────────────────────────────
		windows = {
			position = "right", -- sidebar on the right
			wrap = true,
			width = 35, -- % of window width
			sidebar_header = {
				enabled = true,
				align = "center",
				rounded = true,
			},
			input = {
				prefix = "➤ ",
				height = 8,
			},
			edit = {
				border = "rounded",
				start_insert = true,
			},
			ask = {
				floating = false,
				start_insert = true,
				border = "rounded",
				focus_on_apply = "theirs",
			},
		},

		-- ── Diff view ────────────────────────────────────────────────────────────
		diff = {
			autojump = true,
			list_opener = "copen",
			override_timeoutlen = 500,
		},
	},

	-- ── Dependencies ───────────────────────────────────────────────────────────
	dependencies = {
		"nvim-lua/plenary.nvim", -- required: async utilities
		"MunifTanjim/nui.nvim", -- required: UI components
		"nvim-tree/nvim-web-devicons", -- file type icons in sidebar

		-- File selector — telescope is your primary picker
		"nvim-telescope/telescope.nvim",

		-- Input UI — dressing gives clean floating input boxes
		"stevearc/dressing.nvim",

		{
			-- Markdown rendering — makes avante responses readable in neovim
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},

		{
			-- Image paste support — useful for pasting screenshots of errors/diagrams
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					use_absolute_path = false, -- Linux — absolute paths not needed
				},
			},
		},
	},
}
