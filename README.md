# FYT.vim - Flash Yanked Text

A very simple plugin which gives you a visual clue of the text you just yanked.

![demo](https://www.statox.fr/posts/vim/vim_flash_yanked_text/flash_yanked_text.gif)

# Configuration

You can configure how long you want the flash to last by setting the following variable in your `.vimrc`. The time is in milliseconds and defaults to 500:

    let FYT_flash_time = 1000

You can configure the highlighting group used to highlight yanked text by
setting the following variable. If not set the default value is `'IncSearch'`.

    let g:FYT_highlight_group = 'MyOwnHighlightGroup'

# About

If you're curious about why I did this plugin or how I did it have a read [here](https://www.statox.fr/posts/vim/vim_flash_yanked_text/)
