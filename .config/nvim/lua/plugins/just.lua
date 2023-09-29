return {
    "IndianBoy42/tree-sitter-just",
    dependencies = {
    "NoahTheDuke/vim-just",
    },
    config = function()
        require("tree-sitter-just").setup({})
    end
}
