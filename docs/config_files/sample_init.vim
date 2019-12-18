" init.vim file by Nikhil Pattisapu

" Step1: Download a prebuilt binary version for your OS and add it in $PATH
" Step2: pip install pynvim
" Step3: Install vim-plug from the web using the following command
" Step4: Place this file at $HOME/.config/nvim
" Step5: Download nodejs binary and add to $PATH (for code completion plugin)

" =================== SPECIFIC VIM INSTRUCTIONS ==============================================================================

" Vim script treats the letter | as end of command. You can use it to write comments besides noremap
" Vim script treats the letter \ as a continuation of the previous command. Can be used to split long commands.
" Vim script uses (dot) for string concatenation (For e.g. "hello " . "world") 
" To check the values for some vim properties (e.g textwidth) you can use :set textwidth? or :colorscheme?
" To check the values of variables (e.g. let g:completor_python_binary) you can use :echo completor_python_binary

" ============================================================================================================================
" =================== Disable backgound colors (BCE) =========================================================================

if &term =~ '256color'				" disable Background Color Erase (BCE) so that color schemes
	set t_ut=				" render properly when inside 256-color tmux and GNU screen.
endif						" See https://sunaku.github.io/vim-256color-bce.html

" =================== External Vundle Plugins ================================================================================

call plug#begin()				" Use vundle#begin('~/path/here') to tell vundle where to install plugins.

Plug 'morhetz/gruvbox'				" A color scheme apt for python programming (Prefer Dark Mode)
Plug 'scrooloose/nerdtree'			" Shows file explorer within Vim
Plug 'jistr/vim-nerdtree-tabs'			" Allows us to open files in new tab from Vim.
Plug 'dense-analysis/ale'			" Asynchronous linting for many langs (Python). Needs pylint preinstalled. 
Plug 'vim-airline/vim-airline'			" Lean & mean status/tabline for vim that's light as air.
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion engine. Requires nodejs
Plug 'lervag/vimtex'				" Vim plugin for editing latex
call plug#end()					" All plugin entries should be enclosed before this line.


" ============================================================================================================================
" =================== General Settings =======================================================================================

set nocompatible				" Use vim not vi
set t_Co=256					" show colors even when opened inside screen or tmux
set termencoding=utf-8				" Set the default encoding to UTF-8.
set backspace=indent,eol,start			" Allow backspace over everything. Otherwise backspace key won't work in vim.
set autoread					" Reload file if changed externally.
set number					" Shows the line numbers by default.
set clipboard=unnamed				" Use system's clipboard (For copy and paste). Vim has a custom clipboard.
set scrolloff=999				" Ensures that your working line is always at the center (Better readability)
"set textwidth=200				" Default text width. 
set background=dark				" The default background is dark.
set termguicolors				" Add this to enable true terminal color support.
colorscheme gruvbox				" SETTING NECESSARY. Otherwise raises errors with plugin vim-indent-guides.

syntax on					" Shows colored syntax in vim.
filetype plugin on				" Detects a FileType which is used by autocomplete and other functionalities.
filetype indent on				" Performs indentation based on Filetyoe

" ============================================================================================================================
" =================== Backup Settings ========================================================================================

set nobackup
set nowritebackup
set noswapfile

" ============================================================================================================================
" =================== Search and Regular Expressions =========================================================================

set gdefault					" RegExp global by default
set magic					" Enable extended regexes.
set hlsearch					" highlight searches
set incsearch					" show the `best match so far' astyped
set ignorecase					" make searches case-insensitive
set smartcase					" unless they contain upper-case letters
set tabpagemax=100				" Max. number of tab pages allowed to be opened
set modifiable					" Will make a buffer modifiable. set noma does the opposite
" ============================================================================================================================
" =================== Python File type specific settings =====================================================================

au FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79
\ expandtab autoindent fileformat=unix foldmethod=indent foldnestmax=1
\ fileformat=unix completeopt-=preview colorcolumn=80 background=dark
au FileType python colorscheme gruvbox
au FileType python let g:gruvbox_termcolors=256
au FileType python let g:gruvbox_contrast_dark="hard"
au FileType python let g:gruvbox_contrast_dark="soft"
au FileType python let mapleader = "-"
au FileType python nnoremap <leader>= :0,$!yapf<CR>

