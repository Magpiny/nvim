-- nvim/lua/lsp/cmake.lua
return {
    cmd = { "neocmakelsp", "--stdio" },
    filetypes = { "cmake" },
    root_markers = { "CMakeLists.txt", ".git", "build" },
    single_file_support = true,
}
