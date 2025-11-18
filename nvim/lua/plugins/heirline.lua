return {
  "rebelot/heirline.nvim",
  event = "UiEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    -- Color setup
    local colors = {
      bright_bg = utils.get_highlight("Folded").bg,
      bright_fg = utils.get_highlight("Folded").fg,
      red = utils.get_highlight("DiagnosticError").fg,
      dark_red = utils.get_highlight("DiffDelete").bg,
      green = utils.get_highlight("String").fg,
      blue = utils.get_highlight("Function").fg,
      gray = utils.get_highlight("NonText").fg,
      orange = utils.get_highlight("DiagnosticWarn").fg,
      purple = utils.get_highlight("Statement").fg,
      cyan = utils.get_highlight("Special").fg,
      diag_warn = utils.get_highlight("DiagnosticWarn").fg,
      diag_error = utils.get_highlight("DiagnosticError").fg,
      diag_hint = utils.get_highlight("DiagnosticHint").fg,
      diag_info = utils.get_highlight("DiagnosticInfo").fg,
      git_del = utils.get_highlight("DiffDelete").fg,
      git_add = utils.get_highlight("DiffAdd").fg,
      git_change = utils.get_highlight("DiffChange").fg,
    }

    require("heirline").load_colors(colors)

    -- FileIcon component
    local FileIcon = {
      init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(
          filename,
          extension,
          { default = true }
        )
      end,
      provider = function(self)
        return self.icon and (self.icon .. " ")
      end,
      hl = function(self)
        return { fg = self.icon_color }
      end,
    }

    -- TabLine Components
    local TablineBufnr = {
      provider = function(self)
        return tostring(self.bufnr) .. ". "
      end,
      hl = "Comment",
    }

    local TablineFileName = {
      provider = function(self)
        local filename = self.filename
        filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
        return filename
      end,
      hl = function(self)
        return { bold = self.is_active or self.is_visible, italic = true }
      end,
    }

    local TablineFileFlags = {
      {
        condition = function(self)
          return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
        end,
        provider = " [+]",
        hl = { fg = "green" },
      },
      {
        condition = function(self)
          return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
            or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
        end,
        provider = function(self)
          if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
            return "  "
          else
            return " "
          end
        end,
        hl = { fg = "orange" },
      },
    }

    local TablineFileNameBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(self.bufnr)
      end,
      hl = function(self)
        if self.is_active then
          return "TabLineSel"
        else
          return "TabLine"
        end
      end,
      on_click = {
        callback = function(_, minwid, _, button)
          if button == "m" then -- middle click to close
            vim.schedule(function()
              vim.api.nvim_buf_delete(minwid, { force = false })
            end)
          else
            vim.api.nvim_win_set_buf(0, minwid)
          end
        end,
        minwid = function(self)
          return self.bufnr
        end,
        name = "heirline_tabline_buffer_callback",
      },
      TablineBufnr,
      FileIcon,
      TablineFileName,
      TablineFileFlags,
    }

    local TablineCloseButton = {
      condition = function(self)
        return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
      end,
      { provider = " " },
      {
        provider = "",
        hl = { fg = "gray" },
        on_click = {
          callback = function(_, minwid)
            vim.schedule(function()
              vim.api.nvim_buf_delete(minwid, { force = false })
              vim.cmd.redrawtabline()
            end)
          end,
          minwid = function(self)
            return self.bufnr
          end,
          name = "heirline_tabline_close_buffer_callback",
        },
      },
    }

    local TablineBufferBlock = utils.surround({ "", "" }, function(self)
      if self.is_active then
        return utils.get_highlight("TabLineSel").bg
      else
        return utils.get_highlight("TabLine").bg
      end
    end, { TablineFileNameBlock, TablineCloseButton })

    -- Buffer list cache for conditional display
    local get_bufs = function()
      return vim.tbl_filter(function(bufnr)
        -- Only include listed buffers
        if not vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) then
          return false
        end

        -- Exclude special buffer types
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

        -- Exclude oil, quickfix, help, and other special buffers
        if filetype == "oil" or buftype == "quickfix" or buftype == "help" then
          return false
        end

        return true
      end, vim.api.nvim_list_bufs())
    end

    local buflist_cache = {}
    local terminal_buflist_cache = {}

    vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete", "TermOpen", "TermClose" }, {
      callback = function()
        vim.schedule(function()
          local buffers = get_bufs()
          local regular_bufs = {}
          local terminal_bufs = {}

          -- Separate regular buffers from terminal buffers
          for _, bufnr in ipairs(buffers) do
            if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == "terminal" then
              table.insert(terminal_bufs, bufnr)
            else
              table.insert(regular_bufs, bufnr)
            end
          end

          -- Update regular buffer cache
          for i, v in ipairs(regular_bufs) do
            buflist_cache[i] = v
          end
          for i = #regular_bufs + 1, #buflist_cache do
            buflist_cache[i] = nil
          end

          -- Update terminal buffer cache
          for i, v in ipairs(terminal_bufs) do
            terminal_buflist_cache[i] = v
          end
          for i = #terminal_bufs + 1, #terminal_buflist_cache do
            terminal_buflist_cache[i] = nil
          end

          -- Show tabline when there are multiple buffers or any terminals
          if #buflist_cache + #terminal_buflist_cache > 1 then
            vim.o.showtabline = 2
          elseif vim.o.showtabline ~= 1 then
            vim.o.showtabline = 1
          end
        end)
      end,
    })

    local BufferLine = utils.make_buflist(
      TablineBufferBlock,
      { provider = " ", hl = { fg = "gray" } }, -- left truncation
      { provider = " ", hl = { fg = "gray" } }, -- right truncation
      function()
        return buflist_cache
      end,
      false
    )

    -- Terminal tabs components
    local TerminalIcon = {
      provider = "  ",
      hl = { fg = "cyan" },
    }

    local TerminalName = {
      provider = function(self)
        local name = vim.api.nvim_buf_get_name(self.bufnr)
        -- Extract terminal name or use a default
        local term_name = name:match("term://.*//(%d+):") or name:match("term://.*:(%d+)")
        return term_name and ("Term " .. term_name) or "Terminal"
      end,
      hl = function(self)
        return { bold = self.is_active or self.is_visible, italic = true }
      end,
    }

    local TerminalFileNameBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(self.bufnr)
      end,
      hl = function(self)
        if self.is_active then
          return "TabLineSel"
        else
          return "TabLine"
        end
      end,
      on_click = {
        callback = function(_, minwid, _, button)
          if button == "m" then -- middle click to close
            vim.schedule(function()
              vim.api.nvim_buf_delete(minwid, { force = true })
            end)
          else
            vim.api.nvim_win_set_buf(0, minwid)
          end
        end,
        minwid = function(self)
          return self.bufnr
        end,
        name = "heirline_tabline_terminal_callback",
      },
      TerminalIcon,
      TerminalName,
    }

    local TerminalCloseButton = {
      { provider = " " },
      {
        provider = "",
        hl = { fg = "gray" },
        on_click = {
          callback = function(_, minwid)
            vim.schedule(function()
              vim.api.nvim_buf_delete(minwid, { force = true })
              vim.cmd.redrawtabline()
            end)
          end,
          minwid = function(self)
            return self.bufnr
          end,
          name = "heirline_tabline_close_terminal_callback",
        },
      },
    }

    local TerminalBufferBlock = utils.surround({ "", "" }, function(self)
      if self.is_active then
        return utils.get_highlight("TabLineSel").bg
      else
        return utils.get_highlight("TabLine").bg
      end
    end, { TerminalFileNameBlock, TerminalCloseButton })

    -- Terminal buffer list
    local TerminalLine = {
      condition = function()
        return #terminal_buflist_cache > 0
      end,
      utils.make_buflist(
        TerminalBufferBlock,
        { provider = " ", hl = { fg = "gray" } }, -- left truncation
        { provider = " ", hl = { fg = "gray" } }, -- right truncation
        function()
          return terminal_buflist_cache
        end,
        false
      ),
    }

    -- TabPages (for actual vim tabs)
    local Tabpage = {
      provider = function(self)
        return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
      end,
      hl = function(self)
        if not self.is_active then
          return "TabLine"
        else
          return "TabLineSel"
        end
      end,
    }

    local TabpageClose = {
      provider = "%999X  %X",
      hl = "TabLine",
    }

    local TabPages = {
      condition = function()
        return #vim.api.nvim_list_tabpages() >= 2
      end,
      utils.make_tablist(Tabpage),
      TabpageClose,
    }

    -- Spacer to push terminals and tab pages to the right
    local Spacer = {
      condition = function()
        return #terminal_buflist_cache > 0 or #vim.api.nvim_list_tabpages() >= 2
      end,
      provider = "%=",
    }

    -- Offset for sidebars (neo-tree, nvim-tree, etc.)
    local TabLineOffset = {
      condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        local bufnr = vim.api.nvim_win_get_buf(win)
        self.winid = win

        local filetype = vim.bo[bufnr].filetype
        if filetype == "neo-tree" or filetype == "NvimTree" then
          self.title = filetype == "neo-tree" and "Neo-Tree" or "NvimTree"
          return true
        end
      end,
      provider = function(self)
        local title = self.title
        local width = vim.api.nvim_win_get_width(self.winid)
        local pad = math.ceil((width - #title) / 2)
        return string.rep(" ", pad) .. title .. string.rep(" ", pad)
      end,
      hl = function(self)
        if vim.api.nvim_get_current_win() == self.winid then
          return "TablineSel"
        else
          return "Tabline"
        end
      end,
    }

    -- Final TabLine assembly
    local TabLine = { TabLineOffset, BufferLine, Spacer, TerminalLine, TabPages }

    -- Setup heirline with tabline
    require("heirline").setup({
      tabline = TabLine,
      opts = {
        disable_winbar_cb = function(args)
          return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
          }, args.buf)
        end,
      },
    })

    -- Ensure bufhidden wipe/delete buffers aren't listed
    vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
  end,
}
