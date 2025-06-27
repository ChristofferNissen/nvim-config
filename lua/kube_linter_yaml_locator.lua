-- Returns a map: [kind][name] = line number (0-based) for each object in the YAML buffer
local function index_yaml_objects(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local result = {}
    local this_kind, this_name, obj_start

    for i, line in ipairs(lines) do
        -- New YAML doc starts with ---
        if line:match("^%-%-%-") then
            this_kind, this_name, obj_start = nil, nil, nil
        end

        local k = line:match("^kind:%s*(%S+)")
        if k then
            this_kind = k
            obj_start = i
        end

        local n = line:match("^%s*name:%s*(%S+)")
        if n and this_kind and obj_start then
            this_name = n
            -- Only store if we have both kind and name
            result[this_kind] = result[this_kind] or {}
            result[this_kind][this_name] = obj_start - 1 -- 0-based for Neovim
        end
    end

    return result
end

-- Given kind/name, return the starting line (or 0 if not found)
local function find_object_line(bufnr, kind, name)
    local index = index_yaml_objects(bufnr)
    return (index[kind] and index[kind][name]) or 0
end

return {
    index_yaml_objects = index_yaml_objects,
    find_object_line = find_object_line,
}
