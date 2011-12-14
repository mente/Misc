set nocompatible
set ruler
set nu
set foldmethod=indent
set incsearch
set scrolljump=7
set scrolloff=7
set novisualbell
set t_vb=
set termencoding=utf-8
set fileencodings=utf8,cp1251
set smartcase
set gdefault

set hidden
set ch=1
set mousehide

set autoindent
syntax on

set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P
set laststatus=2

set smartindent

" CTRL-F для omni completion
imap <C-F> <C-X><C-O>

vmap <C-C> "+yi
imap <C-V> <esc>"+gPi

map <S-Insert> <MiddleMouse>

imap <F1> :make<cr>
nmap <F1> :make<cr>

nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i

map <F6> :bp<cr>
vmap <F6> <esc>:bp<cr>i
imap <F6> <esc>:bp<cr>i

map <F7> :bn<cr>
vmap <F7> <esc>:bn<cr>i
imap <F7> <esc>:bn<cr>i

map <F10> :bd<cr>
vmap <F10> <esc>:bd<cr>
imap <F10> <esc>:bd<cr>

map <F9> :TlistToggle<cr>
vmap <F9> <esc>:TlistToggle<cr>
imap <F9> <esc>:TlistToggle<cr>

map <F12> :NERDTreeToggle<cr>
vmap <F12> <esc>:NERDTreeToggle<cr>i
imap <F12> <esc>:NERDTreeToggle<cr>i

vmap < <gv
vmap > >gv

imap >Ins> <Esc>i

set wildmenu
set wcm=<Tab> 
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
menu Encoding.utf-8 :e ++enc=utf8 <CR>

imap [ []<LEFT>
imap {<CR> {<CR>}<Esc>O

map <C-Q> <Esc>:qa<cr>

function InsertTabWrapper()
 let col = col('.') - 1
 if !col || getline('.')[col - 1] !~ '\k'
 return "\<tab>"
 else
 return "\<c-p>"
 endif
endfunction]
imap <tab> <c-r>=InsertTabWrapper()<cr>

" Слова откуда будем завершать
set complete=""
" " Из текущего буфера
set complete+=.
" " Из словаря
set complete+=k
" " Из других открытых буферов
set complete+=b
" " из тегов 
set complete+=t

filetype plugin indent on
au BufRead,BufNewFile *.phps    set filetype=php
au BufRead,BufNewFile *.thtml    set filetype=php

if has("autocmd")
    autocmd BufRead *.sql set filetype=mysql      
endif


let g:SessionMgr_AutoManage = 0
let g:SessionMgr_DefaultName = "mysession"

let g:Tlist_Show_One_File = 1

set completeopt-=preview
set completeopt+=longest
set mps-=[:]

set dictionary=~/.vim/dic/php

set keywordprg=~/.vim/bin/php_doc 

set makeprg=php\ -l\ %

set errorformat=%m\ in\ %f\ on\ line\ %l

imap ,t <Esc>:tabnew<CR>
nmap ,t <Esc>:tabnew<CR>

imap ,tn <Esc>:tabnext<CR>
nmap ,tn <Esc>:tabnext<CR>

nmap <C-PgDown> <Esc>:tabnext<CR>

imap ,tp <Esc>:tabprevious<CR>
nmap ,tp <Esc>:tabprevious<CR>


iabbrev dbg echo '<pre>';var_dump( );echo '</pre>';
iabbrev tm echo 'Test message in file: '.__FILE__.', on line: '.__LINE__;

let g:pdv_cfg_Uses = 1

let php_folding = 1

let php_sql_query=1

let php_htmlInStrings=1 

let php_baselib = 1
" более привычные Page Up/Down, когда курсор остаётся в той же строке,
" (а не переносится в верх/низ экрана, как при стандартном PgUp/PgDown)
" Поскольку по умолчанию прокрутка по C-Y/D происходит на полэкрана,
" привязка делается к двойному нажатию этих комбинаций.
nmap <PageUp> <C-U><C-U>
imap <PageUp> <C-O><C-U><C-O><C-U>

nmap <PageDown> :tabnext<CR>
nmap <PageUp> :tabprevious<CR>
set clipboard=unnamed
nmap <c-f> :cs find g <c-r>=expand("<cword>")<cr><cr>
set linebreak
set nowrapscan
au BufReadPost *.pdf silent %!kpdf "%"
au BufReadPost *.doc silent %!soffice "%"
au BufReadPost *.odt silent %!soffice "%"
au BufReadPost *.png silent %!gwenview "%"
au BufReadPost *.gif silent %!gwenview "%"
au BufReadPost *.jpg silent %!gwenview "%"
nmap <Space> :set hlsearch!<CR>
function! MyTabLine()
	let tabline = ''

	" Формируем tabline для каждой вкладки -->
		for i in range(tabpagenr('$'))
			" Подсвечиваем заголовок выбранной в данный момент вкладки.
			if i + 1 == tabpagenr()
				let tabline .= '%#TabLineSel#'
			else
				let tabline .= '%#TabLine#'
			endif

			" Устанавливаем номер вкладки
			let tabline .= '%' . (i + 1) . 'T'

			" Получаем имя вкладки
			let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
		endfor
	" Формируем tabline для каждой вкладки <--

	" Заполняем лишнее пространство
	let tabline .= '%#TabLineFill#%T'

	" Выровненная по правому краю кнопка закрытия вкладки
	if tabpagenr('$') > 1
		let tabline .= '%=%#TabLine#%999XX'
	endif

	return tabline
endfunction

function! MyTabLabel(n)
	let label = ''
	let buflist = tabpagebuflist(a:n)

	" Имя файла и номер вкладки -->
		let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')

		if label == ''
			let label = '[No Name]'
		endif

		let label .= ' (' . a:n . ')'
	" Имя файла и номер вкладки <--

	" Определяем, есть ли во вкладке хотя бы один
	" модифицированный буфер.
	" -->
		for i in range(len(buflist))
			if getbufvar(buflist[i], "&modified")
				let label = '[+] ' . label
				break
			endif
		endfor
	" <--

	return label
endfunction

function! MyGuiTabLabel()
	return '%{MyTabLabel(' . tabpagenr() . ')}'
endfunction

set tabline=%!MyTabLine()
set guitablabel=%!MyGuiTabLabel()
set hlsearch
if has("autocmd")
    " When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event
	" handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
	\ endif
endif
nnoremap <leader>v V`]
nnoremap <leader><Space> <Plug>NerdCommenterToggle
let g:syntastic_enable_signs=1

"Fuck drupal
au BufNewFile,BufRead *.module setfiletype php
au BufNewFile,BufRead *.install  setfiletype php
au BufNewFile,BufRead *.inc  setfiletype php
