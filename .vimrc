function! WrapForTmux(s)
    if !exists('$TMUX')
        return a:s
    endif

    let tmux_start = "\<Esc>Ptmux;"
    let tmux_end = "\<Esc>\\"

    return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

if exists('$ITERM_PROFILE')
    if exists('$TMUX')
        let &t_SI = "\<Esc>[3 q"
        let &t_EI = "\<Esc>[0 q"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
end

"********************************************************
"                   一般性配置                          *
"********************************************************
" 关闭兼容vi模式
set nocompatible
" 显示行号
set number
" 在状态行上显示光标所在位置的行号和列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" history文件中需要记录的行数
set history=1000
set foldenable " 允许折叠
"突出显示当前行列
set cursorline
set cursorcolumn
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 与windows共享剪贴板
set clipboard+=unnamed
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
" 启动智能补全
filetype plugin indent on
" 保存全局变量
" set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 高亮字符，让其不受100列限制
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%101v.*'
" 状态行颜色
"highlight StatusLine guifg=SlateBlue guibg=Yellow
"highlight StatusLineNC guifg=Gray guibg=White
" 不要备份文件（根据自己需要取舍）
set nobackup
set noswapfile
" 字符间插入的像素行数目
set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 不让vim发出讨厌的滴滴声
set noerrorbells
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5
" 在搜索的时候忽略大小写
set ignorecase
" 选中高亮
set hlsearch
" 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set incsearch
" 输入:set list命令是应该显示些啥？
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
" 不要闪烁
set novisualbell
" 自动格式化
set formatoptions=tcrqn
" 继承前一行的缩进方式，特别适用于多行注释
set autoindent
" 为C程序提供自动缩进
" set smartindent
" 使用C样式的缩进
set cindent
" 将tab键自动转换为空格
set expandtab
" 设置tab宽度
set tabstop=4
" 统一缩进为4
set shiftwidth=4
" 设置退格键时可以删除4个空格
set smarttab
set softtabstop=4
" 设定默认解码
set encoding=utf-8
" 自动判断编码时 依次尝试以下编码
set fileencodings=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936
" 不要用空格代替制表符
"set noexpandtab
" 不要换行
set nowrap
"********************************************************
"                  color scheme                         *
"********************************************************
syntax enable
syntax on
set t_Co=256
"set background=light
set background=dark
colorscheme desert
"color desert
"set tags=/var/www/lqc/JSWS/tags
"********************************************************
"                      Vundle                           *
"********************************************************
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
" 可以通过以下四种方式指定插件的来源
" a) 指定Github中vim-scripts仓库中的插件，直接指定插件名称即可，插件明中的空格使用"-"代替。
" Bundle 'L9'
" b) 指定Github中其他用户仓库的插件，使用“用户名/插件名称”的方式指定
Bundle 'Valloric/YouCompleteMe'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'hellotomcat/supersearch'
" ------------以下为Bundle命令
"********************************************************
"                   Bundle命令                          *
"********************************************************
" :BundleList              -列举列表(也就是.vimrc)中配置的所有插件
" :BundleInstall          -安装列表中的全部插件
" :BundleInstall!         -更新列表中的全部插件
" :BundleSearch foo   -查找foo插件
" :BundleSearch! foo  -刷新foo插件缓存
" :BundleClean           -清除列表中没有的插件
" :BundleClean!          -清除列表中没有的插件
"********************************************************
"                   YouCompleteMe配置                   *
"********************************************************
"leader映射为逗号“，”
let mapleader = ","  
"配置默认的ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' 
"按gb 会跳转到定义
nnoremap <silent> gb :YcmCompleter GoToDefinitionElseDeclaration<CR>   
nnoremap <leader>m :YcmCompleter GoToDeclaration<CR>           " 跳转到申明处
nnoremap <leader>. :YcmCompleter GoToDefinition<CR>            " 跳转到定义处
"打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_confirm_extra_conf=0   
"开启语义补全
let g:ycm_seed_identifiers_with_syntax = 1
"每次重新生成匹配项，禁止缓存匹配项
let g:ycm_cache_omnifunc=0
"在注释中也可以补全
let g:ycm_complete_in_comments=1
"输入第二个字符就开始补全
let g:ycm_min_num_of_chars_for_completion=2
"设置error和warning的提示符
let g:ycm_error_symbol='>>'
let g:ycm_warning_symbol='>*'
"map <F2> : YcmDiags<CR>
"在接受补全后不分裂出一个窗口显示接受的项
set completeopt-=preview
"不查询ultisnips提供的代码模板补全，如果需要，设置成1即可
"let g:ycm_use_ultisnips_completer=0
"开启基于tag的补全，可以在这之后添加需要的标签路径
"let g:ycm_collect_identifiers_from_tags_files = 1
"使用ctags生成的tags文件
"let g:ycm_collect_identifiers_from_tag_files = 1 
"********************************************************
"                   vim-airline配置                     *
"********************************************************
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set laststatus=2
"********************************************************
"                   nerdtree配置                        *
"********************************************************
"快捷键
nnoremap <silent> <F4> :NERDTreeToggle<CR>
"显示增强
let NERDChristmasTree=1
"自动调整焦点
let NERDTreeAutoCenter=1
"打开文件后自动关闭
let NERDTreeQuitOnOpen=1
"显示隐藏文件
let NERDTreeShowHidden=1
"显示行号
let NERDTreeShowLineNumbers=1
"窗口宽度
let NERDTreeWinSize=25
"不显示'Bookmarks' label 'Press ? for help'
let NERDTreeMinimalUI=1
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
"只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"********************************************************
"                   tagbar配置                          *
"********************************************************
nmap <silent> <F5> :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_width=30
let g:tagbar_left = 1
"let g:tagbar_ctags_bin="/usr/local/bin/ctags"
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"********************************************************
"                   supersearch配置                     *
"********************************************************
nmap <silent> <F3> :call KeySearch()<CR>
"let g:conf_name = "project.conf"
"let g:source_path = []
 
 