" ============================================================================================================================
" =================== Latex File type specific settings ======================================================================

au FileType tex,latex,context,plaintex setlocal tabstop=4 softtabstop=4
\ shiftwidth=4 autoindent fileformat=unix wrap linebreak nolist
\ completeopt-=preview background=light

" ============================================================================================================================
" =================== RestructuredText File type specific settings ===========================================================

au BufNewFile,BufRead *.rst setlocal tabstop=2 softtabstop=2 shiftwidth=2
\ autoindent expandtab fileformat=unix wrap linebreak nolist background=light

" au BufNewFile,BufRead *.rst colorscheme PaperColor

" ============================================================================================================================
" =================== External Plugin Related Settings =======================================================================

let NERDTreeIgnore=['\.pyc$', '\~$', '\.pdf$',
\ '\.dvi$', '__pycache__']          		" Ignore specific kinds of files and directories in NERDTree
" let NERDTreeQuitOnOpen = 1			" Close NERDTree when opening a new file.

noremap <C-n> :NERDTreeToggle<CR>|		" Shortcut (Ctrl + n) to toggle NERDTree
noremap <S-Up> :tabr<cr>|			" Shortcut (Shift + Up) to go to the right tab
noremap <S-Down> :tabl<cr>|			" Shortcut (Shift + Down) to go to the left tab
noremap <S-Left> :tabp<cr>|			" Shortcut (Shift + Left) to go to the previous tab
noremap <S-Right> :tabn<cr>|			" Shortcut (Shift + Right) to go to the next tab
inoremap <C-n> <esc>:NERDTreeToggle<CR>|	" Shortcut in insert mode (Ctrl + n) to toggle NERDTree
inoremap <S-Up> <esc>:tabr<cr>|			" Shortcut in insert mode (Shift + Up) to go to the right tab
inoremap <S-Down> <esc>:tabl<cr>|		" Shortcut in insert mode (Shift + Down) to go to the left tab
inoremap <S-Left> <esc>:tabp<cr>|		" Shortcut in insert mode (Shift + Left) to go to the previous tab
inoremap <S-Right> <esc>:tabn<cr>|		" Shortcut in insert mode (Shift + Right) to go to the next tab


let g:indent_guides_enable_on_vim_startup = 1	" Show the visual indentation right from Vim startup. Enabled by default.
let g:completor_python_binary = $PYTHON3_PATH . "/bin/python" " Define miniconda python for completor.

" ============================================================================================================================
" =================== Internal Shortcuts which do not involve any external plugins ===========================================

let mapleader = "-"

inoremap <C-u> <esc>viwUei|			" Shortcut (ctrl + u) for making a word uppercased in insert mode 
nnoremap <C-u> viwUe|				" Shortcut (ctrl + u) for making a word uppercased in normal mode

inoremap <leader>ll <esc>$i|			" Shortcut (-ll) to go to the last letter of a line in insert mode
inoremap <leader>aa <esc>0i|			" Shortcut (-aa) to go to the first letter of a line in insert mode
nnoremap <leader>ll $|				" Shortcut (-ll) to go to the last letter of a line in normal mode
nnoremap <leader>aa 0|				" Shortcut (-aa) to go to the last letter of a line in normal mode

inoremap jk <esc>|				" Shortcut (jk) for <esc>
inoremap <esc> <nop>|				" Map <esc> to no operation (<nop>)

inoremap <silent> <C-[>OC <Right>|	
inoremap <silent> <C-[>OD <Left>|
inoremap <silent> <C-[>OB <Down>|
inoremap <silent> <C-[>OA <Up>|
inoremap <silent> <C-[>OC <Right>|
inoremap <silent> <C-[>OD <Left>|
inoremap <silent> <C-[>OB <Down>|
inoremap <silent> <C-[>OA <Up>|

iabbrev @@ @author: Nikhil Pattisapu, iREL, IIIT-H|	" Shortcut (@@) for adding signature

" ============================================================================================================================

let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
" let g:vimtex_view_method = 'xdvi'

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
