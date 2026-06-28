return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        tag = "v1.0.0",
        event = { "BufReadPost" },
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' |
                delay = 300,
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true})
                    else
                        gs.next_hunk()
                    end
                end, "Next git hunk")
                map("n", "[h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true})
                    else
                        gs.prev_hunk()
                    end
                end, "Prev git hunk")

                -- Actions
                map({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
                map({ "n", "v" }, "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
                map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
                map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
                map("n", "<leader>hb", function()
                    gs.blame_line({ full = true })
                end, { desc = "Blame line" })
                map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })

                -- Text Objects
                map({ "o", "x" }, "ih", "<cmd>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
            end,
        },
    },
}
