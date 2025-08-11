local M = {}

M.build_with_job = function(cmd, cwd, name)
  vim.notify('Building ' .. name .. '...', vim.log.levels.INFO)

  vim.fn.jobstart(cmd, {
    cwd = cwd,
    on_exit = function(_, code)
      if code == 0 then
        vim.notify(name .. ' build completed successfully!', vim.log.levels.INFO)
      else
        vim.notify(name .. ' build failed with code ' .. code, vim.log.levels.ERROR)
      end
    end,
    on_stdout = function(_, data)
      if data and #data > 0 and data[1] ~= '' then
        vim.notify(name .. ': ' .. table.concat(data, '\n'), vim.log.levels.DEBUG)
      end
    end,
  })
end

return M
