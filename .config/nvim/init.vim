set clipboard+=unnamedplus
set termguicolors
set spelllang=en,ru
set nospell
set ignorecase
autocmd FileType tex,markdown setlocal spell
set conceallevel=2
set autoindent noexpandtab tabstop=4 shiftwidth=4
set synmaxcol=200
set showtabline=2
set mouse=a
set cmdheight=1

" Keymap
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

map j gj
map k gk

let g:python3_host_prog = '/usr/bin/python3'
let g:loaded_python_provider = 0 " Disable Python 2 provider

call plug#begin()
	" Autosave
	" Plug 'chrisbra/vim-autosave'
	" let g:autosave_timer = 30 * 1000 " save each 30 seconds

	Plug 'editorconfig/editorconfig-vim'
	
	" Find & replace results preview
	Plug 'osyo-manga/vim-over'
	let g:over_command_line_key_mappings = {
	\	"\<C-l>" : "\<C-f>",
	\	"\<C-h>" : "\<C-b>"
	\}

	" Smooth scroll in Lua
	Plug 'karb94/neoscroll.nvim'

	" Syntax highlighting
	Plug 'cespare/vim-toml'
	Plug 'ron-rs/ron.vim'
	let g:ron_recommended_style = 0 " Allow indenting with tabs
	Plug 'artoj/qmake-syntax-vim'
	Plug 'terminalnode/sway-vim-syntax'
	Plug 'igankevich/mesonic'
	Plug 'plasticboy/vim-markdown'
	let g:vim_markdown_folding_disabled = 1
	let g:vim_markdown_conceal = 1
	
	" Display indentation levels with thin vertical lines
	" Plug 'Yggdroot/indentLine'
	" let g:indentLine_char = '▏'
	
	Plug 'Logarithmus/rust-conceal'
	Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
	
	" LaTeX
	Plug 'lervag/vimtex'
	let g:tex_flavor = 'latex'
	
	Plug 'lifepillar/vim-colortemplate'

	" Snippets
	Plug 'Shougo/neosnippet.vim'
	Plug 'Shougo/neosnippet-snippets'
	let g:neosnippet#enable_completed_snippet = 1
	autocmd CompleteDone * call neosnippet#complete_done()
	
	" Plugin key-mappings.
	" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
	imap <C-k>	 <Plug>(neosnippet_expand_or_jump)
	smap <C-k>	 <Plug>(neosnippet_expand_or_jump)
	xmap <C-k>	 <Plug>(neosnippet_expand_target)
	" 
	" " SuperTab like snippets behavior.
	" " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
	" imap <expr><TAB>
	"  	\pumvisible() ? "\<C-n>" :
	"  	\neosnippet#expandable_or_jumpable() ?
	" 	\"\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
	" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	" 	\"\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

	" Theme
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'dunckr/vim-monokai-soda'
	Plug 'crusoexia/vim-monokai'
	Plug 'dracula/vim'
	Plug 'lifepillar/vim-gruvbox8'
	let g:gruvbox_contrast_dark = 'hard'
	let g:gruvbox_contrast_light = 'hard'
	let g:gruvbox_plugin_hi_groups = 1
	Plug 'Logarithmus/vim-obsidian'

	Plug 'norcalli/nvim-colorizer.lua'
	
	Plug 'Logarithmus/LanguageClient-neovim', {
	\	'branch': 'enhanced-hints-next',
	\	'do': 'sh install.sh',
	\}
	let g:LanguageClient_serverCommands = {
	\	'rust': {
	\		'name': 'rust-analyzer',
	\		'command': ['rust-analyzer'],
	\		'initializationOptions': {
	\			'server': {
	\				'extraEnv': {
	\					'RUSTFLAGS': [
	\						'-C', 'linker=clang',
	\						'-C', 'link-arg=--ld-path=mold'
	\					]
	\				}
	\			},
	\			'checkOnSave': {
	\				'enable': v:false,
	\				'extraArgs': ['--target-dir', '/home/artur/.cache/cargo/target']
	\			},
	\			'rustfmt': {
	\				'overrideCommand': ['rustfmt']
	\			},
	\			'diagnostics': {
	\				'disabled': ['incorrect-ident-case']
	\			},
	\			'inlayHints': {
	\				'enable': v:true,
	\			}		
	\		}
	\	},
	\	'c': ['clangd'],
	\	'cpp': ['clangd'],
	\}

	let g:LanguageClient_hoverPreview = 'Always'
	" let g:LanguageClient_completionPreferTextEdit = 1
	" let g:LanguageClient_loggingFile = expand('~/.config/nvim/LanguageClient.log')
	" let g:LanguageClient_loggingLevel = 'DEBUG'
	let g:rust_recommended_style = 0

	Plug 'ncm2/ncm2'
	Plug 'roxma/nvim-yarp'

	
    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

    " IMPORTANT: :help Ncm2PopupOpen for more information
	set completeopt=noinsert,menuone
	set pumheight=8

    " NOTE: you need to install completion sources to get completions. Check
    " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'

	inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

	" Plug 'prabirshrestha/asyncomplete.vim'
	" Plug 'tryone144/asyncomplete-LanguageClient.vim'
	" Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
	" Plug 'prabirshrestha/asyncomplete-file.vim'
	" Plug 'prabirshrestha/asyncomplete-emoji.vim'

	Plug 'easymotion/vim-easymotion'

	" {}, (), {}
	Plug 'tpope/vim-endwise'
	Plug 'tpope/vim-surround'
	Plug 'rstacruz/vim-closer'
	
		
	" Documentation in status bar
	" Plug 'Shougo/echodoc.vim', { 'for': ['rust', 'c', 'cpp'] }
	" set cmdheight=2
	" let g:echodoc#enable_at_startup = 0
	" let g:echodoc#type = 'signature'
	
	Plug 'udalov/kotlin-vim' " Kotlin
	Plug 'mattn/emmet-vim' " HTML generator
	Plug 'itchyny/lightline.vim' " Status bar
	Plug 'mengelbrecht/lightline-bufferline'
	Plug 'albertomontesg/lightline-asyncrun'
	let g:lightline = {
	\	'separator': { 'left': '', 'right': '' },
	\	'subseparator': { 'left': '', 'right': '' },
	\	'colorscheme': 'one',
	\	'active': {
	\		'left': [[ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ]]
	\	},
	\	'tabline': {
	\		'left': [['buffers']],
	\		'right': [['close']]
	\	},
	\	'component_expand': {
	\		'buffers': 'lightline#bufferline#buffers'
	\	},
	\	'component_type': {
	\		'buffers': 'tabsel'
	\	}
	\}
	Plug 'ALLCAPSDEV/lightline-gruvbox.vim'
	let g:lightline_gruvbox_style = 'hard'
	let g:lightline_gruvbox_color = 'both'
	
	" Java
	Plug 'artur-shaik/vim-javacomplete2'
	autocmd FileType java setlocal omnifunc=javacomplete#Complete
	nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
	imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
	nmap <F5> <Plug>(JavaComplete-Imports-Add)
	imap <F5> <Plug>(JavaComplete-Imports-Add)
	nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
	imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
	nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
	imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
	nmap <leader>jI <Plug>(JavaComplete-Imports-AddMissing)
	nmap <leader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
	nmap <leader>ji <Plug>(JavaComplete-Imports-AddSmart)
	nmap <leader>jii <Plug>(JavaComplete-Imports-Add)
	imap <C-j>I <Plug>(JavaComplete-Imports-AddMissing)
	imap <C-j>R <Plug>(JavaComplete-Imports-RemoveUnused)
	imap <C-j>i <Plug>(JavaComplete-Imports-AddSmart)
	imap <C-j>ii <Plug>(JavaComplete-Imports-Add)
	nmap <leader>jM <Plug>(JavaComplete-Generate-AbstractMethods)
	imap <C-j>jM <Plug>(JavaComplete-Generate-AbstractMethods)
	nmap <leader>jA <Plug>(JavaComplete-Generate-Accessors)
	nmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
	nmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
	nmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
	nmap <leader>jts <Plug>(JavaComplete-Generate-ToString)
	nmap <leader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
	nmap <leader>jc <Plug>(JavaComplete-Generate-Constructor)
	nmap <leader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)
	imap <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
	imap <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
	imap <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)
	vmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
	vmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
	vmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
	nmap <silent> <buffer> <leader>jn <Plug>(JavaComplete-Generate-NewClass)
	nmap <silent> <buffer> <leader>jN <Plug>(JavaComplete-Generate-ClassInFile)

call plug#end()

lua require'colorizer'.setup()
" lua require('neoscroll').setup()

" call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
"     \ 'name': 'neosnippet',
"     \ 'allowlist': ['*'],
"     \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
"     \ }))
" 
" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#emoji#get_source_options({
"     \ 'name': 'emoji',
"     \ 'allowlist': ['*'],
"     \ 'completor': function('asyncomplete#sources#emoji#completor'),
"     \ }))
" 
" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
"     \ 'name': 'file',
"     \ 'allowlist': ['*'],
"     \ 'priority': 10,
"     \ 'completor': function('asyncomplete#sources#file#completor')
"     \ }))

function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

function SetLSPShortcuts()
	nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
	nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
	nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
	nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
	nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
	nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
	nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
	nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
	nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
	nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
	autocmd!
	autocmd FileType cpp,c,rust,javascript,typescript,kotlin,java call SetLSPShortcuts()
augroup END

colorscheme monokai
highlight Normal	 ctermbg=NONE guibg=NONE
highlight LineNr	 ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <F5> :buffers<CR>:buffer<Space>
