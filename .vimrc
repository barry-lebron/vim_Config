set number
set relativenumber
set cursorline
set textwidth=120
set nocompatible 
set backspace=indent,eol,start ":help 'backspace'
syntax on
set showmode
set clipboard=unnamed
set showcmd
set mouse=a
set encoding=utf-8
set t_Co=256   "配置主题gruvbox一定要启用这一行，不然无效果！
filetype plugin indent on
set autoindent
set tabstop=2
set shiftwidth=4
set expandtab
set softtabstop=2
set laststatus=2
set ruler
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set spell spelllang=en_us
set nobackup
set noswapfile
set undofile
set autochdir
set noerrorbells
set history=1000
set autoread
set wildmenu
set wildmode=longest:list,full
let mapleader=" "

call plug#begin()
  " List your plugins here
  Plug 'preservim/nerdtree'
  Plug 'lervag/vimtex', { 'tag': 'v2.15' }
  Plug 'morhetz/gruvbox'
  Plug 'vim-airline/vim-airline' "底部状体栏
  Plug 'vim-airline/vim-airline-themes'
  Plug 'preservim/nerdcommenter' "快捷注释
  Plug 'neoclide/coc.nvim', {'branch': 'release'} "LSP管理 自动补全,类似YCM YouCompleteMe
  Plug 'honza/vim-snippets' " 代码片段补全
call plug#end()


"LaTeX配置
let g:tex_flavor='latex'
let g:vimtex_texcount_custom_arg=' -ch -total'
"映射VimtexCountWords！\lw 在命令模式下enter此命令可统计中英文字符的个数
au FileType tex map <buffer> <silent>  <leader>lw :VimtexCountWords!  <CR><CR>
let g:Tex_ViewRule_pdf = 'E:\SumatraPDF\SumatraPDF.exe -reuse-instance -inverse-search "gvim -c \":RemoteOpen +\%l \%f\""'

"这里是LaTeX编译引擎的设置，这里默认LaTeX编译方式为-pdf(pdfLaTeX),
"vimtex提供了magic comments来为文件设置编译方式
"例如，我在tex文件开头输入 % !TEX program = xelatex   即指定-xelatex （xelatex）编译文件
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-pdf',
    \ 'pdflatex'         : '-pdf',
    \ 'dvipdfex'         : '-pdfdvi',
    \ 'lualatex'         : '-lualatex',
    \ 'xelatex'          : '-xelatex',
    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
    \ 'context (luatex)' : '-pdf -pdflatex=context',
    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
    \}
"这里是设置latexmk工具的可选参数
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-shell-escape',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" 阅读器相关的配置 包含正反向查找功能 仅供参考
let g:vimtex_view_general_viewer = 'E:\SumatraPDF\SumatraPDF.exe' "这里放置你的sumatrapdf 安装路径
" let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_view_general_options
     \ = ' -reuse-instance -forward-search @tex @line @pdf'
     \ . ' -inverse-search "' . 'cmd /c start /min \"\" '  . exepath(v:progpath)
     \ . ' -v --not-a-term -T dumb -c  \"VimtexInverseSearch %l ''%f''\""' "for vim/gvim



"编译过程中忽略警告信息
let g:vimtex_quickfix_open_on_warning=0

let maplocalleader=','
" ULTISNIPS Config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" airline config
set laststatus=2  "永远显示状态栏
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1 “ 显示窗口tab和buffer
let g:airline_theme='deus' " murmur配色不错
"if !exists('g:airline_symbols')
"let g:airline_symbols = {}
"endif
"let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
"let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'

" nerdcommenter config
let g:NERDCreateDeafultMappings = 1 "Create default mappings，具体默认快捷键映射参考其github官网
let g:NERDSpaceDelims = 1 "Add spaces after comment delimiters by default
" nerd tree
"map <C-n> :NERDTreeToggle<CR>  
" 后续可以修改为使用 leader key
nnoremap <leader>n :NERDTreeToggle<CR> 

" Colortheme
colorscheme gruvbox

" coc config 
" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" coc-snippets Config 
"""start

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
" make <TAB> used for trigger completion, completion confirm, snippet expand and jump
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
"""end 


