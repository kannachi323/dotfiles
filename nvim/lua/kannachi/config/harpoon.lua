local M = {}
local root = vim.fs.normalize(vim.fn.expand("~/misty-org"))
local state_path = vim.fn.stdpath("state") .. "/misty-harpoon-lists.json"
local active = "default"
local harpoon

local function read_state()
    if vim.fn.filereadable(state_path) == 0 then
        return { active = "default", names = { "default" } }
    end
    return vim.json.decode(table.concat(vim.fn.readfile(state_path), "\n"))
end

local function save_state(name)
    local state = read_state()
    if not vim.tbl_contains(state.names, name) then
        table.insert(state.names, name)
    end
    state.active = name
    vim.fn.mkdir(vim.fn.fnamemodify(state_path, ":h"), "p")
    local temporary = state_path .. "." .. vim.fn.getpid() .. ".tmp"
    vim.fn.writefile({ vim.json.encode(state) }, temporary)
    assert(vim.uv.fs_rename(temporary, state_path))
end

local function absolute_path(name)
    name = name:gsub("^~/", vim.fn.expand("~") .. "/")
    if name:sub(1, 1) ~= "/" then
        name = root .. "/" .. name
    end
    return vim.fs.normalize(name)
end

function M.list()
    return harpoon:list(active)
end

function M.switch(name)
    name = vim.trim(name or "")
    if name == "" then return end
    if harpoon.ui.win_id then
        harpoon.ui:save()
        harpoon.ui:close_menu()
    end
    harpoon:sync()
    active = name
    M.list()
    harpoon:sync()
    save_state(name)
    vim.notify("Harpoon · " .. name)
end

function M.create()
    vim.ui.input({ prompt = "New Harpoon list: " }, function(name)
        if name then M.switch(name) end
    end)
end

function M.pick()
    local names = read_state().names
    table.sort(names)
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local opts = require("telescope.themes").get_dropdown({
        initial_mode = "normal",
        previewer = false,
        layout_config = { width = 0.6, height = 0.4 },
    })
    require("telescope.pickers").new(opts, {
        prompt_title = "Harpoon lists · misty-org",
        results_title = "j/k move · l select · h close · i search",
        default_selection_index = vim.fn.index(names, active) + 1,
        finder = require("telescope.finders").new_table({
            results = names,
            entry_maker = function(name)
                return {
                    value = name,
                    ordinal = name,
                    display = name .. (name == active and " (active)" or ""),
                }
            end,
        }),
        sorter = require("telescope.config").values.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selected = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selected then M.switch(selected.value) end
            end)
            map("n", "j", actions.move_selection_next)
            map("n", "k", actions.move_selection_previous)
            map("n", "l", actions.select_default)
            map("n", "h", actions.close)
            return true
        end,
    }):find()
end

function M.add()
    if vim.bo.buftype ~= "" or vim.api.nvim_buf_get_name(0) == "" then
        vim.notify("Open a file before adding a Harpoon mark.", vim.log.levels.WARN)
        return
    end
    M.list():add()
    vim.notify("Marked in Harpoon · " .. active)
end

function M.menu()
    harpoon.ui:toggle_quick_menu(M.list(), {
        title = " Harpoon · " .. active .. " · misty-org ",
        border = "rounded",
    })
end

function M.setup()
    harpoon = require("harpoon")
    active = read_state().active or "default"
    harpoon:setup({
        settings = {
            -- One workspace, even when Neovim starts in a nested repository.
            key = function() return root end,
            save_on_toggle = true,
            sync_on_ui_close = true,
        },
        default = {
            get_root_dir = function() return root end,
            -- Absolute stored paths keep navigation correct after :cd/:lcd/:tcd.
            create_list_item = function(_, name)
                local path = name and absolute_path(name) or vim.api.nvim_buf_get_name(0)
                local position = path == vim.api.nvim_buf_get_name(0)
                    and vim.api.nvim_win_get_cursor(0) or { 1, 0 }
                return { value = path, context = { row = position[1], col = position[2] } }
            end,
            display = function(item)
                local prefix = root .. "/"
                return item.value:sub(1, #prefix) == prefix
                    and item.value:sub(#prefix + 1) or item.value
            end,
            BufLeave = function(event, list)
                local item = list:get_by_value(vim.api.nvim_buf_get_name(event.buf))
                if item then
                    local position = vim.api.nvim_win_get_cursor(0)
                    item.context = { row = position[1], col = position[2] }
                end
            end,
        },
    })
    M.list()
    save_state(active)
    vim.api.nvim_create_user_command("HarpoonList", function(args)
        if args.args == "" then M.pick() else M.switch(args.args) end
    end, {
        nargs = "?",
        complete = function(prefix)
            return vim.tbl_filter(function(name)
                return name:sub(1, #prefix) == prefix
            end, read_state().names)
        end,
        desc = "Switch or create a named Harpoon list in misty-org",
        force = true,
    })
end

return M
