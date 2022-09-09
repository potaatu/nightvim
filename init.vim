
" /** ----- ##### GENERAL ###### 
set nowrap
set number

set mouse=a

set confirm
set smartcase
set noshowcmd
set noshowmode
set noswapfile
set laststatus=3
set termguicolors

set tabstop=2
set shiftwidth=2

set fillchars=eob:\ 

set foldmethod=marker
set foldmarker=/\*\*,\*\*/
" **/

" /** ----- ##### MAPPINGS #####
noremap <F2> :Lexplore<CR>

noremap <F3> :lua MiniStarter.toggle()<CR>

noremap <A-h> :bp<CR>
noremap <A-l> :bn<CR>
noremap <A-k> :bd<CR>
" **/

" /** ---- ##### PlUGINS ######
" /** ---------> TOKYONIGHT  
function Tokyonight()

" Initialization: {{{
highlight clear
if exists('syntax_on')
  syntax reset
endif

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2
let s:tmux = executable('tmux') && $TMUX !=# ''

let g:colors_name = 'tokyonight'
" }}}
" Configuration: {{{
let s:configuration = {}
let s:configuration.style = get(g:, 'tokyonight_style', 'night')
let s:configuration.transparent_background = get(g:, 'tokyonight_transparent_background', 0)
let s:configuration.menu_selection_background = get(g:, 'tokyonight_menu_selection_background', 'green')
let s:configuration.disable_italic_comment = get(g:, 'tokyonight_disable_italic_comment', 0)
let s:configuration.enable_italic = get(g:, 'tokyonight_enable_italic', 0)
let s:configuration.cursor = get(g:, 'tokyonight_cursor', 'auto')
let s:configuration.current_word = get(g:, 'tokyonight_current_word', get(g:, 'tokyonight_transparent_background', 0) == 0 ? 'grey background' : 'bold')
" }}}
" Palette: {{{
"
if s:configuration.style ==# 'night'
  let s:palette = {
        \ 'black':      ['#06080a',   '237',  'DarkGrey'],
        \ 'bg0':        ['#1a1b26',   '235',  'Black'],
        \ 'bg1':        ['#232433',   '236',  'DarkGrey'],
        \ 'bg2':        ['#2a2b3d',   '236',  'DarkGrey'],
        \ 'bg3':        ['#32344a',   '237',  'DarkGrey'],
        \ 'bg4':        ['#3b3d57',   '237',  'Grey'],
        \ 'bg_red':     ['#ff7a93',   '203',  'Red'],
        \ 'diff_red':   ['#803d49',   '52',   'DarkRed'],
        \ 'bg_green':   ['#b9f27c',   '107',  'Green'],
        \ 'diff_green': ['#618041',   '22',   'DarkGreen'],
        \ 'bg_blue':    ['#7da6ff',   '110',  'Blue'],
        \ 'diff_blue':  ['#3e5380',   '17',   'DarkBlue'],
        \ 'fg':         ['#a9b1d6',   '250',  'White'],
        \ 'red':        ['#F7768E',   '203',  'Red'],
        \ 'orange':     ['#FF9E64',   '215',  'Orange'],
        \ 'yellow':     ['#E0AF68',   '179',  'Yellow'],
        \ 'green':      ['#9ECE6A',   '107',  'Green'],
        \ 'blue':       ['#7AA2F7',   '110',  'Blue'],
        \ 'purple':     ['#ad8ee6',   '176',  'Magenta'],
        \ 'grey':       ['#444B6A',   '246',  'LightGrey'],
        \ 'none':       ['NONE',      'NONE', 'NONE']
        \ }
elseif s:configuration.style ==# 'storm'
  let s:palette = {
        \ 'black':      ['#06080a',   '237',  'DarkGrey'],
        \ 'bg0':        ['#24283b',   '235',  'Black'],
        \ 'bg1':        ['#282d42',   '236',  'DarkGrey'],
        \ 'bg2':        ['#2f344d',   '236',  'DarkGrey'],
        \ 'bg3':        ['#333954',   '237',  'DarkGrey'],
        \ 'bg4':        ['#3a405e',   '237',  'Grey'],
        \ 'bg_red':     ['#ff7a93',   '203',  'Red'],
        \ 'diff_red':   ['#803d49',   '52',   'DarkRed'],
        \ 'bg_green':   ['#b9f27c',   '107',  'Green'],
        \ 'diff_green': ['#618041',   '22',   'DarkGreen'],
        \ 'bg_blue':    ['#7da6ff',   '110',  'Blue'],
        \ 'diff_blue':  ['#3e5380',   '17',   'DarkBlue'],
        \ 'fg':         ['#a9b1d6',   '250',  'White'],
        \ 'red':        ['#F7768E',   '203',  'Red'],
        \ 'orange':     ['#FF9E64',   '215',  'Orange'],
        \ 'yellow':     ['#E0AF68',   '179',  'Yellow'],
        \ 'green':      ['#9ECE6A',   '107',  'Green'],
        \ 'blue':       ['#7AA2F7',   '110',  'Blue'],
        \ 'purple':     ['#ad8ee6',   '176',  'Magenta'],
        \ 'grey':       ['#444B6A',   '246',  'LightGrey'],
        \ 'none':       ['NONE',      'NONE', 'NONE']
        \ }
endif

" }}}
" Function: {{{
" call s:HL(group, foreground, background)
" call s:HL(group, foreground, background, gui, guisp)
"
" E.g.:
" call s:HL('Normal', s:palette.fg, s:palette.bg0)

if (has('termguicolors') && &termguicolors) || has('gui_running')  " guifg guibg gui cterm guisp
  function! s:HL(group, fg, bg, ...)
    let hl_string = [
          \ 'highlight', a:group,
          \ 'guifg=' . a:fg[0],
          \ 'guibg=' . a:bg[0],
          \ ]
    if a:0 >= 1
      if a:1 ==# 'undercurl'
        if !s:tmux
          call add(hl_string, 'gui=undercurl')
        else
          call add(hl_string, 'gui=underline')
        endif
        call add(hl_string, 'cterm=underline')
      else
        call add(hl_string, 'gui=' . a:1)
        call add(hl_string, 'cterm=' . a:1)
      endif
    else
      call add(hl_string, 'gui=NONE')
      call add(hl_string, 'cterm=NONE')
    endif
    if a:0 >= 2
      call add(hl_string, 'guisp=' . a:2[0])
    endif
    execute join(hl_string, ' ')
  endfunction
elseif s:t_Co >= 256  " ctermfg ctermbg cterm
  function! s:HL(group, fg, bg, ...)
    let hl_string = [
          \ 'highlight', a:group,
          \ 'ctermfg=' . a:fg[1],
          \ 'ctermbg=' . a:bg[1],
          \ ]
    if a:0 >= 1
      if a:1 ==# 'undercurl'
        call add(hl_string, 'cterm=underline')
      else
        call add(hl_string, 'cterm=' . a:1)
      endif
    else
      call add(hl_string, 'cterm=NONE')
    endif
    execute join(hl_string, ' ')
  endfunction
else  " ctermfg ctermbg cterm
  function! s:HL(group, fg, bg, ...)
    let hl_string = [
          \ 'highlight', a:group,
          \ 'ctermfg=' . a:fg[2],
          \ 'ctermbg=' . a:bg[2],
          \ ]
    if a:0 >= 1
      if a:1 ==# 'undercurl'
        call add(hl_string, 'cterm=underline')
      else
        call add(hl_string, 'cterm=' . a:1)
      endif
    else
      call add(hl_string, 'cterm=NONE')
    endif
    execute join(hl_string, ' ')
  endfunction
endif
" }}}

" Common Highlight Groups: {{{
" UI: {{{
if s:configuration.transparent_background
  call s:HL('Normal', s:palette.fg, s:palette.none)
  call s:HL('Terminal', s:palette.fg, s:palette.none)
  call s:HL('EndOfBuffer', s:palette.bg0, s:palette.none)
  call s:HL('FoldColumn', s:palette.grey, s:palette.none)
  call s:HL('Folded', s:palette.grey, s:palette.none)
  call s:HL('SignColumn', s:palette.fg, s:palette.none)
  call s:HL('ToolbarLine', s:palette.fg, s:palette.none)
else
  call s:HL('Normal', s:palette.fg, s:palette.bg0)
  call s:HL('Terminal', s:palette.fg, s:palette.bg0)
  call s:HL('EndOfBuffer', s:palette.bg0, s:palette.bg0)
  call s:HL('FoldColumn', s:palette.grey, s:palette.bg1)
  call s:HL('Folded', s:palette.grey, s:palette.bg1)
  call s:HL('SignColumn', s:palette.fg, s:palette.bg1)
  call s:HL('ToolbarLine', s:palette.fg, s:palette.bg2)
endif
call s:HL('ColorColumn', s:palette.none, s:palette.bg1)
call s:HL('Conceal', s:palette.grey, s:palette.none)
if s:configuration.cursor ==# 'auto'
  call s:HL('Cursor', s:palette.none, s:palette.none, 'reverse')
elseif s:configuration.cursor ==# 'red'
  call s:HL('Cursor', s:palette.bg0, s:palette.red)
elseif s:configuration.cursor ==# 'green'
  call s:HL('Cursor', s:palette.bg0, s:palette.green)
elseif s:configuration.cursor ==# 'blue'
  call s:HL('Cursor', s:palette.bg0, s:palette.blue)
endif
highlight! link vCursor Cursor
highlight! link iCursor Cursor
highlight! link lCursor Cursor
highlight! link CursorIM Cursor
call s:HL('CursorColumn', s:palette.none, s:palette.bg1)
call s:HL('CursorLine', s:palette.none, s:palette.bg1)
call s:HL('LineNr', s:palette.grey, s:palette.none)
if &relativenumber == 1 && &cursorline == 0
  call s:HL('CursorLineNr', s:palette.fg, s:palette.none)
else
  call s:HL('CursorLineNr', s:palette.fg, s:palette.bg1)
endif
call s:HL('DiffAdd', s:palette.none, s:palette.diff_green)
call s:HL('DiffChange', s:palette.none, s:palette.diff_blue)
call s:HL('DiffDelete', s:palette.none, s:palette.diff_red)
call s:HL('DiffText', s:palette.none, s:palette.none, 'reverse')
call s:HL('Directory', s:palette.green, s:palette.none)
call s:HL('ErrorMsg', s:palette.red, s:palette.none, 'bold')
call s:HL('WarningMsg', s:palette.red, s:palette.none, 'bold')
call s:HL('ModeMsg', s:palette.fg, s:palette.none, 'bold')
call s:HL('MoreMsg', s:palette.green, s:palette.none, 'bold')
call s:HL('IncSearch', s:palette.bg0, s:palette.bg_red)
call s:HL('Search', s:palette.bg0, s:palette.bg_green)
call s:HL('MatchParen', s:palette.none, s:palette.bg4)
call s:HL('NonText', s:palette.bg4, s:palette.none)
call s:HL('Whitespace', s:palette.bg4, s:palette.none)
call s:HL('SpecialKey', s:palette.bg4, s:palette.none)
call s:HL('Pmenu', s:palette.fg, s:palette.bg2)
call s:HL('PmenuSbar', s:palette.none, s:palette.bg2)
if s:configuration.menu_selection_background ==# 'blue'
  call s:HL('PmenuSel', s:palette.bg0, s:palette.bg_blue)
  call s:HL('WildMenu', s:palette.bg0, s:palette.bg_blue)
elseif s:configuration.menu_selection_background ==# 'green'
  call s:HL('PmenuSel', s:palette.bg0, s:palette.bg_green)
  call s:HL('WildMenu', s:palette.bg0, s:palette.bg_green)
elseif s:configuration.menu_selection_background ==# 'red'
  call s:HL('PmenuSel', s:palette.bg0, s:palette.bg_red)
  call s:HL('WildMenu', s:palette.bg0, s:palette.bg_red)
endif
call s:HL('PmenuThumb', s:palette.none, s:palette.grey)
call s:HL('Question', s:palette.yellow, s:palette.none)
call s:HL('SpellBad', s:palette.red, s:palette.none, 'undercurl', s:palette.red)
call s:HL('SpellCap', s:palette.yellow, s:palette.none, 'undercurl', s:palette.yellow)
call s:HL('SpellLocal', s:palette.blue, s:palette.none, 'undercurl', s:palette.blue)
call s:HL('SpellRare', s:palette.purple, s:palette.none, 'undercurl', s:palette.purple)
call s:HL('ModifiedTab', s:palette.bg0, s:palette.bg_green, 'bold')
call s:HL('StatusLine', s:palette.fg, s:palette.bg3)
call s:HL('StatusLineTerm', s:palette.fg, s:palette.bg3)
call s:HL('StatusLineNC', s:palette.grey, s:palette.bg1)
call s:HL('StatusLineTermNC', s:palette.grey, s:palette.bg1)
call s:HL('TabLine', s:palette.fg, s:palette.bg4)
call s:HL('TabLineFill', s:palette.grey, s:palette.bg1)
call s:HL('TabLineSel', s:palette.bg0, s:palette.bg_blue, 'bold')
call s:HL('VertSplit', s:palette.black, s:palette.none)
call s:HL('Visual', s:palette.none, s:palette.bg3)
call s:HL('VisualNOS', s:palette.none, s:palette.bg3, 'underline')
call s:HL('QuickFixLine', s:palette.blue, s:palette.none, 'bold')
call s:HL('Debug', s:palette.yellow, s:palette.none)
call s:HL('debugPC', s:palette.bg0, s:palette.green)
call s:HL('debugBreakpoint', s:palette.bg0, s:palette.red)
call s:HL('ToolbarButton', s:palette.bg0, s:palette.bg_blue)
if has('nvim')
  highlight! link healthError Red
  highlight! link healthSuccess Green
  highlight! link healthWarning Yellow
  highlight! link LspDiagnosticsError Grey
  highlight! link LspDiagnosticsWarning Grey
  highlight! link LspDiagnosticsInformation Grey
  highlight! link LspDiagnosticsHint Grey
  highlight! link LspReferenceText CocHighlightText
  highlight! link LspReferenceRead CocHighlightText
  highlight! link LspReferenceWrite CocHighlightText
endif
" 
" }}}
" Syntax: {{{
if s:configuration.enable_italic
  call s:HL('Type', s:palette.blue, s:palette.none, 'italic')
  call s:HL('Structure', s:palette.blue, s:palette.none, 'italic')
  call s:HL('StorageClass', s:palette.blue, s:palette.none, 'italic')
  call s:HL('Identifier', s:palette.orange, s:palette.none, 'italic')
  call s:HL('Constant', s:palette.orange, s:palette.none, 'italic')
else
  call s:HL('Type', s:palette.blue, s:palette.none)
  call s:HL('Structure', s:palette.blue, s:palette.none)
  call s:HL('StorageClass', s:palette.blue, s:palette.none)
  call s:HL('Identifier', s:palette.orange, s:palette.none)
  call s:HL('Constant', s:palette.orange, s:palette.none)
endif
call s:HL('PreProc', s:palette.red, s:palette.none)
call s:HL('PreCondit', s:palette.red, s:palette.none)
call s:HL('Include', s:palette.red, s:palette.none)
call s:HL('Keyword', s:palette.red, s:palette.none)
call s:HL('Define', s:palette.red, s:palette.none)
call s:HL('Typedef', s:palette.red, s:palette.none)
call s:HL('Exception', s:palette.red, s:palette.none)
call s:HL('Conditional', s:palette.red, s:palette.none)
call s:HL('Repeat', s:palette.red, s:palette.none)
call s:HL('Statement', s:palette.red, s:palette.none)
call s:HL('Macro', s:palette.purple, s:palette.none)
call s:HL('Error', s:palette.red, s:palette.none)
call s:HL('Label', s:palette.purple, s:palette.none)
call s:HL('Special', s:palette.purple, s:palette.none)
call s:HL('SpecialChar', s:palette.purple, s:palette.none)
call s:HL('Boolean', s:palette.purple, s:palette.none)
call s:HL('String', s:palette.yellow, s:palette.none)
call s:HL('Character', s:palette.yellow, s:palette.none)
call s:HL('Number', s:palette.purple, s:palette.none)
call s:HL('Float', s:palette.purple, s:palette.none)
call s:HL('Function', s:palette.green, s:palette.none)
call s:HL('Operator', s:palette.red, s:palette.none)
call s:HL('Title', s:palette.red, s:palette.none, 'bold')
call s:HL('TitleBlue', s:palette.blue, s:palette.none, 'bold')
call s:HL('Tag', s:palette.orange, s:palette.none)
call s:HL('Delimiter', s:palette.fg, s:palette.none)
if s:configuration.disable_italic_comment
  call s:HL('Comment', s:palette.grey, s:palette.none)
  call s:HL('SpecialComment', s:palette.grey, s:palette.none)
  call s:HL('Todo', s:palette.blue, s:palette.none)
else
  call s:HL('Comment', s:palette.grey, s:palette.none, 'italic')
  call s:HL('SpecialComment', s:palette.grey, s:palette.none, 'italic')
  call s:HL('Todo', s:palette.blue, s:palette.none, 'italic')
endif
call s:HL('Ignore', s:palette.grey, s:palette.none)
call s:HL('Underlined', s:palette.none, s:palette.none, 'underline')
" }}}
" Predefined Highlight Groups: {{{
call s:HL('Fg', s:palette.fg, s:palette.none)
call s:HL('Grey', s:palette.grey, s:palette.none)
call s:HL('Red', s:palette.red, s:palette.none)
call s:HL('Orange', s:palette.orange, s:palette.none)
call s:HL('Yellow', s:palette.yellow, s:palette.none)
call s:HL('Green', s:palette.green, s:palette.none)
call s:HL('Blue', s:palette.blue, s:palette.none)
call s:HL('Purple', s:palette.purple, s:palette.none)
if s:configuration.enable_italic
  call s:HL('RedItalic', s:palette.red, s:palette.none, 'italic')
  call s:HL('BlueItalic', s:palette.blue, s:palette.none, 'italic')
  call s:HL('OrangeItalic', s:palette.orange, s:palette.none, 'italic')
else
  call s:HL('RedItalic', s:palette.red, s:palette.none)
  call s:HL('BlueItalic', s:palette.blue, s:palette.none)
  call s:HL('OrangeItalic', s:palette.orange, s:palette.none)
endif
" }}}
" 
" }}}
" Extended File Types: {{{
" Markdown: {{{
" builtin: {{{
call s:HL('markdownH1', s:palette.red, s:palette.none, 'bold')
call s:HL('markdownH2', s:palette.orange, s:palette.none, 'bold')
call s:HL('markdownH3', s:palette.yellow, s:palette.none, 'bold')
call s:HL('markdownH4', s:palette.green, s:palette.none, 'bold')
call s:HL('markdownH5', s:palette.blue, s:palette.none, 'bold')
call s:HL('markdownH6', s:palette.purple, s:palette.none, 'bold')
call s:HL('markdownUrl', s:palette.blue, s:palette.none, 'underline')
call s:HL('markdownItalic', s:palette.none, s:palette.none, 'italic')
call s:HL('markdownBold', s:palette.none, s:palette.none, 'bold')
call s:HL('markdownItalicDelimiter', s:palette.grey, s:palette.none, 'italic')
highlight! link markdownCode Green
highlight! link markdownCodeBlock Green
highlight! link markdownCodeDelimiter Green
highlight! link markdownBlockquote Grey
highlight! link markdownListMarker Red
highlight! link markdownOrderedListMarker Red
highlight! link markdownRule Purple
highlight! link markdownHeadingRule Grey
highlight! link markdownUrlDelimiter Grey
highlight! link markdownLinkDelimiter Grey
highlight! link markdownLinkTextDelimiter Grey
highlight! link markdownHeadingDelimiter Grey
highlight! link markdownLinkText Red
highlight! link markdownUrlTitleDelimiter Green
highlight! link markdownIdDeclaration markdownLinkText
highlight! link markdownBoldDelimiter Grey
highlight! link markdownId Yellow
" }}}
" vim-markdown: https://github.com/gabrielelana/vim-markdown{{{
call s:HL('mkdURL', s:palette.blue, s:palette.none, 'underline')
call s:HL('mkdInlineURL', s:palette.blue, s:palette.none, 'underline')
call s:HL('mkdItalic', s:palette.grey, s:palette.none, 'italic')
highlight! link mkdCodeDelimiter Green
highlight! link mkdBold Grey
highlight! link mkdLink Red
highlight! link mkdHeading Grey
highlight! link mkdListItem Red
highlight! link mkdRule Purple
highlight! link mkdDelimiter Grey
highlight! link mkdId Yellow
" }}}
" }}}
" ReStructuredText: {{{
" builtin: https://github.com/marshallward/vim-restructuredtext{{{
call s:HL('rstStandaloneHyperlink', s:palette.purple, s:palette.none, 'underline')
call s:HL('rstEmphasis', s:palette.none, s:palette.none, 'italic')
call s:HL('rstStrongEmphasis', s:palette.none, s:palette.none, 'bold')
call s:HL('rstStandaloneHyperlink', s:palette.blue, s:palette.none, 'underline')
call s:HL('rstHyperlinkTarget', s:palette.blue, s:palette.none, 'underline')
highlight! link rstSubstitutionReference Blue
highlight! link rstInterpretedTextOrHyperlinkReference Green
highlight! link rstTableLines Grey
highlight! link rstInlineLiteral Green
highlight! link rstLiteralBlock Green
highlight! link rstQuotedLiteralBlock Green
" }}}
" }}}
" LaTex: {{{
" builtin: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_TEX{{{
highlight! link texStatement BlueItalic
highlight! link texOnlyMath Grey
highlight! link texDefName Yellow
highlight! link texNewCmd Orange
highlight! link texCmdName Blue
highlight! link texBeginEnd Red
highlight! link texBeginEndName Green
highlight! link texDocType RedItalic
highlight! link texDocTypeArgs Orange
highlight! link texInputFile Green
" }}}
" }}}
" Html: {{{
" builtin: https://notabug.org/jorgesumle/vim-html-syntax{{{
call s:HL('htmlH1', s:palette.red, s:palette.none, 'bold')
call s:HL('htmlH2', s:palette.orange, s:palette.none, 'bold')
call s:HL('htmlH3', s:palette.yellow, s:palette.none, 'bold')
call s:HL('htmlH4', s:palette.green, s:palette.none, 'bold')
call s:HL('htmlH5', s:palette.blue, s:palette.none, 'bold')
call s:HL('htmlH6', s:palette.purple, s:palette.none, 'bold')
call s:HL('htmlLink', s:palette.none, s:palette.none, 'underline')
call s:HL('htmlBold', s:palette.none, s:palette.none, 'bold')
call s:HL('htmlBoldUnderline', s:palette.none, s:palette.none, 'bold,underline')
call s:HL('htmlBoldItalic', s:palette.none, s:palette.none, 'bold,italic')
call s:HL('htmlBoldUnderlineItalic', s:palette.none, s:palette.none, 'bold,underline,italic')
call s:HL('htmlUnderline', s:palette.none, s:palette.none, 'underline')
call s:HL('htmlUnderlineItalic', s:palette.none, s:palette.none, 'underline,italic')
call s:HL('htmlItalic', s:palette.none, s:palette.none, 'italic')
highlight! link htmlTag Green
highlight! link htmlEndTag Blue
highlight! link htmlTagN RedItalic
highlight! link htmlTagName RedItalic
highlight! link htmlArg Blue
highlight! link htmlScriptTag Purple
highlight! link htmlSpecialTagName RedItalic
highlight! link htmlString Green
" }}}
" }}}
" Xml: {{{
" builtin: https://github.com/chrisbra/vim-xml-ftplugin{{{
highlight! link xmlTag Green
highlight! link xmlEndTag Blue
highlight! link xmlTagName RedItalic
highlight! link xmlEqual Orange
highlight! link xmlAttrib Blue
highlight! link xmlEntity Red
highlight! link xmlEntityPunct Red
highlight! link xmlDocTypeDecl Grey
highlight! link xmlDocTypeKeyword RedItalic
highlight! link xmlCdataStart Grey
highlight! link xmlCdataCdata Purple
highlight! link xmlString Green
" }}}
" }}}
" CSS: {{{
" builtin: https://github.com/JulesWang/css.vim{{{
highlight! link cssStringQ Green
highlight! link cssStringQQ Green
highlight! link cssAttrComma Grey
highlight! link cssBraces Grey
highlight! link cssTagName Purple
highlight! link cssClassNameDot Orange
highlight! link cssClassName Red
highlight! link cssFunctionName Orange
highlight! link cssAttr Green
highlight! link cssCommonAttr Green
highlight! link cssProp Blue
highlight! link cssPseudoClassId Yellow
highlight! link cssPseudoClassFn Green
highlight! link cssPseudoClass Yellow
highlight! link cssImportant Red
highlight! link cssSelectorOp Orange
highlight! link cssSelectorOp2 Orange
highlight! link cssColor Green
highlight! link cssUnitDecorators Orange
highlight! link cssValueLength Green
highlight! link cssValueInteger Green
highlight! link cssValueNumber Green
highlight! link cssValueAngle Green
highlight! link cssValueTime Green
highlight! link cssValueFrequency Green
highlight! link cssVendor Grey
highlight! link cssNoise Grey
" }}}
" }}}
" SASS: {{{
" scss-syntax: https://github.com/cakebaker/scss-syntax.vim{{{
highlight! link scssMixinName Orange
highlight! link scssSelectorChar Orange
highlight! link scssSelectorName Red
highlight! link scssInterpolationDelimiter Yellow
highlight! link scssVariableValue Green
highlight! link scssNull Purple
highlight! link scssBoolean Purple
highlight! link scssVariableAssignment Grey
highlight! link scssAttribute Green
highlight! link scssFunctionName Orange
highlight! link scssVariable Fg
highlight! link scssAmpersand Purple
" }}}
" }}}
" LESS: {{{
" vim-less: https://github.com/groenewege/vim-less{{{
highlight! link lessMixinChar Grey
highlight! link lessClass Red
highlight! link lessFunction Orange
" }}}
" }}}
" JavaScript: {{{
" builtin: http://www.fleiner.com/vim/syntax/javascript.vim{{{
highlight! link javaScriptNull OrangeItalic
highlight! link javaScriptIdentifier BlueItalic
highlight! link javaScriptParens Fg
highlight! link javaScriptBraces Fg
highlight! link javaScriptNumber Purple
highlight! link javaScriptLabel Red
highlight! link javaScriptGlobal BlueItalic
highlight! link javaScriptMessage BlueItalic
" }}}
" vim-javascript: https://github.com/pangloss/vim-javascript{{{
highlight! link jsNoise Fg
highlight! link Noise Fg
highlight! link jsParens Fg
highlight! link jsBrackets Fg
highlight! link jsObjectBraces Fg
highlight! link jsThis BlueItalic
highlight! link jsUndefined OrangeItalic
highlight! link jsNull OrangeItalic
highlight! link jsNan OrangeItalic
highlight! link jsSuper OrangeItalic
highlight! link jsPrototype OrangeItalic
highlight! link jsFunction Red
highlight! link jsGlobalNodeObjects BlueItalic
highlight! link jsGlobalObjects BlueItalic
highlight! link jsArrowFunction Red
highlight! link jsArrowFuncArgs Fg
highlight! link jsFuncArgs Fg
highlight! link jsObjectProp Fg
highlight! link jsVariableDef Fg
highlight! link jsObjectKey Fg
highlight! link jsParen Fg
highlight! link jsParenIfElse Fg
highlight! link jsParenRepeat Fg
highlight! link jsParenSwitch Fg
highlight! link jsParenCatch Fg
highlight! link jsBracket Fg
highlight! link jsObjectValue Fg
highlight! link jsDestructuringBlock Fg
highlight! link jsBlockLabel Purple
highlight! link jsFunctionKey Green
highlight! link jsClassDefinition BlueItalic
highlight! link jsDot Orange
highlight! link jsSpreadExpression Purple
highlight! link jsSpreadOperator Green
highlight! link jsModuleKeyword BlueItalic
highlight! link jsTemplateExpression Purple
highlight! link jsTemplateBraces Purple
highlight! link jsClassMethodType BlueItalic
highlight! link jsExceptions BlueItalic
" }}}
" yajs: https://github.com/othree/yajs.vim{{{
highlight! link javascriptOpSymbol Red
highlight! link javascriptOpSymbols Red
highlight! link javascriptIdentifierName Fg
highlight! link javascriptVariable BlueItalic
highlight! link javascriptObjectLabel Fg
highlight! link javascriptPropertyNameString Fg
highlight! link javascriptFuncArg Fg
highlight! link javascriptObjectLiteral Green
highlight! link javascriptIdentifier OrangeItalic
highlight! link javascriptArrowFunc Red
highlight! link javascriptTemplate Purple
highlight! link javascriptTemplateSubstitution Purple
highlight! link javascriptTemplateSB Purple
highlight! link javascriptNodeGlobal BlueItalic
highlight! link javascriptDocTags RedItalic
highlight! link javascriptDocNotation Blue
highlight! link javascriptClassSuper OrangeItalic
highlight! link javascriptClassName BlueItalic
highlight! link javascriptClassSuperName BlueItalic
highlight! link javascriptOperator Red
highlight! link javascriptBrackets Fg
highlight! link javascriptBraces Fg
highlight! link javascriptLabel Purple
highlight! link javascriptEndColons Grey
highlight! link javascriptObjectLabelColon Grey
highlight! link javascriptDotNotation Orange
highlight! link javascriptGlobalArrayDot Orange
highlight! link javascriptGlobalBigIntDot Orange
highlight! link javascriptGlobalDateDot Orange
highlight! link javascriptGlobalJSONDot Orange
highlight! link javascriptGlobalMathDot Orange
highlight! link javascriptGlobalNumberDot Orange
highlight! link javascriptGlobalObjectDot Orange
highlight! link javascriptGlobalPromiseDot Orange
highlight! link javascriptGlobalRegExpDot Orange
highlight! link javascriptGlobalStringDot Orange
highlight! link javascriptGlobalSymbolDot Orange
highlight! link javascriptGlobalURLDot Orange
highlight! link javascriptMethod Green
highlight! link javascriptMethodName Green
highlight! link javascriptObjectMethodName Green
highlight! link javascriptGlobalMethod Green
highlight! link javascriptDOMStorageMethod Green
highlight! link javascriptFileMethod Green
highlight! link javascriptFileReaderMethod Green
highlight! link javascriptFileListMethod Green
highlight! link javascriptBlobMethod Green
highlight! link javascriptURLStaticMethod Green
highlight! link javascriptNumberStaticMethod Green
highlight! link javascriptNumberMethod Green
highlight! link javascriptDOMNodeMethod Green
highlight! link javascriptES6BigIntStaticMethod Green
highlight! link javascriptBOMWindowMethod Green
highlight! link javascriptHeadersMethod Green
highlight! link javascriptRequestMethod Green
highlight! link javascriptResponseMethod Green
highlight! link javascriptES6SetMethod Green
highlight! link javascriptReflectMethod Green
highlight! link javascriptPaymentMethod Green
highlight! link javascriptPaymentResponseMethod Green
highlight! link javascriptTypedArrayStaticMethod Green
highlight! link javascriptGeolocationMethod Green
highlight! link javascriptES6MapMethod Green
highlight! link javascriptServiceWorkerMethod Green
highlight! link javascriptCacheMethod Green
highlight! link javascriptFunctionMethod Green
highlight! link javascriptXHRMethod Green
highlight! link javascriptBOMNavigatorMethod Green
highlight! link javascriptServiceWorkerMethod Green
highlight! link javascriptDOMEventTargetMethod Green
highlight! link javascriptDOMEventMethod Green
highlight! link javascriptIntlMethod Green
highlight! link javascriptDOMDocMethod Green
highlight! link javascriptStringStaticMethod Green
highlight! link javascriptStringMethod Green
highlight! link javascriptSymbolStaticMethod Green
highlight! link javascriptRegExpMethod Green
highlight! link javascriptObjectStaticMethod Green
highlight! link javascriptObjectMethod Green
highlight! link javascriptBOMLocationMethod Green
highlight! link javascriptJSONStaticMethod Green
highlight! link javascriptGeneratorMethod Green
highlight! link javascriptEncodingMethod Green
highlight! link javascriptPromiseStaticMethod Green
highlight! link javascriptPromiseMethod Green
highlight! link javascriptBOMHistoryMethod Green
highlight! link javascriptDOMFormMethod Green
highlight! link javascriptClipboardMethod Green
highlight! link javascriptTypedArrayStaticMethod Green
highlight! link javascriptBroadcastMethod Green
highlight! link javascriptDateStaticMethod Green
highlight! link javascriptDateMethod Green
highlight! link javascriptConsoleMethod Green
highlight! link javascriptArrayStaticMethod Green
highlight! link javascriptArrayMethod Green
highlight! link javascriptMathStaticMethod Green
highlight! link javascriptSubtleCryptoMethod Green
highlight! link javascriptCryptoMethod Green
highlight! link javascriptProp Fg
highlight! link javascriptBOMWindowProp Fg
highlight! link javascriptDOMStorageProp Fg
highlight! link javascriptFileReaderProp Fg
highlight! link javascriptURLUtilsProp Fg
highlight! link javascriptNumberStaticProp Fg
highlight! link javascriptDOMNodeProp Fg
highlight! link javascriptRequestProp Fg
highlight! link javascriptResponseProp Fg
highlight! link javascriptES6SetProp Fg
highlight! link javascriptPaymentProp Fg
highlight! link javascriptPaymentResponseProp Fg
highlight! link javascriptPaymentAddressProp Fg
highlight! link javascriptPaymentShippingOptionProp Fg
highlight! link javascriptTypedArrayStaticProp Fg
highlight! link javascriptServiceWorkerProp Fg
highlight! link javascriptES6MapProp Fg
highlight! link javascriptRegExpStaticProp Fg
highlight! link javascriptRegExpProp Fg
highlight! link javascriptXHRProp Fg
highlight! link javascriptBOMNavigatorProp Green
highlight! link javascriptDOMEventProp Fg
highlight! link javascriptBOMNetworkProp Fg
highlight! link javascriptDOMDocProp Fg
highlight! link javascriptSymbolStaticProp Fg
highlight! link javascriptSymbolProp Fg
highlight! link javascriptBOMLocationProp Fg
highlight! link javascriptEncodingProp Fg
highlight! link javascriptCryptoProp Fg
highlight! link javascriptBOMHistoryProp Fg
highlight! link javascriptDOMFormProp Fg
highlight! link javascriptDataViewProp Fg
highlight! link javascriptBroadcastProp Fg
highlight! link javascriptMathStaticProp Fg
" }}}
" }}}
" JavaScript React: {{{
" vim-jsx-pretty: https://github.com/maxmellon/vim-jsx-pretty{{{
highlight! link jsxTagName RedItalic
highlight! link jsxOpenPunct Green
highlight! link jsxClosePunct Blue
highlight! link jsxEscapeJs Purple
highlight! link jsxAttrib Blue
" }}}
" }}}
" TypeScript: {{{
" vim-typescript: https://github.com/leafgarland/typescript-vim{{{
highlight! link typescriptStorageClass Red
highlight! link typescriptEndColons Fg
highlight! link typescriptSource BlueItalic
highlight! link typescriptMessage Green
highlight! link typescriptGlobalObjects BlueItalic
highlight! link typescriptInterpolation Purple
highlight! link typescriptInterpolationDelimiter Purple
highlight! link typescriptBraces Fg
highlight! link typescriptParens Fg
" }}}
" yats: https:github.com/HerringtonDarkholme/yats.vim{{{
highlight! link typescriptMethodAccessor Red
highlight! link typescriptVariable Red
highlight! link typescriptVariableDeclaration Fg
highlight! link typescriptTypeReference BlueItalic
highlight! link typescriptBraces Fg
highlight! link typescriptEnumKeyword Red
highlight! link typescriptEnum BlueItalic
highlight! link typescriptIdentifierName Fg
highlight! link typescriptProp Fg
highlight! link typescriptCall Fg
highlight! link typescriptInterfaceName BlueItalic
highlight! link typescriptEndColons Fg
highlight! link typescriptMember Fg
highlight! link typescriptMemberOptionality Red
highlight! link typescriptObjectLabel Fg
highlight! link typescriptDefaultParam Fg
highlight! link typescriptArrowFunc Red
highlight! link typescriptAbstract Red
highlight! link typescriptObjectColon Grey
highlight! link typescriptTypeAnnotation Grey
highlight! link typescriptAssign Red
highlight! link typescriptBinaryOp Red
highlight! link typescriptUnaryOp Red
highlight! link typescriptFuncComma Fg
highlight! link typescriptClassName BlueItalic
highlight! link typescriptClassHeritage BlueItalic
highlight! link typescriptInterfaceHeritage BlueItalic
highlight! link typescriptIdentifier OrangeItalic
highlight! link typescriptGlobal BlueItalic
highlight! link typescriptOperator Red
highlight! link typescriptNodeGlobal BlueItalic
highlight! link typescriptExport Red
highlight! link typescriptImport Red
highlight! link typescriptTypeParameter BlueItalic
highlight! link typescriptReadonlyModifier Red
highlight! link typescriptAccessibilityModifier Red
highlight! link typescriptAmbientDeclaration Red
highlight! link typescriptTemplateSubstitution Purple
highlight! link typescriptTemplateSB Purple
highlight! link typescriptExceptions Red
highlight! link typescriptCastKeyword Red
highlight! link typescriptOptionalMark Red
highlight! link typescriptNull OrangeItalic
highlight! link typescriptMappedIn Red
highlight! link typescriptFuncTypeArrow Red
highlight! link typescriptTernaryOp Red
highlight! link typescriptParenExp Fg
highlight! link typescriptIndexExpr Fg
highlight! link typescriptDotNotation Orange
highlight! link typescriptGlobalNumberDot Orange
highlight! link typescriptGlobalStringDot Orange
highlight! link typescriptGlobalArrayDot Orange
highlight! link typescriptGlobalObjectDot Orange
highlight! link typescriptGlobalSymbolDot Orange
highlight! link typescriptGlobalMathDot Orange
highlight! link typescriptGlobalDateDot Orange
highlight! link typescriptGlobalJSONDot Orange
highlight! link typescriptGlobalRegExpDot Orange
highlight! link typescriptGlobalPromiseDot Orange
highlight! link typescriptGlobalURLDot Orange
highlight! link typescriptGlobalMethod Green
highlight! link typescriptDOMStorageMethod Green
highlight! link typescriptFileMethod Green
highlight! link typescriptFileReaderMethod Green
highlight! link typescriptFileListMethod Green
highlight! link typescriptBlobMethod Green
highlight! link typescriptURLStaticMethod Green
highlight! link typescriptNumberStaticMethod Green
highlight! link typescriptNumberMethod Green
highlight! link typescriptDOMNodeMethod Green
highlight! link typescriptPaymentMethod Green
highlight! link typescriptPaymentResponseMethod Green
highlight! link typescriptHeadersMethod Green
highlight! link typescriptRequestMethod Green
highlight! link typescriptResponseMethod Green
highlight! link typescriptES6SetMethod Green
highlight! link typescriptReflectMethod Green
highlight! link typescriptBOMWindowMethod Green
highlight! link typescriptGeolocationMethod Green
highlight! link typescriptServiceWorkerMethod Green
highlight! link typescriptCacheMethod Green
highlight! link typescriptES6MapMethod Green
highlight! link typescriptFunctionMethod Green
highlight! link typescriptRegExpMethod Green
highlight! link typescriptXHRMethod Green
highlight! link typescriptBOMNavigatorMethod Green
highlight! link typescriptServiceWorkerMethod Green
highlight! link typescriptIntlMethod Green
highlight! link typescriptDOMEventTargetMethod Green
highlight! link typescriptDOMEventMethod Green
highlight! link typescriptDOMDocMethod Green
highlight! link typescriptStringStaticMethod Green
highlight! link typescriptStringMethod Green
highlight! link typescriptSymbolStaticMethod Green
highlight! link typescriptObjectStaticMethod Green
highlight! link typescriptObjectMethod Green
highlight! link typescriptJSONStaticMethod Green
highlight! link typescriptEncodingMethod Green
highlight! link typescriptBOMLocationMethod Green
highlight! link typescriptPromiseStaticMethod Green
highlight! link typescriptPromiseMethod Green
highlight! link typescriptSubtleCryptoMethod Green
highlight! link typescriptCryptoMethod Green
highlight! link typescriptBOMHistoryMethod Green
highlight! link typescriptDOMFormMethod Green
highlight! link typescriptConsoleMethod Green
highlight! link typescriptDateStaticMethod Green
highlight! link typescriptDateMethod Green
highlight! link typescriptArrayStaticMethod Green
highlight! link typescriptArrayMethod Green
highlight! link typescriptMathStaticMethod Green
highlight! link typescriptStringProperty Fg
highlight! link typescriptDOMStorageProp Fg
highlight! link typescriptFileReaderProp Fg
highlight! link typescriptURLUtilsProp Fg
highlight! link typescriptNumberStaticProp Fg
highlight! link typescriptDOMNodeProp Fg
highlight! link typescriptBOMWindowProp Fg
highlight! link typescriptRequestProp Fg
highlight! link typescriptResponseProp Fg
highlight! link typescriptPaymentProp Fg
highlight! link typescriptPaymentResponseProp Fg
highlight! link typescriptPaymentAddressProp Fg
highlight! link typescriptPaymentShippingOptionProp Fg
highlight! link typescriptES6SetProp Fg
highlight! link typescriptServiceWorkerProp Fg
highlight! link typescriptES6MapProp Fg
highlight! link typescriptRegExpStaticProp Fg
highlight! link typescriptRegExpProp Fg
highlight! link typescriptBOMNavigatorProp Green
highlight! link typescriptXHRProp Fg
highlight! link typescriptDOMEventProp Fg
highlight! link typescriptDOMDocProp Fg
highlight! link typescriptBOMNetworkProp Fg
highlight! link typescriptSymbolStaticProp Fg
highlight! link typescriptEncodingProp Fg
highlight! link typescriptBOMLocationProp Fg
highlight! link typescriptCryptoProp Fg
highlight! link typescriptDOMFormProp Fg
highlight! link typescriptBOMHistoryProp Fg
highlight! link typescriptMathStaticProp Fg
" }}}
" }}}
" Dart: {{{
" dart-lang: https://github.com/dart-lang/dart-vim-plugin{{{
highlight! link dartCoreClasses BlueItalic
highlight! link dartTypeName BlueItalic
highlight! link dartInterpolation Purple
highlight! link dartTypeDef Red
highlight! link dartClassDecl Red
highlight! link dartLibrary Red
highlight! link dartMetadata OrangeItalic
" }}}
" }}}
" C/C++: {{{
" vim-cpp-enhanced-highlight: https://github.com/octol/vim-cpp-enhanced-highlight{{{
highlight! link cLabel Red
highlight! link cppSTLnamespace BlueItalic
highlight! link cppSTLtype BlueItalic
highlight! link cppAccess Red
highlight! link cppStructure Red
highlight! link cppSTLios BlueItalic
highlight! link cppSTLiterator BlueItalic
highlight! link cppSTLexception Red
" }}}
" vim-cpp-modern: https://github.com/bfrg/vim-cpp-modern{{{
highlight! link cppSTLVariable BlueItalic
" }}}
" chromatica: https://github.com/arakashic/chromatica.nvim{{{
highlight! link Member OrangeItalic
highlight! link Variable Fg
highlight! link Namespace BlueItalic
highlight! link EnumConstant OrangeItalic
highlight! link chromaticaException Red
highlight! link chromaticaCast Red
highlight! link OperatorOverload Red
highlight! link AccessQual Red
highlight! link Linkage Red
highlight! link AutoType BlueItalic
" }}}
" vim-lsp-cxx-highlight https://github.com/jackguo380/vim-lsp-cxx-highlight{{{
highlight! link LspCxxHlSkippedRegion Grey
highlight! link LspCxxHlSkippedRegionBeginEnd Red
highlight! link LspCxxHlGroupEnumConstant OrangeItalic
highlight! link LspCxxHlGroupNamespace BlueItalic
highlight! link LspCxxHlGroupMemberVariable OrangeItalic
" }}}
" }}}
" ObjectiveC: {{{
" builtin: {{{
highlight! link objcModuleImport Red
highlight! link objcException Red
highlight! link objcProtocolList Fg
highlight! link objcDirective Red
highlight! link objcPropertyAttribute Purple
highlight! link objcHiddenArgument Fg
" }}}
" }}}
" C#: {{{
" builtin: https://github.com/nickspoons/vim-cs{{{
highlight! link csUnspecifiedStatement Red
highlight! link csStorage Red
highlight! link csClass Red
highlight! link csNewType BlueItalic
highlight! link csContextualStatement Red
highlight! link csInterpolationDelimiter Purple
highlight! link csInterpolation Purple
highlight! link csEndColon Fg
" }}}
" }}}
" Python: {{{
" builtin: {{{
highlight! link pythonBuiltin BlueItalic
highlight! link pythonExceptions Red
highlight! link pythonDecoratorName OrangeItalic
" }}}
" python-syntax: https://github.com/vim-python/python-syntax{{{
highlight! link pythonExClass BlueItalic
highlight! link pythonBuiltinType BlueItalic
highlight! link pythonBuiltinObj OrangeItalic
highlight! link pythonDottedName OrangeItalic
highlight! link pythonBuiltinFunc Green
highlight! link pythonFunction Green
highlight! link pythonDecorator OrangeItalic
highlight! link pythonInclude Include
highlight! link pythonImport PreProc
highlight! link pythonOperator Red
highlight! link pythonConditional Red
highlight! link pythonRepeat Red
highlight! link pythonException Red
highlight! link pythonNone OrangeItalic
highlight! link pythonCoding Grey
highlight! link pythonDot Grey
" }}}
" semshi: https://github.com/numirias/semshi{{{
call s:HL('semshiUnresolved', s:palette.orange, s:palette.none, 'undercurl')
highlight! link semshiImported BlueItalic
highlight! link semshiParameter OrangeItalic
highlight! link semshiParameterUnused Grey
highlight! link semshiSelf BlueItalic
highlight! link semshiGlobal Green
highlight! link semshiBuiltin Green
highlight! link semshiAttribute OrangeItalic
highlight! link semshiLocal Red
highlight! link semshiFree Red
highlight! link semshiSelected CocHighlightText
highlight! link semshiErrorSign ALEErrorSign
highlight! link semshiErrorChar ALEErrorSign
" }}}
" }}}
" Lua: {{{
" builtin: {{{
highlight! link luaFunc Green
highlight! link luaFunction Red
highlight! link luaTable Fg
highlight! link luaIn Red
" }}}
" vim-lua: https://github.com/tbastos/vim-lua{{{
highlight! link luaFuncCall Green
highlight! link luaLocal Red
highlight! link luaSpecialValue Green
highlight! link luaBraces Fg
highlight! link luaBuiltIn BlueItalic
highlight! link luaNoise Grey
highlight! link luaLabel Purple
highlight! link luaFuncTable BlueItalic
highlight! link luaFuncArgName Fg
highlight! link luaEllipsis Red
highlight! link luaDocTag Green
" }}}
" }}}
" Java: {{{
" builtin: {{{
highlight! link javaClassDecl Red
highlight! link javaMethodDecl Red
highlight! link javaVarArg Fg
highlight! link javaAnnotation Purple
highlight! link javaUserLabel Purple
highlight! link javaTypedef OrangeItalic
highlight! link javaParen Fg
highlight! link javaParen1 Fg
highlight! link javaParen2 Fg
highlight! link javaParen3 Fg
highlight! link javaParen4 Fg
highlight! link javaParen5 Fg
" }}}
" }}}
" Kotlin: {{{
" kotlin-vim: https://github.com/udalov/kotlin-vim{{{
highlight! link ktSimpleInterpolation Purple
highlight! link ktComplexInterpolation Purple
highlight! link ktComplexInterpolationBrace Purple
highlight! link ktStructure Red
highlight! link ktKeyword OrangeItalic
" }}}
" }}}
" Scala: {{{
" builtin: https://github.com/derekwyatt/vim-scala{{{
highlight! link scalaNameDefinition Fg
highlight! link scalaInterpolationBoundary Purple
highlight! link scalaInterpolation Purple
highlight! link scalaTypeOperator Red
highlight! link scalaOperator Red
highlight! link scalaKeywordModifier Red
" }}}
" }}}
" Go: {{{
" builtin: https://github.com/google/vim-ft-go{{{
highlight! link goDirective Red
highlight! link goConstants OrangeItalic
highlight! link goDeclType Red
" }}}
" polyglot: {{{
highlight! link goPackage Red
highlight! link goImport Red
highlight! link goBuiltins Green
highlight! link goPredefinedIdentifiers OrangeItalic
highlight! link goVar Red
" }}}
" }}}
" Rust: {{{
" builtin: https://github.com/rust-lang/rust.vim{{{
highlight! link rustStructure Red
highlight! link rustIdentifier OrangeItalic
highlight! link rustModPath BlueItalic
highlight! link rustModPathSep Grey
highlight! link rustSelf OrangeItalic
highlight! link rustSuper OrangeItalic
highlight! link rustDeriveTrait Purple
highlight! link rustEnumVariant Purple
highlight! link rustMacroVariable OrangeItalic
highlight! link rustAssert Green
highlight! link rustPanic Green
highlight! link rustPubScopeCrate BlueItalic
highlight! link rustAttribute Purple
" }}}
" }}}
" Swift: {{{
" swift.vim: https://github.com/keith/swift.vim{{{
highlight! link swiftInterpolatedWrapper Purple
highlight! link swiftInterpolatedString Purple
highlight! link swiftProperty Fg
highlight! link swiftTypeDeclaration Red
highlight! link swiftClosureArgument OrangeItalic
highlight! link swiftStructure Red
" }}}
" }}}
" PHP: {{{
" builtin: https://jasonwoof.com/gitweb/?p=vim-syntax.git;a=blob;f=php.vim;hb=HEAD{{{
highlight! link phpVarSelector Fg
highlight! link phpIdentifier Fg
highlight! link phpDefine Green
highlight! link phpStructure Red
highlight! link phpSpecialFunction Green
highlight! link phpInterpSimpleCurly Purple
highlight! link phpComparison Red
highlight! link phpMethodsVar Fg
highlight! link phpInterpVarname Fg
highlight! link phpMemberSelector Red
highlight! link phpLabel Red
" }}}
" php.vim: https://github.com/StanAngeloff/php.vim{{{
highlight! link phpParent Fg
highlight! link phpNowDoc Yellow
highlight! link phpFunction Green
highlight! link phpMethod Green
highlight! link phpClass BlueItalic
highlight! link phpSuperglobals BlueItalic
highlight! link phpNullValue OrangeItalic
" }}}
" }}}
" Ruby: {{{
" builtin: https://github.com/vim-ruby/vim-ruby{{{
highlight! link rubyKeywordAsMethod Green
highlight! link rubyInterpolation Purple
highlight! link rubyInterpolationDelimiter Purple
highlight! link rubyStringDelimiter Yellow
highlight! link rubyBlockParameterList Fg
highlight! link rubyDefine Red
highlight! link rubyModuleName Red
highlight! link rubyAccess Red
highlight! link rubyMacro Red
highlight! link rubySymbol Fg
" }}}
" }}}
" Haskell: {{{
" haskell-vim: https://github.com/neovimhaskell/haskell-vim{{{
highlight! link haskellBrackets Fg
highlight! link haskellIdentifier OrangeItalic
highlight! link haskellDecl Red
highlight! link haskellType BlueItalic
highlight! link haskellDeclKeyword Red
highlight! link haskellWhere Red
highlight! link haskellDeriving Red
highlight! link haskellForeignKeywords Red
" }}}
" }}}
" Perl: {{{
" builtin: https://github.com/vim-perl/vim-perl{{{
highlight! link perlStatementPackage Red
highlight! link perlStatementInclude Red
highlight! link perlStatementStorage Red
highlight! link perlStatementList Red
highlight! link perlMatchStartEnd Red
highlight! link perlVarSimpleMemberName Green
highlight! link perlVarSimpleMember Fg
highlight! link perlMethod Green
highlight! link podVerbatimLine Green
highlight! link podCmdText Yellow
highlight! link perlVarPlain Fg
highlight! link perlVarPlain2 Fg
" }}}
" }}}
" OCaml: {{{
" builtin: https://github.com/rgrinberg/vim-ocaml{{{
highlight! link ocamlArrow Red
highlight! link ocamlEqual Red
highlight! link ocamlOperator Red
highlight! link ocamlKeyChar Red
highlight! link ocamlModPath Green
highlight! link ocamlFullMod Green
highlight! link ocamlModule BlueItalic
highlight! link ocamlConstructor Orange
highlight! link ocamlModParam Fg
highlight! link ocamlModParam1 Fg
highlight! link ocamlAnyVar Fg " aqua
highlight! link ocamlPpxEncl Red
highlight! link ocamlPpxIdentifier Fg
highlight! link ocamlSigEncl Red
highlight! link ocamlModParam1 Fg
" }}}
" }}}
" Erlang: {{{
" builtin: https://github.com/vim-erlang/vim-erlang-runtime{{{
highlight! link erlangAtom Fg
highlight! link erlangVariable Fg
highlight! link erlangLocalFuncRef Green
highlight! link erlangLocalFuncCall Green
highlight! link erlangGlobalFuncRef Green
highlight! link erlangGlobalFuncCall Green
highlight! link erlangAttribute BlueItalic
highlight! link erlangPipe Red
" }}}
" }}}
" Elixir: {{{
" vim-elixir: https://github.com/elixir-editors/vim-elixir{{{
highlight! link elixirStringDelimiter Yellow
highlight! link elixirKeyword Red
highlight! link elixirInterpolation Purple
highlight! link elixirInterpolationDelimiter Purple
highlight! link elixirSelf BlueItalic
highlight! link elixirPseudoVariable OrangeItalic
highlight! link elixirModuleDefine Red
highlight! link elixirBlockDefinition Red
highlight! link elixirDefine Red
highlight! link elixirPrivateDefine Red
highlight! link elixirGuard Red
highlight! link elixirPrivateGuard Red
highlight! link elixirProtocolDefine Red
highlight! link elixirImplDefine Red
highlight! link elixirRecordDefine Red
highlight! link elixirPrivateRecordDefine Red
highlight! link elixirMacroDefine Red
highlight! link elixirPrivateMacroDefine Red
highlight! link elixirDelegateDefine Red
highlight! link elixirOverridableDefine Red
highlight! link elixirExceptionDefine Red
highlight! link elixirCallbackDefine Red
highlight! link elixirStructDefine Red
highlight! link elixirExUnitMacro Red
" }}}
" }}}
" Common Lisp: {{{
" builtin: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_LISP{{{
highlight! link lispAtomMark Purple
highlight! link lispKey Orange
highlight! link lispFunc Green
" }}}
" }}}
" Clojure: {{{
" builtin: https://github.com/guns/vim-clojure-static{{{
highlight! link clojureMacro Red
highlight! link clojureFunc Green
highlight! link clojureConstant OrangeItalic
highlight! link clojureSpecial Red
highlight! link clojureDefine Red
highlight! link clojureKeyword Blue
highlight! link clojureVariable Fg
highlight! link clojureMeta Purple
highlight! link clojureDeref Purple
" }}}
" }}}
" Matlab: {{{
" builtin: {{{
highlight! link matlabSemicolon Fg
highlight! link matlabFunction RedItalic
highlight! link matlabImplicit Green
highlight! link matlabDelimiter Fg
highlight! link matlabOperator Green
highlight! link matlabArithmeticOperator Red
highlight! link matlabArithmeticOperator Red
highlight! link matlabRelationalOperator Red
highlight! link matlabRelationalOperator Red
highlight! link matlabLogicalOperator Red
" }}}
" }}}
" Shell: {{{
" builtin: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_SH{{{
highlight! link shRange Fg
highlight! link shOption Purple
highlight! link shQuote Yellow
highlight! link shVariable BlueItalic
highlight! link shDerefSimple BlueItalic
highlight! link shDerefVar BlueItalic
highlight! link shDerefSpecial BlueItalic
highlight! link shDerefOff BlueItalic
highlight! link shVarAssign Red
highlight! link shFunctionOne Green
highlight! link shFunctionKey Red
" }}}
" }}}
" Zsh: {{{
" builtin: https://github.com/chrisbra/vim-zsh{{{
highlight! link zshOption BlueItalic
highlight! link zshSubst Orange
highlight! link zshFunction Green
" }}}
" }}}
" PowerShell: {{{
" vim-ps1: https://github.com/PProvost/vim-ps1{{{
highlight! link ps1FunctionInvocation Green
highlight! link ps1FunctionDeclaration Green
highlight! link ps1InterpolationDelimiter Purple
highlight! link ps1BuiltIn BlueItalic
" }}}
" }}}
" VimL: {{{
highlight! link vimLet Red
highlight! link vimFunction Green
highlight! link vimIsCommand Fg
highlight! link vimUserFunc Green
highlight! link vimFuncName Green
highlight! link vimMap BlueItalic
highlight! link vimNotation Purple
highlight! link vimMapLhs Green
highlight! link vimMapRhs Green
highlight! link vimSetEqual BlueItalic
highlight! link vimSetSep Fg
highlight! link vimOption BlueItalic
highlight! link vimUserAttrbKey BlueItalic
highlight! link vimUserAttrb Green
highlight! link vimAutoCmdSfxList Orange
highlight! link vimSynType Orange
highlight! link vimHiBang Orange
highlight! link vimSet BlueItalic
highlight! link vimSetSep Grey
" }}}
" Makefile: {{{
highlight! link makeIdent Purple
highlight! link makeSpecTarget BlueItalic
highlight! link makeTarget Orange
highlight! link makeCommands Red
" }}}
" CMake: {{{
highlight! link cmakeCommand Red
highlight! link cmakeKWconfigure_package_config_file BlueItalic
highlight! link cmakeKWwrite_basic_package_version_file BlueItalic
highlight! link cmakeKWExternalProject Green
highlight! link cmakeKWadd_compile_definitions Green
highlight! link cmakeKWadd_compile_options Green
highlight! link cmakeKWadd_custom_command Green
highlight! link cmakeKWadd_custom_target Green
highlight! link cmakeKWadd_definitions Green
highlight! link cmakeKWadd_dependencies Green
highlight! link cmakeKWadd_executable Green
highlight! link cmakeKWadd_library Green
highlight! link cmakeKWadd_link_options Green
highlight! link cmakeKWadd_subdirectory Green
highlight! link cmakeKWadd_test Green
highlight! link cmakeKWbuild_command Green
highlight! link cmakeKWcmake_host_system_information Green
highlight! link cmakeKWcmake_minimum_required Green
highlight! link cmakeKWcmake_parse_arguments Green
highlight! link cmakeKWcmake_policy Green
highlight! link cmakeKWconfigure_file Green
highlight! link cmakeKWcreate_test_sourcelist Green
highlight! link cmakeKWctest_build Green
highlight! link cmakeKWctest_configure Green
highlight! link cmakeKWctest_coverage Green
highlight! link cmakeKWctest_memcheck Green
highlight! link cmakeKWctest_run_script Green
highlight! link cmakeKWctest_start Green
highlight! link cmakeKWctest_submit Green
highlight! link cmakeKWctest_test Green
highlight! link cmakeKWctest_update Green
highlight! link cmakeKWctest_upload Green
highlight! link cmakeKWdefine_property Green
highlight! link cmakeKWdoxygen_add_docs Green
highlight! link cmakeKWenable_language Green
highlight! link cmakeKWenable_testing Green
highlight! link cmakeKWexec_program Green
highlight! link cmakeKWexecute_process Green
highlight! link cmakeKWexport Green
highlight! link cmakeKWexport_library_dependencies Green
highlight! link cmakeKWfile Green
highlight! link cmakeKWfind_file Green
highlight! link cmakeKWfind_library Green
highlight! link cmakeKWfind_package Green
highlight! link cmakeKWfind_path Green
highlight! link cmakeKWfind_program Green
highlight! link cmakeKWfltk_wrap_ui Green
highlight! link cmakeKWforeach Green
highlight! link cmakeKWfunction Green
highlight! link cmakeKWget_cmake_property Green
highlight! link cmakeKWget_directory_property Green
highlight! link cmakeKWget_filename_component Green
highlight! link cmakeKWget_property Green
highlight! link cmakeKWget_source_file_property Green
highlight! link cmakeKWget_target_property Green
highlight! link cmakeKWget_test_property Green
highlight! link cmakeKWif Green
highlight! link cmakeKWinclude Green
highlight! link cmakeKWinclude_directories Green
highlight! link cmakeKWinclude_external_msproject Green
highlight! link cmakeKWinclude_guard Green
highlight! link cmakeKWinstall Green
highlight! link cmakeKWinstall_files Green
highlight! link cmakeKWinstall_programs Green
highlight! link cmakeKWinstall_targets Green
highlight! link cmakeKWlink_directories Green
highlight! link cmakeKWlist Green
highlight! link cmakeKWload_cache Green
highlight! link cmakeKWload_command Green
highlight! link cmakeKWmacro Green
highlight! link cmakeKWmark_as_advanced Green
highlight! link cmakeKWmath Green
highlight! link cmakeKWmessage Green
highlight! link cmakeKWoption Green
highlight! link cmakeKWproject Green
highlight! link cmakeKWqt_wrap_cpp Green
highlight! link cmakeKWqt_wrap_ui Green
highlight! link cmakeKWremove Green
highlight! link cmakeKWseparate_arguments Green
highlight! link cmakeKWset Green
highlight! link cmakeKWset_directory_properties Green
highlight! link cmakeKWset_property Green
highlight! link cmakeKWset_source_files_properties Green
highlight! link cmakeKWset_target_properties Green
highlight! link cmakeKWset_tests_properties Green
highlight! link cmakeKWsource_group Green
highlight! link cmakeKWstring Green
highlight! link cmakeKWsubdirs Green
highlight! link cmakeKWtarget_compile_definitions Green
highlight! link cmakeKWtarget_compile_features Green
highlight! link cmakeKWtarget_compile_options Green
highlight! link cmakeKWtarget_include_directories Green
highlight! link cmakeKWtarget_link_directories Green
highlight! link cmakeKWtarget_link_libraries Green
highlight! link cmakeKWtarget_link_options Green
highlight! link cmakeKWtarget_precompile_headers Green
highlight! link cmakeKWtarget_sources Green
highlight! link cmakeKWtry_compile Green
highlight! link cmakeKWtry_run Green
highlight! link cmakeKWunset Green
highlight! link cmakeKWuse_mangled_mesa Green
highlight! link cmakeKWvariable_requires Green
highlight! link cmakeKWvariable_watch Green
highlight! link cmakeKWwrite_file Green
" }}}
" Json: {{{
highlight! link jsonKeyword Red
highlight! link jsonString Green
highlight! link jsonBoolean Blue
highlight! link jsonNoise Grey
highlight! link jsonQuote Grey
highlight! link jsonBraces Fg
" }}}
" Yaml: {{{
highlight! link yamlKey Red
highlight! link yamlConstant BlueItalic
highlight! link yamlString Green
" }}}
" Toml: {{{
call s:HL('tomlTable', s:palette.purple, s:palette.none, 'bold')
highlight! link tomlKey Red
highlight! link tomlBoolean Blue
highlight! link tomlString Green
highlight! link tomlTableArray tomlTable
" }}}
" Diff: {{{
highlight! link diffAdded Green
highlight! link diffRemoved Red
highlight! link diffChanged Blue
highlight! link diffOldFile Yellow
highlight! link diffNewFile Orange
highlight! link diffFile Purple
highlight! link diffLine Grey
highlight! link diffIndexLine Purple
" }}}
" Git Commit: {{{
highlight! link gitcommitSummary Red
highlight! link gitcommitUntracked Grey
highlight! link gitcommitDiscarded Grey
highlight! link gitcommitSelected Grey
highlight! link gitcommitUnmerged Grey
highlight! link gitcommitOnBranch Grey
highlight! link gitcommitArrow Grey
highlight! link gitcommitFile Green
" }}}
" INI: {{{
call s:HL('dosiniHeader', s:palette.red, s:palette.none, 'bold')
highlight! link dosiniLabel Blue
highlight! link dosiniValue Green
highlight! link dosiniNumber Green
" }}}
" Help: {{{
call s:HL('helpNote', s:palette.purple, s:palette.none, 'bold')
call s:HL('helpHeadline', s:palette.red, s:palette.none, 'bold')
call s:HL('helpHeader', s:palette.orange, s:palette.none, 'bold')
call s:HL('helpURL', s:palette.green, s:palette.none, 'underline')
call s:HL('helpHyperTextEntry', s:palette.blue, s:palette.none, 'bold')
highlight! link helpHyperTextJump Blue
highlight! link helpCommand Yellow
highlight! link helpExample Green
highlight! link helpSpecial Purple
highlight! link helpSectionDelim Grey
" }}}
" }}}
" Plugins: {{{
" junegunn/vim-plug{{{
call s:HL('plug1', s:palette.red, s:palette.none, 'bold')
call s:HL('plugNumber', s:palette.yellow, s:palette.none, 'bold')
highlight! link plug2 Blue
highlight! link plugBracket Blue
highlight! link plugName Green
highlight! link plugDash Red
highlight! link plugNotLoaded Grey
highlight! link plugH2 Purple
highlight! link plugMessage Purple
highlight! link plugError Red
highlight! link plugRelDate Grey
highlight! link plugStar Purple
highlight! link plugUpdate Blue
highlight! link plugDeleted Grey
highlight! link plugEdge Purple
" }}}
" dense-analysis/ale{{{
call s:HL('ALEError', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
call s:HL('ALEWarning', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
call s:HL('ALEInfo', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
if s:configuration.transparent_background
  call s:HL('ALEErrorSign', s:palette.red, s:palette.none)
  call s:HL('ALEWarningSign', s:palette.yellow, s:palette.none)
  call s:HL('ALEInfoSign', s:palette.blue, s:palette.none)
else
  call s:HL('ALEErrorSign', s:palette.red, s:palette.bg1)
  call s:HL('ALEWarningSign', s:palette.yellow, s:palette.bg1)
  call s:HL('ALEInfoSign', s:palette.blue, s:palette.bg1)
endif
highlight! link ALEVirtualTextError Grey
highlight! link ALEVirtualTextWarning Grey
highlight! link ALEVirtualTextInfo Grey
highlight! link ALEVirtualTextStyleError ALEVirtualTextError
highlight! link ALEVirtualTextStyleWarning ALEVirtualTextWarning
" }}}
" Yggdroot/LeaderF{{{
if !exists('g:Lf_StlColorscheme')
  let g:Lf_StlColorscheme = 'one'
endif
call s:HL('Lf_hl_match', s:palette.green, s:palette.none, 'bold')
call s:HL('Lf_hl_match0', s:palette.green, s:palette.none, 'bold')
call s:HL('Lf_hl_match1', s:palette.blue, s:palette.none, 'bold')
call s:HL('Lf_hl_match2', s:palette.red, s:palette.none, 'bold')
call s:HL('Lf_hl_match3', s:palette.yellow, s:palette.none, 'bold')
call s:HL('Lf_hl_match4', s:palette.purple, s:palette.none, 'bold')
call s:HL('Lf_hl_matchRefine', s:palette.yellow, s:palette.none, 'bold')
highlight! link Lf_hl_cursorline Fg
highlight! link Lf_hl_selection DiffAdd
highlight! link Lf_hl_rgHighlight Visual
highlight! link Lf_hl_gtagsHighlight Visual
" }}}
" junegunn/fzf.vim{{{
let g:fzf_colors = {
      \ 'fg': ['fg', 'Normal'],
      \ 'bg': ['bg', 'Normal'],
      \ 'hl': ['fg', 'Green'],
      \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+': ['fg', 'Green'],
      \ 'info': ['fg', 'Yellow'],
      \ 'prompt': ['fg', 'Red'],
      \ 'pointer': ['fg', 'Blue'],
      \ 'marker': ['fg', 'Blue'],
      \ 'spinner': ['fg', 'Yellow'],
      \ 'header': ['fg', 'Blue']
      \ }
" }}}
" }}}
" airblade/vim-gitgutter{{{
if s:configuration.transparent_background
  call s:HL('GitGutterAdd', s:palette.green, s:palette.none)
  call s:HL('GitGutterChange', s:palette.blue, s:palette.none)
  call s:HL('GitGutterDelete', s:palette.red, s:palette.none)
  call s:HL('GitGutterChangeDelete', s:palette.purple, s:palette.none)
else
  call s:HL('GitGutterAdd', s:palette.green, s:palette.bg1)
  call s:HL('GitGutterChange', s:palette.blue, s:palette.bg1)
  call s:HL('GitGutterDelete', s:palette.red, s:palette.bg1)
  call s:HL('GitGutterChangeDelete', s:palette.purple, s:palette.bg1)
endif
" }}}
" justinmk/vim-dirvish{{{
highlight! link DirvishPathTail Blue
highlight! link DirvishArg Yellow
" }}}
" vim.org/netrw {{{
" https://www.vim.org/scripts/script.php?script_id=1075
highlight! link netrwDir Green
highlight! link netrwClassify Green
highlight! link netrwLink Grey
highlight! link netrwSymLink Fg
highlight! link netrwExe Red
highlight! link netrwComment Grey
highlight! link netrwList Yellow
highlight! link netrwHelpCmd Blue
highlight! link netrwCmdSep Grey
highlight! link netrwVersion Purple
" }}}
" andymass/vim-matchup{{{
call s:HL('MatchParenCur', s:palette.none, s:palette.none, 'bold')
call s:HL('MatchWord', s:palette.none, s:palette.none, 'underline')
call s:HL('MatchWordCur', s:palette.none, s:palette.none, 'underline')
" }}}
" easymotion/vim-easymotion {{{
highlight! link EasyMotionTarget Search
highlight! link EasyMotionShade Grey
" }}}
" justinmk/vim-sneak {{{
highlight! link Sneak Cursor
highlight! link SneakLabel Cursor
highlight! link SneakScope DiffAdd
" }}}
" terryma/vim-multiple-cursors{{{
highlight! link multiple_cursors_cursor Cursor
highlight! link multiple_cursors_visual Visual
" }}}
" mg979/vim-visual-multi{{{
let g:VM_Mono_hl = 'Cursor'
let g:VM_Extend_hl = 'Visual'
let g:VM_Cursor_hl = 'Cursor'
let g:VM_Insert_hl = 'Cursor'
" }}}
" RRethy/vim-illuminate{{{
highlight! link illuminatedWord CocHighlightText
" }}}
" itchyny/vim-cursorword{{{
highlight! link CursorWord0 CocHighlightText
highlight! link CursorWord1 CocHighlightText
" }}}
" liuchengxu/vim-which-key{{{
highlight! link WhichKey Red
highlight! link WhichKeySeperator Green
highlight! link WhichKeyGroup Orange
highlight! link WhichKeyDesc Blue
" }}}
" Terminal: {{{
if (has('termguicolors') && &termguicolors) || has('gui_running')
  " Definition
  let s:terminal = {
        \ 'black':    s:palette.black,
        \ 'red':      s:palette.red,
        \ 'yellow':   s:palette.yellow,
        \ 'green':    s:palette.green,
        \ 'cyan':     s:palette.orange,
        \ 'blue':     s:palette.blue,
        \ 'purple':   s:palette.purple,
        \ 'white':    s:palette.fg
        \ }
  " Implementation: {{{
  if !has('nvim')
    let g:terminal_ansi_colors = [s:terminal.black[0], s:terminal.red[0], s:terminal.green[0], s:terminal.yellow[0],
          \ s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0], s:terminal.black[0], s:terminal.red[0],
          \ s:terminal.green[0], s:terminal.yellow[0], s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0]]
  else
    let g:terminal_color_0 = s:terminal.black[0]
    let g:terminal_color_1 = s:terminal.red[0]
    let g:terminal_color_2 = s:terminal.green[0]
    let g:terminal_color_3 = s:terminal.yellow[0]
    let g:terminal_color_4 = s:terminal.blue[0]
    let g:terminal_color_5 = s:terminal.purple[0]
    let g:terminal_color_6 = s:terminal.cyan[0]
    let g:terminal_color_7 = s:terminal.white[0]
    let g:terminal_color_8 = s:terminal.black[0]
    let g:terminal_color_9 = s:terminal.red[0]
    let g:terminal_color_10 = s:terminal.green[0]
    let g:terminal_color_11 = s:terminal.yellow[0]
    let g:terminal_color_12 = s:terminal.blue[0]
    let g:terminal_color_13 = s:terminal.purple[0]
    let g:terminal_color_14 = s:terminal.cyan[0]
    let g:terminal_color_15 = s:terminal.white[0]
  endif
  " }}}
endif
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:


endfunction

call Tokyonight() 

" **/ 
" /** ----------> AUTOPAIRS  

lua <<EOF

-- Module definition ==========================================================
local MiniPairs = {}
local H = {}

function MiniPairs.setup(config)
  -- Export module
  _G.MiniPairs = MiniPairs

  -- Setup config
  config = H.setup_config(config)

  -- Apply config
  H.apply_config(config)

  -- Module behavior
  vim.api.nvim_exec(
    [[augroup MiniPairs
        au!
        au FileType TelescopePrompt let b:minipairs_disable=v:true
        au FileType fzf let b:minipairs_disable=v:true
      augroup END]],
    false
  )
end

--- Module config
---
MiniPairs.config = {
  -- In which modes mappings from this `config` should be created
  modes = { insert = true, command = false, terminal = false },

  -- Global mappings. Each right hand side should be a pair information, a
  -- table with at least these fields (see more in |MiniPairs.map|):
  -- - <action> - one of "open", "close", "closeopen".
  -- - <pair> - two character string for pair to be used.
  -- By default pair is not inserted after `\`, quotes are not recognized by
  -- `<CR>`, `'` does not insert pair after a letter.
  -- Only parts of tables can be tweaked (others will use these defaults).
  mappings = {
    ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
    ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
    ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
    ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].' },

    [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
    [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
    ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
    ['>'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },

    ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
    ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
    ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
  },
}
function MiniPairs.map(mode, lhs, pair_info, opts)
  pair_info = H.validate_pair_info(pair_info)
  opts = vim.tbl_deep_extend('force', opts or {}, { expr = true, noremap = true })
  opts.desc = H.infer_mapping_description(pair_info)

  H.map(mode, lhs, H.pair_info_to_map_rhs(pair_info), opts)
  H.register_pair(pair_info, mode, 'all')

  -- Ensure that `<BS>` and `<CR>` are mapped for input mode
  H.ensure_cr_bs(mode)
end

function MiniPairs.map_buf(buffer, mode, lhs, pair_info, opts)
  pair_info = H.validate_pair_info(pair_info)
  opts = vim.tbl_deep_extend('force', opts or {}, { expr = true, noremap = true })
  if vim.fn.has('nvim-0.7') == 1 then
    opts.desc = H.infer_mapping_description(pair_info)
  end

  vim.api.nvim_buf_set_keymap(buffer, mode, lhs, H.pair_info_to_map_rhs(pair_info), opts)
  H.register_pair(pair_info, mode, buffer == 0 and vim.api.nvim_get_current_buf() or buffer)

  -- Ensure that `<BS>` and `<CR>` are mapped for inpu mode
  H.ensure_cr_bs(mode)
end

function MiniPairs.unmap(mode, lhs, pair)
  -- `pair` should be supplied explicitly
  vim.validate({ pair = { pair, 'string' } })

  -- Use `pcall` to allow 'deleting' already deleted mapping
  pcall(vim.api.nvim_del_keymap, mode, lhs)
  if pair == '' then
    return
  end
  H.unregister_pair(pair, mode, 'all')
end

function MiniPairs.unmap_buf(buffer, mode, lhs, pair)
  -- `pair` should be supplied explicitly
  vim.validate({ pair = { pair, 'string' } })

  -- Use `pcall` to allow 'deleting' already deleted mapping
  pcall(vim.api.nvim_buf_del_keymap, buffer, mode, lhs)
  if pair == '' then
    return
  end
  H.unregister_pair(pair, mode, buffer == 0 and vim.api.nvim_get_current_buf() or buffer)
end

function MiniPairs.open(pair, neigh_pattern)
  if H.is_disabled() or not H.neigh_match(neigh_pattern) then
    return pair:sub(1, 1)
  end

  return ('%s%s'):format(pair, H.get_arrow_key('left'))
end

function MiniPairs.close(pair, neigh_pattern)
  if H.is_disabled() or not H.neigh_match(neigh_pattern) then
    return pair:sub(2, 2)
  end

  local close = pair:sub(2, 2)
  if H.get_cursor_neigh(1, 1) == close then
    return H.get_arrow_key('right')
  else
    return close
  end
end

function MiniPairs.closeopen(pair, neigh_pattern)
  if H.is_disabled() or H.get_cursor_neigh(1, 1) ~= pair:sub(2, 2) then
    return MiniPairs.open(pair, neigh_pattern)
  else
    return H.get_arrow_key('right')
  end
end

function MiniPairs.bs()
  local res = H.keys.bs

  local neigh = H.get_cursor_neigh(0, 1)
  if not H.is_disabled() and H.is_pair_registered(neigh, vim.fn.mode(), 0, 'bs') then
    res = ('%s%s'):format(res, H.keys.del)
  end

  return res
end

function MiniPairs.cr()
  local res = H.keys.cr

  local neigh = H.get_cursor_neigh(0, 1)
  if not H.is_disabled() and H.is_pair_registered(neigh, vim.fn.mode(), 0, 'cr') then
    res = ('%s%s'):format(res, H.keys.above)
  end

  return res
end

-- Helper data ================================================================
-- Module default config
H.default_config = MiniPairs.config

-- Default value of `pair_info` for mapping functions
H.default_pair_info = { neigh_pattern = '..', register = { bs = true, cr = true } }

-- Pair sets registered *per mode-buffer-key*. Buffer `'all'` contains pairs
-- registered for all buffers.
H.registered_pairs = {
  i = { all = { bs = {}, cr = {} } },
  c = { all = { bs = {}, cr = {} } },
  t = { all = { bs = {}, cr = {} } },
}

-- Precomputed keys to increase speed
-- stylua: ignore start
local function escape(s) return vim.api.nvim_replace_termcodes(s, true, true, true) end
H.keys = {
  above     = escape('<C-o>O'),
  bs        = escape('<bs>'),
  cr        = escape('<cr>'),
  del       = escape('<del>'),
  keep_undo = escape('<C-g>U'),
  -- NOTE: use `get_arrow_key()` instead of `H.keys.left` or `H.keys.right`
  left      = escape('<left>'),
  right     = escape('<right>')
}
-- stylua: ignore end

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
function H.setup_config(config)
  -- General idea: if some table elements are not present in user-supplied
  -- `config`, take them from default config
  vim.validate({ config = { config, 'table', true } })
  config = vim.tbl_deep_extend('force', H.default_config, config or {})

  -- Validate per nesting level to produce correct error message
  vim.validate({
    modes = { config.modes, 'table' },
    mappings = { config.mappings, 'table' },
  })

  vim.validate({
    ['modes.insert'] = { config.modes.insert, 'boolean' },
    ['modes.command'] = { config.modes.command, 'boolean' },
    ['modes.terminal'] = { config.modes.terminal, 'boolean' },
  })

  H.validate_pair_info(config.mappings['('], "mappings['(']")
  H.validate_pair_info(config.mappings['['], "mappings['[']")
  H.validate_pair_info(config.mappings['{'], "mappings['{']")
  H.validate_pair_info(config.mappings[')'], "mappings[')']")
  H.validate_pair_info(config.mappings[']'], "mappings[']']")
  H.validate_pair_info(config.mappings['}'], "mappings['}']")
  -- H.validate_pair_info(config.mappings['"'], "mappings['\"']")
  H.validate_pair_info(config.mappings["'"], 'mappings["\'"]')
  H.validate_pair_info(config.mappings['`'], "mappings['`']")

  return config
end

function H.apply_config(config)
  MiniPairs.config = config

  -- Setup mappings in supplied modes
  local mode_ids = { insert = 'i', command = 'c', terminal = 't' }
  -- Compute in which modes mapping should be set up
  local mode_array = {}
  for name, to_set in pairs(config.modes) do
    if to_set then
      table.insert(mode_array, mode_ids[name])
    end
  end

  for _, mode in pairs(mode_array) do
    for key, pair_info in pairs(config.mappings) do
      -- This also should take care of mapping `<BS>` and `<CR>`
      MiniPairs.map(mode, key, pair_info)
    end
  end
end

function H.is_disabled()
  return vim.g.minipairs_disable == true or vim.b.minipairs_disable == true
end

-- Pair registration ----------------------------------------------------------
function H.register_pair(pair_info, mode, buffer)
  -- Process new mode
  H.registered_pairs[mode] = H.registered_pairs[mode] or { all = { bs = {}, cr = {} } }
  local mode_pairs = H.registered_pairs[mode]

  -- Process new buffer
  mode_pairs[buffer] = mode_pairs[buffer] or { bs = {}, cr = {} }

  -- Register pair if it is not already registered
  local register, pair = pair_info.register, pair_info.pair
  if register.bs and not vim.tbl_contains(mode_pairs[buffer].bs, pair) then
    table.insert(mode_pairs[buffer].bs, pair)
  end
  if register.cr and not vim.tbl_contains(mode_pairs[buffer].cr, pair) then
    table.insert(mode_pairs[buffer].cr, pair)
  end
end

function H.unregister_pair(pair, mode, buffer)
  local mode_pairs = H.registered_pairs[mode]
  if not (mode_pairs and mode_pairs[buffer]) then
    return
  end

  local buf_pairs = mode_pairs[buffer]
  for _, key in ipairs({ 'bs', 'cr' }) do
    for i, p in ipairs(buf_pairs[key]) do
      if p == pair then
        table.remove(buf_pairs[key], i)
      end
    end
  end
end

function H.is_pair_registered(pair, mode, buffer, key)
  local mode_pairs = H.registered_pairs[mode]
  if not mode_pairs then
    return false
  end

  if vim.tbl_contains(mode_pairs['all'][key], pair) then
    return true
  end

  buffer = buffer == 0 and vim.api.nvim_get_current_buf() or buffer
  local buf_pairs = mode_pairs[buffer]
  if not buf_pairs then
    return false
  end

  return vim.tbl_contains(buf_pairs[key], pair)
end

function H.ensure_cr_bs(mode)
  local has_any_cr_pair, has_any_bs_pair = false, false
  for _, pair_tbl in pairs(H.registered_pairs[mode]) do
    has_any_cr_pair = has_any_cr_pair or not vim.tbl_isempty(pair_tbl.cr)
    has_any_bs_pair = has_any_bs_pair or not vim.tbl_isempty(pair_tbl.bs)
  end

  -- NOTE: this doesn't distinguish between global and buffer mappings. Both
  -- `<BS>` and `<CR>` should work as normal even if no pairs are registered
  if has_any_bs_pair then
    H.map(mode, '<BS>', [[v:lua.MiniPairs.bs()]], { expr = true, desc = 'MiniPairs <BS>' })
  end
  if mode == 'i' and has_any_cr_pair then
    H.map(mode, '<CR>', [[v:lua.MiniPairs.cr()]], { expr = true, desc = 'MiniPairs <CR>' })
  end
end

-- Work with pair_info --------------------------------------------------------
function H.validate_pair_info(pair_info, prefix)
  prefix = prefix or 'pair_info'
  vim.validate({ [prefix] = { pair_info, 'table' } })
  pair_info = vim.tbl_deep_extend('force', H.default_pair_info, pair_info)

  vim.validate({
    [prefix .. '.action'] = { pair_info.action, 'string' },
    [prefix .. '.pair'] = { pair_info.pair, 'string' },
    [prefix .. '.neigh_pattern'] = { pair_info.neigh_pattern, 'string' },
    [prefix .. '.register'] = { pair_info.register, 'table' },
  })

  vim.validate({
    [prefix .. '.register.bs'] = { pair_info.register.bs, 'boolean' },
    [prefix .. '.register.cr'] = { pair_info.register.cr, 'boolean' },
  })

  return pair_info
end

function H.pair_info_to_map_rhs(pair_info)
  return ('v:lua.MiniPairs.%s(%s, %s)'):format(
    pair_info.action,
    vim.inspect(pair_info.pair),
    vim.inspect(pair_info.neigh_pattern)
  )
end

function H.infer_mapping_description(pair_info)
  local action_name = pair_info.action:sub(1, 1):upper() .. pair_info.action:sub(2)
  return ([[%s action for %s pair]]):format(action_name, vim.inspect(pair_info.pair))
end

-- Utilities ------------------------------------------------------------------
function H.get_cursor_neigh(start, finish)
  local line, col
  if vim.fn.mode() == 'c' then
    line = vim.fn.getcmdline()
    col = vim.fn.getcmdpos()
    -- Adjust start and finish because output of `getcmdpos()` starts counting
    -- columns from 1
    start = start - 1
    finish = finish - 1
  else
    line = vim.api.nvim_get_current_line()
    col = vim.api.nvim_win_get_cursor(0)[2]
  end

  -- Add '\r' and '\n' to always return 2 characters
  return string.sub(('%s%s%s'):format('\r', line, '\n'), col + 1 + start, col + 1 + finish)
end

function H.neigh_match(pattern)
  return (pattern == nil) or (H.get_cursor_neigh(0, 1):find(pattern) ~= nil)
end

function H.get_arrow_key(key)
  if vim.fn.mode() == 'i' then
    -- Using left/right keys in insert mode breaks undo sequence and, more
    -- importantly, dot-repeat. To avoid this, use 'i_CTRL-G_U' mapping.
    return H.keys.keep_undo .. H.keys[key]
  else
    return H.keys[key]
  end
end

function H.map(mode, key, rhs, opts)
  --stylua: ignore
  if key == '' then return end

  opts = vim.tbl_deep_extend('force', { noremap = true }, opts or {})

  -- Use mapping description only in Neovim>=0.7
  if vim.fn.has('nvim-0.7') == 0 then
    opts.desc = nil
  end

  vim.api.nvim_set_keymap(mode, key, rhs, opts)
end

return MiniPairs.setup()

EOF

" **/
" /** ----------> TABLINE 

lua <<EOF

-- Module definition ==========================================================
local MiniTabline = {}
local H = {}

function MiniTabline.setup(config)
  -- Export module
  _G.MiniTabline = MiniTabline

  -- Setup config
  config = H.setup_config(config)

  -- Apply config
  H.apply_config(config)

  -- Function to make tabs clickable
  vim.api.nvim_exec(
    [[function! MiniTablineSwitchBuffer(buf_id, clicks, button, mod)
        execute 'buffer' a:buf_id
      endfunction]],
    false
  )

  -- Create highlighting
  vim.api.nvim_exec(
    [[hi default link MiniTablineCurrent TabLineSel
      hi default link MiniTablineVisible TabLineSel
      hi default link MiniTablineHidden  TabLine
      hi default link MiniTablineModifiedCurrent ModifiedTab
      hi default link MiniTablineModifiedVisible ModifiedTab
      hi default link MiniTablineModifiedHidden  StatusLineNC
      hi default link MiniTablineTabpagesection Search
      hi default MiniTablineFill NONE]],
    false
  )
end

--- Module config
---
--- Default values:
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
MiniTabline.config = {
  -- Whether to show file icons (requires 'kyazdani42/nvim-web-devicons')
  show_icons = false,

  -- Whether to set Vim's settings for tabline (make it always shown and
  -- allow hidden buffers)
  set_vim_settings = true,

  -- Where to show tabpage section in case of multiple vim tabpages.
  -- One of 'left', 'right', 'none'.
  tabpage_section = 'left',
}
--minidoc_afterlines_end

-- Module functionality =======================================================
-- TODO: remove after 0.4.0 release.
function MiniTabline.update_tabline()
  H.notify('`MiniTabline.update_tabline()` is deprecated because it is obsolete.')

  vim.o.tabline = '%!v:lua.MiniTabline.make_tabline_string()'
end

--- Make string for |tabline|
function MiniTabline.make_tabline_string()
  if H.is_disabled() then
    return ''
  end

  H.make_tabpage_section()
  H.list_tabs()
  H.finalize_labels()
  H.fit_width()

  return H.concat_tabs()
end

-- Helper data ================================================================
-- Module default config
H.default_config = MiniTabline.config

-- Table to keep track of tabs
H.tabs = {}

-- Indicator of whether there is clickable support
H.tablineat = vim.fn.has('tablineat')

-- Keep track of initially unnamed buffers
H.unnamed_buffers_seq_ids = {}

-- Separator of file path
H.path_sep = package.config:sub(1, 1)

-- String with tabpage prefix
H.tabpage_section = ''

-- Buffer number of center buffer
H.center_buf_id = nil

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
function H.setup_config(config)
  -- General idea: if some table elements are not present in user-supplied
  -- `config`, take them from default config
  vim.validate({ config = { config, 'table', true } })
  config = vim.tbl_deep_extend('force', H.default_config, config or {})

  vim.validate({
    show_icons = { config.show_icons, 'boolean' },
    set_vim_settings = { config.set_vim_settings, 'boolean' },
    tabpage_section = { config.tabpage_section, 'string' },
  })

  return config
end

function H.apply_config(config)
  MiniTabline.config = config

  -- Set settings to ensure tabline is displayed properly
  if config.set_vim_settings then
    vim.o.showtabline = 2 -- Always show tabline
    vim.o.hidden = true -- Allow switching buffers without saving them
  end

  -- Set tabline string
  vim.o.tabline = '%!v:lua.MiniTabline.make_tabline_string()'
end

function H.is_disabled()
  return vim.g.minitabline_disable == true or vim.b.minitabline_disable == true
end

-- Work with tabpages ---------------------------------------------------------
function H.make_tabpage_section()
  local n_tabpages = vim.fn.tabpagenr('$')
  if n_tabpages == 1 or MiniTabline.config.tabpage_section == 'none' then
    H.tabpage_section = ''
    return
  end

  local cur_tabpagenr = vim.fn.tabpagenr()
  H.tabpage_section = (' Tab %s/%s '):format(cur_tabpagenr, n_tabpages)
end

-- Work with tabs -------------------------------------------------------------
-- List tabs
function H.list_tabs()
  local tabs = {}
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if H.is_buffer_in_minitabline(buf_id) then
      local tab = { buf_id = buf_id }
      tab['hl'] = H.construct_highlight(buf_id)
      tab['tabfunc'] = H.construct_tabfunc(buf_id)
      tab['label'], tab['label_extender'] = H.construct_label_data(buf_id)

      table.insert(tabs, tab)
    end
  end

  H.tabs = tabs
end

function H.is_buffer_in_minitabline(buf_id)
  return vim.api.nvim_buf_get_option(buf_id, 'buflisted')
end

-- Tab's highlight group
function H.construct_highlight(buf_id)
  local hl_type
  if buf_id == vim.api.nvim_get_current_buf() then
    hl_type = 'Current'
  elseif vim.fn.bufwinnr(buf_id) > 0 then
    hl_type = 'Visible'
  else
    hl_type = 'Hidden'
  end
  if vim.api.nvim_buf_get_option(buf_id, 'modified') then
    hl_type = 'Modified' .. hl_type
  end

  return string.format('%%#MiniTabline%s#', hl_type)
end

-- Tab's clickable action (if supported)
function H.construct_tabfunc(buf_id)
  if H.tablineat > 0 then
    return string.format([[%%%d@MiniTablineSwitchBuffer@]], buf_id)
  else
    return ''
  end
end

-- Tab's label and label extender
function H.construct_label_data(buf_id)
  local label, label_extender

  local bufpath = vim.api.nvim_buf_get_name(buf_id)
  if bufpath ~= '' then
    -- Process path buffer
    label = vim.fn.fnamemodify(bufpath, ':t')
    label_extender = H.make_path_extender(buf_id)
  else
    -- Process unnamed buffer
    label = H.make_unnamed_label(buf_id)
    --stylua: ignore
    label_extender = function(x) return x end
  end

  return label, label_extender
end

function H.make_path_extender(buf_id)
  -- Add parent to current label (if possible)
  return function(label)
    local full_path = vim.api.nvim_buf_get_name(buf_id)
    -- Using `vim.pesc` prevents effect of problematic characters (like '.')
    local pattern = string.format('[^%s]+%s%s$', vim.pesc(H.path_sep), vim.pesc(H.path_sep), vim.pesc(label))
    return string.match(full_path, pattern) or label
  end
end

function H.make_unnamed_label(buf_id)
  local label
  if vim.api.nvim_buf_get_option(buf_id, 'buftype') == 'quickfix' then
    label = '*quickfix*'
  else
    label = H.is_buffer_scratch(buf_id) and '!' or '*'
  end

  -- Possibly add tracking id
  local unnamed_id = H.get_unnamed_id(buf_id)
  if unnamed_id > 1 then
    label = string.format('%s(%d)', label, unnamed_id)
  end

  return label
end

function H.is_buffer_scratch(buf_id)
  local buftype = vim.api.nvim_buf_get_option(buf_id, 'buftype')
  return (buftype == 'acwrite') or (buftype == 'nofile')
end

function H.get_unnamed_id(buf_id)
  -- Use existing sequential id if possible
  local seq_id = H.unnamed_buffers_seq_ids[buf_id]
  if seq_id ~= nil then
    return seq_id
  end

  -- Cache sequential id for currently unnamed buffer `buf_id`
  H.unnamed_buffers_seq_ids[buf_id] = vim.tbl_count(H.unnamed_buffers_seq_ids) + 1
  return H.unnamed_buffers_seq_ids[buf_id]
end

-- Work with labels -----------------------------------------------------------
function H.finalize_labels()
  -- Deduplicate
  local nonunique_tab_ids = H.get_nonunique_tab_ids()
  while #nonunique_tab_ids > 0 do
    local nothing_changed = true

    -- Extend labels
    for _, buf_id in ipairs(nonunique_tab_ids) do
      local tab = H.tabs[buf_id]
      local old_label = tab.label
      tab.label = tab.label_extender(tab.label)
      if old_label ~= tab.label then
        nothing_changed = false
      end
    end

    if nothing_changed then
      break
    end

    nonunique_tab_ids = H.get_nonunique_tab_ids()
  end

  -- Postprocess: add file icons and padding
  local has_devicons, devicons
  local show_icons = MiniTabline.config.show_icons

  -- Have this `require()` here to not depend on plugin initialization order
  if show_icons then
    has_devicons, devicons = pcall(require, 'nvim-web-devicons')
  end

  for _, tab in pairs(H.tabs) do
    if show_icons and has_devicons then
      local extension = vim.fn.fnamemodify(tab.label, ':e')
      local icon = devicons.get_icon(tab.label, extension, { default = true })
      tab.label = string.format(' %s %s ', icon, tab.label)
    else
      tab.label = string.format(' %s ', tab.label)
    end
  end
end

function H.get_nonunique_tab_ids()
  -- Collect tab-array-id per label
  local label_tab_ids = {}
  for i, tab in ipairs(H.tabs) do
    local label = tab.label
    if label_tab_ids[label] == nil then
      label_tab_ids[label] = { i }
    else
      table.insert(label_tab_ids[label], i)
    end
  end

  -- Collect tab-array-ids with non-unique labels
  return vim.tbl_flatten(vim.tbl_filter(function(x)
    return #x > 1
  end, label_tab_ids))
end

-- Fit tabline to maximum displayed width -------------------------------------
function H.fit_width()
  H.update_center_buf_id()

  -- Compute label width data
  local center_offset = 1
  local tot_width = 0
  for _, tab in pairs(H.tabs) do
    -- Use `nvim_strwidth()` and not `:len()` to respect multibyte characters
    tab.label_width = vim.api.nvim_strwidth(tab.label)
    tab.chars_on_left = tot_width

    tot_width = tot_width + tab.label_width

    if tab.buf_id == H.center_buf_id then
      -- Make right end of 'center tab' to be always displayed in center in
      -- case of truncation
      center_offset = tot_width
    end
  end

  local display_interval = H.compute_display_interval(center_offset, tot_width)

  H.truncate_tabs_display(display_interval)
end

function H.update_center_buf_id()
  local cur_buf = vim.api.nvim_get_current_buf()
  if H.is_buffer_in_minitabline(cur_buf) then
    H.center_buf_id = cur_buf
  end
end

function H.compute_display_interval(center_offset, tabline_width)

  local tot_width = vim.o.columns - vim.api.nvim_strwidth(H.tabpage_section)
  local right = math.min(tabline_width, math.floor(center_offset + 0.5 * tot_width))
  local left = math.max(1, right - tot_width + 1)
  right = left + math.min(tot_width, tabline_width) - 1

  return { left, right }
end

function H.truncate_tabs_display(display_interval)
  local display_left, display_right = display_interval[1], display_interval[2]

  local tabs = {}
  for _, tab in ipairs(H.tabs) do
    local tab_left = tab.chars_on_left + 1
    local tab_right = tab.chars_on_left + tab.label_width
    if (display_left <= tab_right) and (tab_left <= display_right) then
      -- Process tab that should be displayed (even partially)
      local n_trunc_left = math.max(0, display_left - tab_left)
      local n_trunc_right = math.max(0, tab_right - display_right)

      -- Take desired amount of characters starting from `n_trunc_left`
      tab.label = vim.fn.strcharpart(tab.label, n_trunc_left, tab.label_width - n_trunc_right)

      table.insert(tabs, tab)
    end
  end

  H.tabs = tabs
end

-- Concatenate tabs into single tablien string --------------------------------
function H.concat_tabs()
  -- NOTE: it is assumed that all padding is incorporated into labels
  local t = {}
  for _, tab in ipairs(H.tabs) do
    -- Escape '%' in labels
    table.insert(t, ('%s%s%s'):format(tab.hl, tab.tabfunc, tab.label:gsub('%%', '%%%%')))
  end

  -- Usage of `%X` makes filled space to the right 'non-clickable'
  local res = ('%s%%X%%#MiniTablineFill#'):format(table.concat(t, ''))

  -- Add tabpage section
  local position = MiniTabline.config.tabpage_section
  if H.tabpage_section ~= '' then
    if not vim.tbl_contains({ 'none', 'left', 'right' }, position) then
      H.notify([[`config.tabpage_section` should be one of 'left', 'right', 'none'.]])
    end
    if position == 'left' then
      res = ('%%#MiniTablineTabpagesection#%s%s'):format(H.tabpage_section, res)
    end
    if position == 'right' then
      -- Use `%=` to make it stick to right hand side
      res = ('%s%%=%%#MiniTablineTabpagesection#%s'):format(res, H.tabpage_section)
    end
  end

  return res
end

return MiniTabline.setup()

EOF

" **/
" /** ---------> STARTER  

lua <<EOF

-- Module definition ==========================================================
local MiniStarter = {}
local H = {}

function MiniStarter.setup(config)
  _G.MiniStarter = MiniStarter
  config = H.setup_config(config)
  H.apply_config(config)
  vim.api.nvim_exec(
    [[augroup MiniStarter
        au!
        au VimEnter * ++nested ++once lua MiniStarter.on_vimenter()
      augroup END]],
    false
  )

  -- Create highlighting
  vim.api.nvim_exec(
    [[hi default link MiniStarterCurrent    NONE
      hi default link MiniStarterFooter     TitleBlue
      hi default link MiniStarterHeader     TitleBlue
      hi default link MiniStarterInactive   Comment
      hi default link MiniStarterItem       Normal
      hi default link MiniStarterItemBullet Delimiter
      hi default link MiniStarterItemPrefix TitleBlue 
      hi default link MiniStarterSection    Title 
      hi default link MiniStarterQuery      MoreMsg]],
    false
  )
end

--- Module config
MiniStarter.config = {
  -- Whether to open starter buffer on VimEnter. Not opened if Neovim was
  -- started with intent to show something else.
  autoopen = true,

  -- Whether to evaluate action of single active item
  evaluate_single = false,

  -- Items to be displayed. Should be an array with the following elements:
  -- - Item: table with <action>, <name>, and <section> keys.
  -- - Function: should return one of these three categories.
  -- - Array: elements of these three types (i.e. item, array, function).
  -- If `nil` (default), default items will be used (see |mini.starter|).
  items = nil,

  -- Header to be displayed before items. Converted to single string via
  -- `tostring` (use `\n` to display several lines). If function, it is
  -- evaluated first. If `nil` (default), polite greeting will be used.
  -- header = nil,
  header = "------------------- NEOVIM -------------------",

  -- Footer to be displayed after items. Converted to single string via
  -- `tostring` (use `\n` to display several lines). If function, it is
  -- evaluated first. If `nil` (default), default usage help will be shown.
  -- footer = nil,
  footer = "---------------- ############ ----------------",

  -- Array  of functions to be applied consecutively to initial content.
  -- Each function should take and return content for 'Starter' buffer (see
  -- |mini.starter| and |MiniStarter.content| for more details).
  content_hooks = nil,

  -- Characters to update query. Each character will have special buffer
  -- mapping overriding your global ones. Be careful to not add `:` as it
  -- allows you to go into command mode.
  query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.]],
}
MiniStarter.content = {}

-- Module functionality =======================================================
--- Act on |VimEnter|.
function MiniStarter.on_vimenter()
  if MiniStarter.config.autoopen and not H.is_something_shown() then
    -- Set indicator used to make different decision on startup
    H.is_in_vimenter = true
    MiniStarter.open()

		H.check_starter = true
  end
end

H.check_starter = false

-- MiniStarter Toggle Function
function MiniStarter.toggle()
	if (H.check_starter == true) then
 		MiniStarter.close()
 	else
 		MiniStarter.open()
 	end
end

function MiniStarter.open(buf_id)
  if H.is_disabled() then
    return
  end

  -- Reset helper data
  H.current_item_id = 1
  H.query = ''

  -- Ensure proper buffer and open it
  if H.is_in_vimenter then
    buf_id = vim.api.nvim_get_current_buf()
  end

  if buf_id == nil or not vim.api.nvim_buf_is_valid(buf_id) then
    buf_id = vim.api.nvim_create_buf(false, true)
  end

  H.buf_id = buf_id
  vim.api.nvim_set_current_buf(H.buf_id)

  -- Setup buffer behavior
  H.make_buffer_autocmd()
  H.apply_buffer_options()
  H.apply_buffer_mappings()

  -- Populate buffer
  MiniStarter.refresh()

  -- Issue custom event
  vim.cmd([[doautocmd User MiniStarterOpened]])

  -- Ensure not being in VimEnter
  H.is_in_vimenter = false

	H.check_starter = true
end

function MiniStarter.refresh()
  if H.is_disabled() or H.buf_id == nil or not vim.api.nvim_buf_is_valid(H.buf_id) then
    return
  end

  -- Normalize certain config values
  H.header = H.normalize_header_footer(MiniStarter.config.header or H.default_header)
  local items = H.normalize_items(MiniStarter.config.items or H.default_items)
  H.footer = H.normalize_header_footer(MiniStarter.config.footer or H.default_footer)

  -- Evaluate content
  H.make_initial_content(items)
  local hooks = MiniStarter.config.content_hooks or H.default_content_hooks
  for _, f in ipairs(hooks) do
    MiniStarter.content = f(MiniStarter.content)
  end
  H.items = MiniStarter.content_to_items()

  -- Add content
  vim.api.nvim_buf_set_option(H.buf_id, 'modifiable', true)
  vim.api.nvim_buf_set_lines(H.buf_id, 0, -1, false, MiniStarter.content_to_lines())
  vim.api.nvim_buf_set_option(H.buf_id, 'modifiable', false)

  -- Add highlighting
  H.content_highlight()
  H.items_highlight()

  -- -- Always position cursor on current item
  H.position_cursor_on_current_item()
  H.add_hl_current_item()

  -- Apply current query (clear command line afterwards)
  H.make_query()
end

--- Close Starter buffer
function MiniStarter.close()
  -- Use `pcall` to allow calling for already non-existing buffer
  pcall(vim.api.nvim_buf_delete, H.buf_id, {})
  H.buf_id = nil

  H.check_starter = false
end

-- Sections -------------------------------------------------------------------
--- Table of pre-configured sections
MiniStarter.sections = {}

function MiniStarter.sections.builtin_actions()
  return {
    { name = 'New File', action = 'enew', section = 'Actions ---' },
    { name = 'Explore', action = 'Explore', section = 'Actions ---' },
    { name = 'Config', action = 'e ~/.config/nvim/init.vim', section = 'Actions ---' },
    { name = 'Quit', action = 'qall', section = 'Actions ---' },
  }
end

function MiniStarter.sections.sessions(n, recent)
  n = n or 5
  recent = recent == nil and true or recent

  return function()
    if _G.MiniSessions == nil then
      return { { name = [['mini.sessions' is not set up]], action = '', section = 'Sessions' } }
    end

    local items = {}
    for session_name, session in pairs(_G.MiniSessions.detected) do
      table.insert(items, {
        _session = session,
        name = ('%s%s'):format(session_name, session.type == 'local' and ' (local)' or ''),
        action = ([[lua _G.MiniSessions.read('%s')]]):format(session_name),
        section = 'Sessions',
      })
    end

    if vim.tbl_count(items) == 0 then
      return { { name = [[There are no detected sessions in 'mini.sessions']], action = '', section = 'Sessions' } }
    end

    local sort_fun
    if recent then
      sort_fun = function(a, b)
        local a_time = a._session.type == 'local' and math.huge or a._session.modify_time
        local b_time = b._session.type == 'local' and math.huge or b._session.modify_time
        return a_time > b_time
      end
    else
      sort_fun = function(a, b)
        local a_name = a._session.type == 'local' and '' or a.name
        local b_name = b._session.type == 'local' and '' or b.name
        return a_name < b_name
      end
    end
    table.sort(items, sort_fun)

    -- Take only first `n` elements and remove helper fields
    return vim.tbl_map(function(x)
      x._session = nil
      return x
    end, vim.list_slice(items, 1, n))
  end
end

--- Section with most recently used files
---
--- Files are taken from |vim.v.oldfiles|.
---
---@param n number Number of returned items. Default: 5.
---@param current_dir boolean Whether to return files only from current working
---   directory. Default: `false`.
---@param show_path boolean Whether to append file name with its full path.
---   Default: `true`.
---
---@return __section_fun
function MiniStarter.sections.recent_files(n, current_dir, show_path)
  n = n or 5
  current_dir = current_dir == nil and false or current_dir
  show_path = show_path == nil and true or show_path

  if current_dir then
    vim.cmd([[au DirChanged * lua MiniStarter.refresh()]])
  end

  return function()
    local section = ('Recent files ---%s'):format(current_dir and ' (current directory)' or '')

    -- Use only actual readable files
    local files = vim.tbl_filter(function(f)
      return vim.fn.filereadable(f) == 1
    end, vim.v.oldfiles or {})

    if #files == 0 then
      return { { name = [[There are no recent files (`v:oldfiles` is empty)]], action = '', section = section } }
    end

    -- Possibly filter files from current directory
    if current_dir then
      local cwd = vim.loop.cwd()
      local n_cwd = cwd:len()
      files = vim.tbl_filter(function(f)
        return f:sub(1, n_cwd) == cwd
      end, files)
    end

    if #files == 0 then
      return { { name = [[There are no recent files in current directory]], action = '', section = section } }
    end

    -- Create items
    local items = {}
    local fmodify = vim.fn.fnamemodify
    for _, f in ipairs(vim.list_slice(files, 1, n)) do
      local path = show_path and (' (%s)'):format(fmodify(f, ':~:.')) or ''
      local name = ('%s%s'):format(fmodify(f, ':t'), path)
      table.insert(items, { action = ('edit %s'):format(fmodify(f, ':p')), name = name, section = section })
    end

    return items
  end
end

-- stylua: ignore start
--- Section with basic Telescope pickers relevant to start screen
---
---@return __section_fun
function MiniStarter.sections.telescope()
  return function()
    return {
      {action = 'Telescope file_browser',    name = 'Browser',         section = 'Telescope'},
      {action = 'Telescope command_history', name = 'Command history', section = 'Telescope'},
      {action = 'Telescope find_files',      name = 'Files',           section = 'Telescope'},
      {action = 'Telescope help_tags',       name = 'Help tags',       section = 'Telescope'},
      {action = 'Telescope live_grep',       name = 'Live grep',       section = 'Telescope'},
      {action = 'Telescope oldfiles',        name = 'Old files',       section = 'Telescope'},
    }
  end
end
-- stylua: ignore end

-- Content hooks --------------------------------------------------------------
--- Table with pre-configured content hook generators
---
--- Each element is a function which returns content hook. So to use them
--- inside |MiniStarter.setup|, call them.
MiniStarter.gen_hook = {}

--- Hook generator for padding
---
--- Output is a content hook which adds constant padding from left and top.
--- This allows tweaking the screen position of buffer content.
---
---@param left number Number of empty spaces to add to start of each content
---   line. Default: 0.
---@param top number Number of empty lines to add to start of content.
---   Default: 0.
---
---@return function Content hook.
function MiniStarter.gen_hook.padding(left, top)
  left = math.max(left or 0, 0)
  top = math.max(top or 0, 0)
  return function(content)
    -- Add left padding
    local left_pad = string.rep(' ', left)
    for _, line in ipairs(content) do
      local is_empty_line = #line == 0 or (#line == 1 and line[1].string == '')
      if not is_empty_line then
        table.insert(line, 1, H.content_unit(left_pad, 'empty', nil))
      end
    end

    -- Add top padding
    local top_lines = {}
    for _ = 1, top do
      table.insert(top_lines, { H.content_unit('', 'empty', nil) })
    end
    content = vim.list_extend(top_lines, content)

    return content
  end
end

--- Hook generator for adding bullet to items
---
--- Output is a content hook which adds supplied string to be displayed to the
--- left of item.
---
---@param bullet string String to be placed to the left of item name.
---   Default: "░ ".
---@param place_cursor boolean Whether to place cursor on the first character
---   of bullet when corresponding item becomes current. Default: true.
---
---@return function Content hook.
function MiniStarter.gen_hook.adding_bullet(bullet, place_cursor)
  bullet = bullet or '░ '
  place_cursor = place_cursor == nil and true or place_cursor
  return function(content)
    local coords = MiniStarter.content_coords(content, 'item')
    -- Go backwards to avoid conflict when inserting units
    for i = #coords, 1, -1 do
      local l_num, u_num = coords[i].line, coords[i].unit
      local bullet_unit = {
        string = bullet,
        type = 'item_bullet',
        hl = 'MiniStarterItemBullet',
        -- Use `_item` instead of `item` because it is better to be 'private'
        _item = content[l_num][u_num].item,
        _place_cursor = place_cursor,
      }
      table.insert(content[l_num], u_num, bullet_unit)
    end

    return content
  end
end

--- Hook generator for indexing items
---
--- Output is a content hook which adds unique index to the start of item's
--- name. It results into shortening queries required to choose an item (at
--- expense of clarity).
---
---@param grouping string One of "all" (number indexing across all sections) or
---   "section" (letter-number indexing within each section). Default: "all".
---@param exclude_sections table Array of section names (values of `section`
---   element of item) for which index won't be added. Default: `{}`.
---
---@return function Content hook.
function MiniStarter.gen_hook.indexing(grouping, exclude_sections)
  grouping = grouping or 'all'
  exclude_sections = exclude_sections or {}
  local per_section = grouping == 'section'

  return function(content)
    local cur_section, n_section, n_item = nil, 0, 0
    local coords = MiniStarter.content_coords(content, 'item')

    for _, c in ipairs(coords) do
      local unit = content[c.line][c.unit]
      local item = unit.item

      if not vim.tbl_contains(exclude_sections, item.section) then
        n_item = n_item + 1
        if cur_section ~= item.section then
          cur_section = item.section
          -- Cycle through lower case letters
          n_section = math.fmod(n_section, 26) + 1
          n_item = per_section and 1 or n_item
        end

        local section_index = per_section and string.char(96 + n_section) or ''
        unit.string = ('%s%s. %s'):format(section_index, n_item, unit.string)
      end
    end

    return content
  end
end

--- Hook generator for aligning content
---
--- Output is a content hook which independently aligns content horizontally
--- and vertically. Basically, this computes left and top pads for
--- |MiniStarter.gen_hook.padding| such that output lines would appear aligned
--- in certain way.
---
---@param horizontal string One of "left", "center", "right". Default: "left".
---@param vertical string One of "top", "center", "bottom". Default: "top".
---
---@return function Content hook.
function MiniStarter.gen_hook.aligning(horizontal, vertical)
  horizontal = horizontal == nil and 'left' or horizontal
  vertical = vertical == nil and 'top' or vertical

  local horiz_coef = ({ left = 0, center = 0.5, right = 1.0 })[horizontal]
  local vert_coef = ({ top = 0, center = 0.5, bottom = 1.0 })[vertical]

  return function(content)
    local line_strings = MiniStarter.content_to_lines(content)

    -- Align horizontally
    -- Don't use `string.len()` to account for multibyte characters
    local lines_width = vim.tbl_map(function(l)
      return vim.fn.strdisplaywidth(l)
    end, line_strings)
    local min_right_space = vim.api.nvim_win_get_width(0) - math.max(unpack(lines_width))
    local left_pad = math.max(math.floor(horiz_coef * min_right_space), 0)

    -- Align vertically
    local bottom_space = vim.api.nvim_win_get_height(0) - #line_strings
    local top_pad = math.max(math.floor(vert_coef * bottom_space), 0)

    return MiniStarter.gen_hook.padding(left_pad, top_pad)(content)
  end
end

function MiniStarter.content_coords(content, predicate)
  content = content or MiniStarter.content
  if predicate == nil then
    predicate = function(unit)
      return true
    end
  end
  if type(predicate) == 'string' then
    local pred_type = predicate
    predicate = function(unit)
      return unit.type == pred_type
    end
  end

  local res = {}
  for l_num, line in ipairs(content) do
    for u_num, unit in ipairs(line) do
      if predicate(unit) then
        table.insert(res, { line = l_num, unit = u_num })
      end
    end
  end
  return res
end

function MiniStarter.content_to_lines(content)
  return vim.tbl_map(
    function(content_line)
      return table.concat(
      -- Ensure that each content line is indeed a single buffer line
        vim.tbl_map(function(x) return x.string:gsub('\n', ' ') end, content_line), ''
      )
    end,
    content or MiniStarter.content
  )
end

function MiniStarter.content_to_items(content)
  content = content or MiniStarter.content

  -- NOTE: this havily utilizes 'modify by reference' nature of Lua tables
  local items = {}
  for l_num, line in ipairs(content) do
    -- Track 0-based starting column of current unit (using byte length)
    local start_col = 0
    for _, unit in ipairs(line) do
      -- Cursor position is (1, 0)-based
      local cursorpos = { l_num, start_col }

      if unit.type == 'item' then
        local item = unit.item
        -- Take item's name from content string
        item.name = unit.string:gsub('\n', ' ')
        item._line = l_num - 1
        item._start_col = start_col
        item._end_col = start_col + unit.string:len()
        -- Don't overwrite possible cursor position from item's bullet
        item._cursorpos = item._cursorpos or cursorpos

        table.insert(items, item)
      end

      -- Prefer placing cursor at start of item's bullet
      if unit.type == 'item_bullet' and unit._place_cursor then
        -- Item bullet uses 'private' `_item` element instead of `item`
        unit._item._cursorpos = cursorpos
      end

      start_col = start_col + unit.string:len()
    end
  end

  -- Compute length of unique prefix for every item's name (ignoring case)
  local strings = vim.tbl_map(function(x)
    return x.name:lower()
  end, items)
  local nprefix = H.unique_nprefix(strings)
  for i, n in ipairs(nprefix) do
    items[i]._nprefix = n
  end

  return items
end

-- Other exported functions ---------------------------------------------------
--- Evaluate current item
function MiniStarter.eval_current_item()
  H.eval_fun_or_string(H.items[H.current_item_id].action, true)
end

function MiniStarter.update_current_item(direction)
  -- Advance current item
  local prev_current = H.current_item_id
  H.current_item_id = H.next_active_item_id(H.current_item_id, direction)
  if H.current_item_id == prev_current then
    return
  end

  -- Update cursor position
  H.position_cursor_on_current_item()

  -- Highlight current item
  vim.api.nvim_buf_clear_namespace(H.buf_id, H.ns.current_item, 0, -1)
  H.add_hl_current_item()
end

function MiniStarter.add_to_query(char)
  local new_query
  if char == nil then
    new_query = H.query:sub(0, H.query:len() - 1)
  else
    new_query = ('%s%s'):format(H.query, char)
  end
  H.make_query(new_query)
end

function MiniStarter.set_query(query)
  query = query or ''
  if type(query) ~= 'string' then
    error('`query` should be either `nil` or string.')
  end

  H.make_query(query)
end

--- Act on |CursorMoved| by repositioning cursor in fixed place.
function MiniStarter.on_cursormoved()
  H.position_cursor_on_current_item()
end

-- Helper data ================================================================
-- Module default config
H.default_config = MiniStarter.config

-- Default config values
H.default_items = {
  function()
    if _G.MiniSessions == nil then
      return {}
    end
    return MiniStarter.sections.sessions(5, true)()
  end,
  MiniStarter.sections.recent_files(5, false, false),
  MiniStarter.sections.builtin_actions(),
}

H.default_header = function()
  local hour = tonumber(vim.fn.strftime('%H'))
  -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
  local part_id = math.floor((hour + 4) / 8) + 1
  local day_part = ({ 'evening', 'morning', 'afternoon', 'evening' })[part_id]
  local username = vim.loop.os_get_passwd()['username'] or 'USERNAME'

  return ('Good %s, %s'):format(day_part, username)
end

H.default_footer = [[
Type query to filter items
<BS> deletes latest character from query
<Esc> resets current query
<Down>/<Up> and <M-j>/<M-k> move current item
<CR> executes action of current item
<C-c> closes this buffer]]

H.default_content_hooks = { MiniStarter.gen_hook.adding_bullet(), MiniStarter.gen_hook.aligning('center', 'center') }

-- Normalized values from config
H.items = {} -- items gathered with `MiniStarter.content_to_items` from final content
H.header = {} -- table of strings
H.footer = {} -- table of strings

-- Identifier of current item
H.current_item_id = nil

-- Buffer identifier where everything is displayed
H.buf_id = nil

-- Namespaces for highlighting
H.ns = {
  activity = vim.api.nvim_create_namespace(''),
  current_item = vim.api.nvim_create_namespace(''),
  general = vim.api.nvim_create_namespace(''),
}

-- Current search query
H.query = ''

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
function H.setup_config(config)
  -- General idea: if some table elements are not present in user-supplied
  -- `config`, take them from default config
  vim.validate({ config = { config, 'table', true } })
  config = vim.tbl_deep_extend('force', H.default_config, config or {})

  vim.validate({
    autoopen = { config.autoopen, 'boolean' },
    evaluate_single = { config.evaluate_single, 'boolean' },
    items = { config.items, 'table', true },
    -- `header` and `footer` can have any type
    content_hooks = { config.content_hooks, 'table', true },
    query_updaters = { config.query_updaters, 'string' },
  })

  return config
end

function H.apply_config(config)
  MiniStarter.config = config
end

function H.is_disabled()
  return vim.g.ministarter_disable == true or vim.b.ministarter_disable == true
end

-- Normalize config elements --------------------------------------------------
function H.normalize_items(items)
  local res = H.items_flatten(items)
  if #res == 0 then
    return { { name = '`MiniStarter.config.items` is empty', action = '', section = '' } }
  end
  return H.items_sort(res)
end

function H.normalize_header_footer(x)
  if type(x) == 'function' then
    x = x()
  end
  local res = tostring(x)
  if res == '' then
    return {}
  end
  return vim.split(res, '\n')
end

-- Work with buffer content ---------------------------------------------------
function H.make_initial_content(items)
  MiniStarter.content = {}

  -- Add header lines
  for _, l in ipairs(H.header) do
    H.content_add_line({ H.content_unit(l, 'header', 'MiniStarterHeader') })
  end
  H.content_add_empty_lines(#H.header > 0 and 1 or 0)

  -- Add item lines
  H.content_add_items(items)

  -- Add footer lines
  H.content_add_empty_lines(#H.footer > 0 and 1 or 0)
  for _, l in ipairs(H.footer) do
    H.content_add_line({ H.content_unit(l, 'footer', 'MiniStarterFooter') })
  end
end

function H.content_unit(string, type, hl, extra)
  return vim.tbl_extend('force', { string = string, type = type, hl = hl }, extra or {})
end

function H.content_add_line(content_line)
  table.insert(MiniStarter.content, content_line)
end

function H.content_add_empty_lines(n)
  for _ = 1, n do
    H.content_add_line({ H.content_unit('', 'empty', nil) })
  end
end

function H.content_add_items(items)
  local cur_section
  for _, item in ipairs(items) do
    -- Possibly add section line
    if cur_section ~= item.section then
      -- Don't add empty line before first section line
      H.content_add_empty_lines(cur_section == nil and 0 or 1)
      H.content_add_line({ H.content_unit(item.section, 'section', 'MiniStarterSection') })
      cur_section = item.section
    end

    H.content_add_line({ H.content_unit(item.name, 'item', 'MiniStarterItem', { item = item }) })
  end
end

function H.content_highlight()
  for l_num, content_line in ipairs(MiniStarter.content) do
    -- Track 0-based starting column of current unit (using byte length)
    local start_col = 0
    for _, unit in ipairs(content_line) do
      if unit.hl ~= nil then
        H.buf_hl(H.ns.general, unit.hl, l_num - 1, start_col, start_col + unit.string:len(), 50)
      end
      start_col = start_col + unit.string:len()
    end
  end
end

-- Work with items -----------------------------------------------------------
function H.items_flatten(items)
  local res, f = {}, nil
  f = function(x)
    -- Expand (possibly recursively) functions immediately
    local n_nested = 0
    while type(x) == 'function' and n_nested <= 100 do
      n_nested = n_nested + 1
      if n_nested > 100 then
        H.notify('Too many nested functions in `config.items`.')
      end
      x = x()
    end

    if H.is_item(x) then
      -- Use deepcopy to allow adding fields to items without changing original
      table.insert(res, vim.deepcopy(x))
      return
    end

    if type(x) ~= 'table' then
      return
    end
    return vim.tbl_map(f, x)
  end

  f(items)
  return res
end

function H.items_sort(items)
  -- Order first by section and then by item id (both in order of appearence)
  -- Gather items grouped per section in order of their appearence
  local sections, section_order = {}, {}
  for _, item in ipairs(items) do
    local sec = item.section
    if section_order[sec] == nil then
      table.insert(sections, {})
      section_order[sec] = #sections
    end
    table.insert(sections[section_order[sec]], item)
  end

  -- Unroll items in depth-first fashion
  local res = {}
  for _, section_items in ipairs(sections) do
    for _, item in ipairs(section_items) do
      table.insert(res, item)
    end
  end

  return res
end

function H.items_highlight()
  for _, item in ipairs(H.items) do
    H.buf_hl(H.ns.general, 'MiniStarterItemPrefix', item._line, item._start_col, item._start_col + item._nprefix, 51)
  end
end

function H.next_active_item_id(item_id, direction)
  -- Advance in cyclic fashion
  local id = item_id
  local n_items = vim.tbl_count(H.items)
  local increment = direction == 'next' and 1 or (n_items - 1)

  -- Increment modulo `n` but for 1-based indexing
  id = math.fmod(id + increment - 1, n_items) + 1
  while not (H.items[id]._active or id == item_id) do
    id = math.fmod(id + increment - 1, n_items) + 1
  end

  return id
end

function H.position_cursor_on_current_item()
  vim.api.nvim_win_set_cursor(0, H.items[H.current_item_id]._cursorpos)
end

function H.item_is_active(item, query)
  -- Item is active = item's name starts with query (ignoring case) and item's
  -- action is non-empty
  return vim.startswith(item.name:lower(), query) and item.action ~= ''
end

-- Work with queries ----------------------------------------------------------
function H.make_query(query)
  -- Ignore case
  query = (query or H.query):lower()

  -- Don't make query if it results into no active items
  local n_active = 0
  for _, item in ipairs(H.items) do
    n_active = n_active + (H.item_is_active(item, query) and 1 or 0)
  end

  if n_active == 0 and query ~= '' then
    H.notify(('Query %s results into no active items. Current query: %s'):format(vim.inspect(query), H.query))
    return
  end

  -- Update current query and active items
  H.query = query
  for _, item in ipairs(H.items) do
    item._active = H.item_is_active(item, query)
  end

  -- Move to next active item if current is not active
  if not H.items[H.current_item_id]._active then
    MiniStarter.update_current_item('next')
  end

  -- Update activity highlighting. This should go before `evaluate_single`
  -- check because evaluation might not result into closing Starter buffer.
  vim.api.nvim_buf_clear_namespace(H.buf_id, H.ns.activity, 0, -1)
  H.add_hl_activity(query)

  -- Possibly evaluate single active item
  if MiniStarter.config.evaluate_single and n_active == 1 then
    MiniStarter.eval_current_item()
    return
  end

  -- Notify about new query if not in VimEnter, where it might lead to
  -- unpleasant flickering due to startup process (lazy loading, etc.).
  if not H.is_in_vimenter then
    local msg = ('Query: %s'):format(H.query)
    -- Use `echo` because it doesn't write to `:messages`.
    vim.cmd(([[echo '%s']]):format(vim.fn.escape(msg, "'")))
  end
end

-- Work with starter buffer ---------------------------------------------------
function H.make_buffer_autocmd()
  local command = string.format(
    [[augroup MiniStarterBuffer
        au!
        au VimResized <buffer> lua MiniStarter.refresh()
        au CursorMoved <buffer> lua MiniStarter.on_cursormoved()
        au BufLeave <buffer> echo ''
        au BufLeave <buffer> if &showtabline==1 | set showtabline=%s | endif
      augroup END]],
    vim.o.showtabline
  )
  vim.cmd(command)
end

function H.apply_buffer_options()
  -- Force Normal mode
  vim.cmd([[normal! <ESC>]])

  vim.api.nvim_buf_set_name(H.buf_id, 'DASHBOARD')
  -- Having `noautocmd` is crucial for performance: ~9ms without it, ~1.6ms with it
  vim.cmd([[noautocmd silent! set filetype=]])

  local options = {
    -- Taken from 'vim-startify'
    [[bufhidden=wipe]],
    [[colorcolumn=]],
    [[foldcolumn=0]],
    [[matchpairs=]],
    [[nobuflisted]],
    [[nocursorcolumn]],
    [[nocursorline]],
    [[nolist]],
    [[nonumber]],
    [[noreadonly]],
    [[norelativenumber]],
    [[noshowcmd]],
    [[nospell]],
    [[noswapfile]],
    [[signcolumn=no]],
    [[synmaxcol&]],
    -- Differ from 'vim-startify'
    [[buftype=nofile]],
    [[nomodeline]],
    [[nomodifiable]],
    [[foldlevel=999]],
  }
  -- Vim's `setlocal` is currently more robust comparing to `opt_local`
  vim.cmd(('silent! noautocmd setlocal %s'):format(table.concat(options, ' ')))

  -- Hide tabline on single tab by setting `showtabline` to default value (but
  -- not statusline as it weirdly feels 'naked' without it).
  vim.o.showtabline = 1

  -- Disable 'mini.cursorword'
  vim.b.minicursorword_disable = true
end

function H.apply_buffer_mappings()
  H.buf_keymap('<CR>', [[MiniStarter.eval_current_item()]])

  H.buf_keymap('<Up>', [[MiniStarter.update_current_item('prev')]])
  H.buf_keymap('<M-k>', [[MiniStarter.update_current_item('prev')]])
  H.buf_keymap('<Down>', [[MiniStarter.update_current_item('next')]])
  H.buf_keymap('<M-j>', [[MiniStarter.update_current_item('next')]])

  -- Make all special symbols to update query
  for _, key in ipairs(vim.split(MiniStarter.config.query_updaters, '')) do
    local key_string = vim.inspect(tostring(key))
    H.buf_keymap(key, ([[MiniStarter.add_to_query(%s)]]):format(key_string))
  end

  H.buf_keymap('<Esc>', [[MiniStarter.set_query('')]])
  H.buf_keymap('<BS>', [[MiniStarter.add_to_query()]])
  H.buf_keymap('<C-c>', [[MiniStarter.close()]])
end

function H.add_hl_activity(query)
  for _, item in ipairs(H.items) do
    local l = item._line
    local s = item._start_col
    local e = item._end_col
    if item._active then
      H.buf_hl(H.ns.activity, 'MiniStarterQuery', l, s, s + query:len(), 53)
    else
      H.buf_hl(H.ns.activity, 'MiniStarterInactive', l, s, e, 53)
    end
  end
end

function H.add_hl_current_item()
  local cur_item = H.items[H.current_item_id]
  H.buf_hl(H.ns.current_item, 'MiniStarterCurrent', cur_item._line, cur_item._start_col, cur_item._end_col, 52)
end

-- Predicates -----------------------------------------------------------------
function H.is_fun_or_string(x, allow_nil)
  if allow_nil == nil then
    allow_nil = true
  end
  return (allow_nil and x == nil) or type(x) == 'function' or type(x) == 'string'
end

function H.is_item(x)
  return type(x) == 'table'
    and H.is_fun_or_string(x['action'], false)
    and type(x['name']) == 'string'
    and type(x['section']) == 'string'
end

function H.is_something_shown()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  if #lines > 1 or (#lines == 1 and lines[1]:len() > 0) then
    return true
  end

  -- - Several buffers are listed (like session with placeholder buffers). That
  --   means unlisted buffers (like from `nvim-tree`) don't affect decision.
  local listed_buffers = vim.tbl_filter(function(buf_id)
    return vim.fn.buflisted(buf_id) == 1
  end, vim.api.nvim_list_bufs())
  if #listed_buffers > 1 then
    return true
  end

  -- - There are files in arguments (like `nvim foo.txt` with new file).
  if vim.fn.argc() > 0 then
    return true
  end

  return false
end

-- Utilities ------------------------------------------------------------------
function H.eval_fun_or_string(x, string_as_cmd)
  if type(x) == 'function' then
    return x()
  end
  if type(x) == 'string' then
    if string_as_cmd then
      vim.cmd(x)
    else
      return x
    end
  end
end

function H.buf_keymap(key, cmd)
  vim.api.nvim_buf_set_keymap(H.buf_id, 'n', key, ('<Cmd>lua %s<CR>'):format(cmd), { nowait = true, silent = true })
end

-- Use `priority` in Neovim 0.7 because of the regression bug (highlights are
-- not stacked properly): https://github.com/neovim/neovim/issues/17358
if vim.fn.has('nvim-0.7') == 1 then
  function H.buf_hl(ns_id, hl_group, line, col_start, col_end, priority)
    vim.highlight.range(H.buf_id, ns_id, hl_group, { line, col_start }, { line, col_end }, { priority = priority })
  end
else
  function H.buf_hl(ns_id, hl_group, line, col_start, col_end)
    vim.highlight.range(H.buf_id, ns_id, hl_group, { line, col_start }, { line, col_end })
  end
end

function H.notify(msg)
  vim.notify(('(mini.starter) %s'):format(msg))
end

function H.unique_nprefix(strings)
  local str_set = vim.deepcopy(strings)
  local res, cur_n = {}, 0
  while vim.tbl_count(str_set) > 0 do
    cur_n = cur_n + 1

    -- `prefix_tbl`: string id's with current prefix
    -- `nowhere_to_go` is `true` if all strings have lengths less than `cur_n`
    local prefix_tbl, nowhere_to_go = {}, true
    for id, s in pairs(str_set) do
      nowhere_to_go = nowhere_to_go and (#s < cur_n)
      local prefix = s:sub(1, cur_n)
      prefix_tbl[prefix] = prefix_tbl[prefix] == nil and {} or prefix_tbl[prefix]
      table.insert(prefix_tbl[prefix], id)
    end

    -- Output for non-unique string is its length
    if nowhere_to_go then
      for k, s in pairs(str_set) do
        res[k] = #s
      end
      break
    end

    for _, keys_with_prefix in pairs(prefix_tbl) do
      -- If prefix is seen only once, it is unique
      if #keys_with_prefix == 1 then
        local k = keys_with_prefix[1]
        -- Use `math.min` to account for empty strings and non-unique ones
        res[k] = math.min(#str_set[k], cur_n)
        -- Remove this string as it already has final nprefix
        str_set[k] = nil
      end
    end
  end

  return res
end

return MiniStarter.setup({
	items = {
     MiniStarter.sections.builtin_actions(),
     MiniStarter.sections.recent_files(5, false, false),
    },
})

EOF

" **/
" /** ----------> COMMENT

lua <<EOF

-- Module definition ==========================================================
local MiniComment = {}
local H = {}

function MiniComment.setup(config)
  -- Export module
  _G.MiniComment = MiniComment

  -- Setup config
  config = H.setup_config(config)

  -- Apply config
  H.apply_config(config)
end

--- Module config
---
--- Default values:
MiniComment.config = {
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Toggle comment (like `gcip` - comment inner paragraph) for both
    -- Normal and Visual modes
    comment = 'gc',

    -- Toggle comment on current line
    comment_line = 'gcc',

    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
    textobject = 'gc',
  },
  -- Hook functions to be executed at certain stage of commenting
  hooks = {
    -- Before successful commenting. Does nothing by default.
    pre = function() end,
    -- After successful commenting. Does nothing by default.
    post = function() end,
  },
}
function MiniComment.operator(mode)
  if H.is_disabled() then
    return ''
  end

  if mode == nil then
    vim.cmd('set operatorfunc=v:lua.MiniComment.operator')
    return 'g@'
  end

  local mark_left, mark_right = '[', ']'
  if mode == 'visual' then
    mark_left, mark_right = '<', '>'
  end

  local line_left, col_left = unpack(vim.api.nvim_buf_get_mark(0, mark_left))
  local line_right, col_right = unpack(vim.api.nvim_buf_get_mark(0, mark_right))

  if (line_left > line_right) or (line_left == line_right and col_left > col_right) then
    return
  end

  vim.cmd(string.format('lockmarks lua MiniComment.toggle_lines(%d, %d)', line_left, line_right))
  return ''
end

function MiniComment.toggle_lines(line_start, line_end)
  if H.is_disabled() then
    return
  end

  local n_lines = vim.api.nvim_buf_line_count(0)
  if not (1 <= line_start and line_start <= n_lines and 1 <= line_end and line_end <= n_lines) then
    error(('(mini.comment) `line_start` and `line_end` should be within range [1; %s].'):format(n_lines))
  end
  if not (line_start <= line_end) then
    error('(mini.comment) `line_start` should be less than or equal to `line_end`.')
  end

  MiniComment.config.hooks.pre()

  local comment_parts = H.make_comment_parts()
  local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)
  local indent, is_comment = H.get_lines_info(lines, comment_parts)

  local f
  if is_comment then
    f = H.make_uncomment_function(comment_parts)
  else
    f = H.make_comment_function(comment_parts, indent)
  end

  for n, l in pairs(lines) do
    lines[n] = f(l)
  end

  vim.api.nvim_buf_set_lines(0, line_start - 1, line_end, false, lines)

  MiniComment.config.hooks.post()
end

function MiniComment.textobject()
  if H.is_disabled() then
    return
  end

  MiniComment.config.hooks.pre()

  local comment_parts = H.make_comment_parts()
  local comment_check = H.make_comment_check(comment_parts)
  local line_cur = vim.api.nvim_win_get_cursor(0)[1]

  if comment_check(vim.fn.getline(line_cur)) then
    local line_start = line_cur
    while (line_start >= 2) and comment_check(vim.fn.getline(line_start - 1)) do
      line_start = line_start - 1
    end

    local line_end = line_cur
    local n_lines = vim.api.nvim_buf_line_count(0)
    while (line_end <= n_lines - 1) and comment_check(vim.fn.getline(line_end + 1)) do
      line_end = line_end + 1
    end

    vim.cmd(string.format('normal! %dGV%dG', line_start, line_end))
  end

  MiniComment.config.hooks.post()
end

-- Helper data ================================================================
-- Module default config
H.default_config = MiniComment.config

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
function H.setup_config(config)
  -- General idea: if some table elements are not present in user-supplied
  -- `config`, take them from default config
  vim.validate({ config = { config, 'table', true } })
  config = vim.tbl_deep_extend('force', H.default_config, config or {})

  -- Validate per nesting level to produce correct error message
  vim.validate({
    mappings = { config.mappings, 'table' },
    hooks = { config.hooks, 'table' },
  })

  vim.validate({
    ['mappings.comment'] = { config.mappings.comment, 'string' },
    ['mappings.comment_line'] = { config.mappings.comment_line, 'string' },
    ['mappings.textobject'] = { config.mappings.textobject, 'string' },
    ['hooks.pre'] = { config.hooks.pre, 'function' },
    ['hooks.post'] = { config.hooks.post, 'function' },
  })

  return config
end

function H.apply_config(config)
  MiniComment.config = config

  -- Make mappings
  H.map('n', config.mappings.comment, 'v:lua.MiniComment.operator()', { expr = true, desc = 'Comment' })
  H.map(
    'x',
    config.mappings.comment,
    -- Using `:<c-u>` instead of `<cmd>` as latter results into executing before
    -- proper update of `'<` and `'>` marks which is needed to work correctly.
    [[:<c-u>lua MiniComment.operator('visual')<cr>]],
    { desc = 'Comment selection' }
  )
  H.map('n', config.mappings.comment_line, 'v:lua.MiniComment.operator() . "_"', { expr = true, desc = 'Comment line' })
  H.map('o', config.mappings.textobject, [[<cmd>lua MiniComment.textobject()<cr>]], { desc = 'Comment textobject' })
end

function H.is_disabled()
  return vim.g.minicomment_disable == true or vim.b.minicomment_disable == true
end

-- Core implementations -------------------------------------------------------
function H.make_comment_parts()
  local cs = vim.api.nvim_buf_get_option(0, 'commentstring')

  if cs == '' then
    vim.notify([[(mini.comment) Option 'commentstring' is empty.]])
    return { left = '', right = '' }
  end

  local left, right = cs:match('^%s*(.-)%s*%%s%s*(.-)%s*$')
  return { left = left, right = right }
end

function H.make_comment_check(comment_parts)
  local l, r = comment_parts.left, comment_parts.right
  -- String is commented if it has structure:
  -- <space> <left> <anything> <right> <space>
  local regex = string.format([[^%%s-%s.*%s%%s-$]], vim.pesc(l), vim.pesc(r))

  return function(line)
    return line:find(regex) ~= nil
  end
end

function H.get_lines_info(lines, comment_parts)
  local n_indent, n_indent_cur = math.huge, math.huge
  local indent, indent_cur

  local is_comment = true
  local comment_check = H.make_comment_check(comment_parts)

  for _, l in pairs(lines) do
    -- Update lines indent: minimum of all indents except empty lines
    if n_indent > 0 then
      _, n_indent_cur, indent_cur = l:find('^(%s*)')
      -- Condition "current n-indent equals line length" detects empty line
      if (n_indent_cur < n_indent) and (n_indent_cur < l:len()) then
        -- NOTE: Copy of actual indent instead of recreating it with `n_indent`
        -- allows to handle both tabs and spaces
        n_indent = n_indent_cur
        indent = indent_cur
      end
    end

    -- Update comment info: lines are comment if every single line is comment
    if is_comment then
      is_comment = comment_check(l)
    end
  end

  -- `indent` can still be `nil` in case all `lines` are empty
  return indent or '', is_comment
end

function H.make_comment_function(comment_parts, indent)
  -- NOTE: this assumes that indent doesn't mix tabs with spaces
  local nonindent_start = indent:len() + 1

  local l, r = comment_parts.left, comment_parts.right
  local lpad = (l == '') and '' or ' '
  local rpad = (r == '') and '' or ' '

  local empty_comment = indent .. l .. r
  local nonempty_format = indent .. l:gsub('%%', '%%%%') .. lpad .. '%s' .. rpad .. r:gsub('%%', '%%%%')

  return function(line)
    -- Line is empty if it doesn't have anything except whitespace
    if line:find('^%s*$') ~= nil then
      -- If doesn't want to comment empty lines, return `line` here
      return empty_comment
    else
      return string.format(nonempty_format, line:sub(nonindent_start))
    end
  end
end

function H.make_uncomment_function(comment_parts)
  local l, r = comment_parts.left, comment_parts.right
  local lpad = (l == '') and '' or '[ ]?'
  local rpad = (r == '') and '' or '[ ]?'

  -- Usage of `lpad` and `rpad` as possbile single space enables uncommenting
  -- of commented empty lines without trailing whitespace (like '  #').
  local uncomment_regex = string.format([[^(%%s*)%s%s(.-)%s%s%%s-$]], vim.pesc(l), lpad, rpad, vim.pesc(r))

  return function(line)
    local indent, new_line = string.match(line, uncomment_regex)
    -- Return original if line is not commented
    if new_line == nil then
      return line
    end
    -- Remove indent if line is a commented empty line
    if new_line == '' then
      indent = ''
    end
    return ('%s%s'):format(indent, new_line)
  end
end

-- Utilities ------------------------------------------------------------------
function H.map(mode, key, rhs, opts)
  --stylua: ignore
  if key == '' then return end

  opts = vim.tbl_deep_extend('force', { noremap = true, silent = true }, opts or {})

  -- Use mapping description only in Neovim>=0.7
  if vim.fn.has('nvim-0.7') == 0 then
    opts.desc = nil
  end

  vim.api.nvim_set_keymap(mode, key, rhs, opts)
end

return MiniComment.setup()

EOF

" **/
" /** ----------> CURSORWORD

lua <<EOF

-- Module definition ==========================================================
local MiniCursorword = {}
local H = {}

function MiniCursorword.setup(config)
  -- Export module
  _G.MiniCursorword = MiniCursorword

  -- Setup config
  config = H.setup_config(config)

  -- Apply config
  H.apply_config(config)

  -- Module behavior
  vim.api.nvim_exec(
    [[augroup MiniCursorword
        au!
        au CursorMoved                   * lua MiniCursorword.auto_highlight()
        au InsertEnter,TermEnter,QuitPre * lua MiniCursorword.auto_unhighlight()
        au FileType TelescopePrompt let b:minicursorword_disable=v:true
      augroup END]],
    false
  )

  if vim.fn.exists('##ModeChanged') == 1 then
    vim.api.nvim_exec(
      -- Call `auto_highlight` on mode change to respect `minicursorword_disable`
      [[augroup MiniCursorword
          au ModeChanged *:[^i] lua MiniCursorword.auto_highlight()
        augroup END]],
      false
    )
  end

  -- Create highlighting
  vim.api.nvim_exec(
    [[hi default MiniCursorword cterm=underline gui=underline
      hi default link MiniCursorwordCurrent MiniCursorword]],
    false
  )
end

--- Module config
MiniCursorword.config = {
  -- Delay (in ms) between when cursor moved and when highlighting appeared
  delay = 100,
}
--minidoc_afterlines_end

-- Module functionality =======================================================
function MiniCursorword.auto_highlight()
  -- Stop any possible previous delayed highlighting
  H.timer:stop()

  if H.is_disabled() or not H.is_cursor_on_keyword() then
    H.unhighlight()
    return
  end

  -- Get current information
  local win_id = vim.api.nvim_get_current_win()
  local win_match = H.window_matches[win_id] or {}
  local curword = H.get_cursor_word()

  if win_match.word == curword then
    H.unhighlight(true)
    H.highlight(true)
    return
  end

  H.unhighlight()

  H.timer:start(
    MiniCursorword.config.delay,
    0,
    vim.schedule_wrap(function()
      -- Ensure that always only one word is highlighted
      H.unhighlight()
      H.highlight()
    end)
  )
end

function MiniCursorword.auto_unhighlight()
  -- Stop any possible previous delayed highlighting
  H.timer:stop()
  H.unhighlight()
end

-- Helper data ================================================================
-- Module default config
H.default_config = MiniCursorword.config

-- Delay timer
H.timer = vim.loop.new_timer()

H.window_matches = {}

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
function H.setup_config(config)
  vim.validate({ config = { config, 'table', true } })
  config = vim.tbl_deep_extend('force', H.default_config, config or {})

  vim.validate({ delay = { config.delay, 'number' } })

  return config
end

function H.apply_config(config)
  MiniCursorword.config = config
end

function H.is_disabled()
  return vim.g.minicursorword_disable == true or vim.b.minicursorword_disable == true
end

-- Highlighting ---------------------------------------------------------------
function H.highlight(only_current)
  local win_id = vim.api.nvim_get_current_win()
  if not vim.api.nvim_win_is_valid(win_id) then
    return
  end

  H.window_matches[win_id] = H.window_matches[win_id] or {}

  local match_id_current = vim.fn.matchadd('MiniCursorwordCurrent', [[\k*\%#\k*]], -1)
  H.window_matches[win_id].id_current = match_id_current

  -- Don't add main match id if not needed or if one is already present
  if only_current or H.window_matches[win_id].id ~= nil then
    return
  end

  local curword = H.get_cursor_word()
  local curpattern = string.format([[\V\<%s\>]], curword)

  -- Add match highlight with even lower priority for current word to be on top
  local match_id = vim.fn.matchadd('MiniCursorword', curpattern, -2)

  -- Store information about highlight
  H.window_matches[win_id].id = match_id
  H.window_matches[win_id].word = curword
end

function H.unhighlight(only_current)
  -- Don't do anything if there is no valid information to act upon
  local win_id = vim.api.nvim_get_current_win()
  local win_match = H.window_matches[win_id]
  if not vim.api.nvim_win_is_valid(win_id) or win_match == nil then
    return
  end

  pcall(vim.fn.matchdelete, win_match.id_current)
  H.window_matches[win_id].id_current = nil

  if not only_current then
    pcall(vim.fn.matchdelete, win_match.id)
    H.window_matches[win_id] = nil
  end
end

function H.is_cursor_on_keyword()
  local col = vim.fn.col('.')
  local curchar = vim.api.nvim_get_current_line():sub(col, col)

  return vim.fn.match(curchar, '[[:keyword:]]') >= 0
end

function H.get_cursor_word()
  return vim.fn.escape(vim.fn.expand('<cword>'), [[\/]])
end

return MiniCursorword.setup()

EOF

" **/
" /** ----------> INDENTSCOPE

lua <<EOF

-- Module definition ==========================================================
local MiniIndentscope = {}
local H = {}

--- Module setup
---
---@param config table Module config table. See |MiniIndentscope.config|.
---
---@usage `require('mini.indentscope').setup({})` (replace `{}` with your `config` table)
function MiniIndentscope.setup(config)
  -- Export module
  _G.MiniIndentscope = MiniIndentscope

  -- Setup config
  config = H.setup_config(config)

  -- Apply config
  H.apply_config(config)

  -- Module behavior
  vim.api.nvim_exec(
    [[augroup MiniIndentscope
        au!
        au CursorMoved,CursorMovedI                          * lua MiniIndentscope.auto_draw({ lazy = true })
        au TextChanged,TextChangedI,TextChangedP,WinScrolled * lua MiniIndentscope.auto_draw()
      augroup END]],
    false
  )

  if vim.fn.exists('##ModeChanged') == 1 then
    vim.api.nvim_exec(
      -- Call `auto_draw` on mode change to respect `miniindentscope_disable`
      [[augroup MiniIndentscope
          au ModeChanged *:* lua MiniIndentscope.auto_draw({ lazy = true })
        augroup END]],
      false
    )
  end

  -- Create highlighting
  vim.api.nvim_exec(
    [[hi default link MiniIndentscopeSymbol Delimiter
      hi MiniIndentscopePrefix guifg=NONE guibg=NONE gui=nocombine]],
    false
  )
end

--- Module config
---
--- Default values:
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
---@text # Options ~
---
--- - Options can be supplied globally (from this `config`), locally to buffer
---   (via `vim.b.miniindentscope_options` buffer variable), or locally to call
---   (as argument to |MiniIndentscope.get_scope()|).
---
--- - Option `border` controls which line(s) with smaller indent to categorize
---   as border. This matters for textobjects and motions.
---   It also controls how empty lines are treated: they are included in scope
---   only if followed by a border. Another way of looking at it is that indent
---   of blank line is computed based on value of `border` option.
---   Here is an illustration of how `border` works in presense of empty lines:
--- >
---                              |both|bottom|top|none|
---   1|function foo()           | 0  |  0   | 0 | 0  |
---   2|                         | 4  |  0   | 4 | 0  |
---   3|    print('Hello world') | 4  |  4   | 4 | 4  |
---   4|                         | 4  |  4   | 2 | 2  |
---   5|  end                    | 2  |  2   | 2 | 2  |
--- <
---   Numbers inside a table are indent values of a line computed with certain
---   value of `border`. So, for example, a scope with reference line 3 and
---   right-most column has body range depending on value of `border` option:
---     - `border` is "both":   range is 2-4, border is 1 and 5 with indent 2.
---     - `border` is "top":    range is 2-3, border is 1 with indent 0.
---     - `border` is "bottom": range is 3-4, border is 5 with indent 0.
---     - `border` is "none":   range is 3-3, border is empty with indent `nil`.
---
--- - Option `indent_at_cursor` controls if cursor position should affect
---   computation of scope. If `true`, reference indent is a minimum of
---   reference line's indent and cursor column. In main example, here how
---   scope's body range differs depending on cursor column and `indent_at_cursor`
---   value (assuming cursor is on line 3 and it is whole buffer):
--- >
---     Column\Option true|false
---        1 and 2    2-5 | 2-4
---      3 and more   2-4 | 2-4
--- <
--- - Option `try_as_border` controls how to act when input line can be
---   recognized as a border of some neighbor indent scope. In main example,
---   when input line is 1 and can be recognized as border for inner scope,
---   value `try_as_border = true` means that inner scope will be returned.
---   Similar, for input line 5 inner scope will be returned if it is
---   recognized as border.
MiniIndentscope.config = {
  draw = {
    -- Delay (in ms) between event and start of drawing scope indicator
    delay = 100,

    -- Animation rule for scope's first drawing. A function which, given next
    -- and total step numbers, returns wait time (in ms). See
    -- |MiniIndentscope.gen_animation()| for builtin options. To not use
    -- animation, supply `require('mini.indentscope').gen_animation('none')`.
    --minidoc_replace_start animation = --<function: implements constant 20ms between steps>,
    animation = function(s, n)
      return 20
    end,
    --minidoc_replace_end
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Textobjects
    object_scope = 'ii',
    object_scope_with_border = 'ai',

    -- Motions (jump to respective border line; if not present - body line)
    goto_top = '[i',
    goto_bottom = ']i',
  },

  -- Options which control computation of scope. Buffer local values can be
  -- supplied in buffer variable `vim.b.miniindentscope_options`.
  options = {
    -- Type of scope's border: which line(s) with smaller indent to
    -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
    border = 'both',

    -- Whether to use cursor column when computing reference indent. Useful to
    -- see incremental scopes with horizontal cursor movements.
    indent_at_cursor = true,

    -- Whether to first check input line to be a border of adjacent scope.
    -- Use it if you want to place cursor on function header to get scope of
    -- its body.
    try_as_border = false,
  },

  -- Which character to use for drawing scope indicator
  -- symbol = '╎',
  symbol = '|',
}


function MiniIndentscope.get_scope(line, col, opts)
  opts = H.get_opts(opts)

  -- Compute default `line` and\or `col`
  if not (line and col) then
    local curpos = vim.fn.getcurpos()

    line = line or curpos[2]
    line = opts.try_as_border and H.border_correctors[opts.border](line, opts) or line

    col = col or (opts.indent_at_cursor and curpos[5] or math.huge)
  end

  -- Compute "indent at column"
  local line_indent = H.get_line_indent(line, opts)
  local indent = math.min(col, line_indent)

  -- Make early return
  local body = { indent = indent }
  if indent <= 0 then
    body.top, body.bottom, body.indent = 1, vim.fn.line('$'), line_indent
  else
    local up_min_indent, down_min_indent
    body.top, up_min_indent = H.cast_ray(line, indent, 'up', opts)
    body.bottom, down_min_indent = H.cast_ray(line, indent, 'down', opts)
    body.indent = math.min(line_indent, up_min_indent, down_min_indent)
  end

  return {
    body = body,
    border = H.border_from_body[opts.border](body, opts),
    buf_id = vim.api.nvim_get_current_buf(),
    reference = { line = line, column = col, indent = indent },
  }
end

--- Auto draw scope indicator based on movement events
---
--- Designed to be used with |autocmd|. No need to use it directly, everything
--- is setup in |MiniIndentscope.setup|.
---
---@param opts table Options.
function MiniIndentscope.auto_draw(opts)
  if H.is_disabled() then
    H.undraw_scope()
    return
  end

  opts = opts or {}
  local scope = MiniIndentscope.get_scope()

  -- Make early return if nothing has to be done. Doing this before updating
  -- event id allows to not interrupt ongoing animation.
  if opts.lazy and H.current.draw_status ~= 'none' and H.scope_is_equal(scope, H.current.scope) then
    return
  end

  -- Account for current event
  local local_event_id = H.current.event_id + 1
  H.current.event_id = local_event_id

  -- Compute drawing options for current event
  local draw_opts = H.make_autodraw_opts(scope)

  -- Allow delay
  if draw_opts.delay > 0 then
    H.undraw_scope(draw_opts)
  end

  -- Use `defer_fn()` even if `delay` is 0 to draw indicator only after all
  -- events are processed (stops flickering)
  vim.defer_fn(function()
    if H.current.event_id ~= local_event_id then
      return
    end

    H.undraw_scope(draw_opts)

    H.current.scope = scope
    H.draw_scope(scope, draw_opts)
  end, draw_opts.delay)
end

function MiniIndentscope.draw(scope, opts)
  scope = scope or MiniIndentscope.get_scope()
  local draw_opts = vim.tbl_deep_extend('force', { animation_fun = MiniIndentscope.config.draw.animation }, opts or {})

  H.undraw_scope()

  H.current.scope = scope
  H.draw_scope(scope, draw_opts)
end

--- Undraw currently visible scope manually
function MiniIndentscope.undraw()
  H.undraw_scope()
end

function MiniIndentscope.gen_animation(easing, opts)
  --stylua: ignore start
  if easing == 'none' then
    return function() return 0 end
  end

  opts = vim.tbl_deep_extend('force', { duration = 20, unit = 'step' }, opts or {})
  if not vim.tbl_contains({'total', 'step'}, opts.unit) then
    H.message([[`opts.unit` should be one of 'step' or 'total'. Using 'step'.]])
    opts.unit = 'step'
  end

  local easing_calls = {
    linear           = {impl = H.animation_arithmetic_powers,  args = {0, 'in', opts}},
    quadraticIn      = {impl = H.animation_arithmetic_powers,  args = {1, 'in', opts}},
    quadraticOut     = {impl = H.animation_arithmetic_powers,  args = {1, 'out', opts}},
    quadraticInOut   = {impl = H.animation_arithmetic_powers,  args = {1, 'in-out', opts}},
    cubicIn          = {impl = H.animation_arithmetic_powers,  args = {2, 'in', opts}},
    cubicOut         = {impl = H.animation_arithmetic_powers,  args = {2, 'out', opts}},
    cubicInOut       = {impl = H.animation_arithmetic_powers,  args = {2, 'in-out', opts}},
    quarticIn        = {impl = H.animation_arithmetic_powers,  args = {3, 'in', opts}},
    quarticOut       = {impl = H.animation_arithmetic_powers,  args = {3, 'out', opts}},
    quarticInOut     = {impl = H.animation_arithmetic_powers,  args = {3, 'in-out', opts}},
    exponentialIn    = {impl = H.animation_geometrical_powers, args = {'in', opts}},
    exponentialOut   = {impl = H.animation_geometrical_powers, args = {'out', opts}},
    exponentialInOut = {impl = H.animation_geometrical_powers, args = {'in-out', opts}},
  }
  local allowed_easing_types = vim.tbl_keys(easing_calls)
  table.sort(allowed_easing_types)

  if not vim.tbl_contains(allowed_easing_types, easing) then
    H.message(('`easing` should be one of: %s.'):format(table.concat(allowed_easing_types, ', ')))
    return
  end

  local parts = easing_calls[easing]
  return parts.impl(unpack(parts.args))
  --stylua: ignore end
end

function MiniIndentscope.move_cursor(side, use_border, scope)
  scope = scope or MiniIndentscope.get_scope()

  -- This defaults to body's side if it is not present in border
  local target_line = use_border and scope.border[side] or scope.body[side]
  target_line = math.min(math.max(target_line, 1), vim.fn.line('$'))

  vim.api.nvim_win_set_cursor(0, { target_line, 0 })
  -- Move to first non-blank character to allow chaining scopes
  vim.cmd('normal! ^')
end

function MiniIndentscope.operator(side, add_to_jumplist)
  local scope = MiniIndentscope.get_scope()

  -- Don't support scope that can't be shown
  if H.scope_get_draw_indent(scope) < 0 then
    return
  end

  local count = vim.v.count1
  if add_to_jumplist then
    vim.cmd('normal! m`')
  end

  -- Make sequence of jumps
  for _ = 1, count do
    MiniIndentscope.move_cursor(side, true, scope)
    -- Use `try_as_border = false` to enable chaining
    scope = MiniIndentscope.get_scope(nil, nil, { try_as_border = false })

    -- Don't support scope that can't be shown
    if H.scope_get_draw_indent(scope) < 0 then
      return
    end
  end
end

function MiniIndentscope.textobject(use_border)
  local scope = MiniIndentscope.get_scope()

  -- Don't support scope that can't be shown
  if H.scope_get_draw_indent(scope) < 0 then
    return
  end

  -- Allow chaining only if using border
  local count = use_border and vim.v.count1 or 1

  -- Make sequence of incremental selections
  for _ = 1, count do
    -- Try finish cursor on border
    local start, finish = 'top', 'bottom'
    if use_border and scope.border.bottom == nil then
      start, finish = 'bottom', 'top'
    end

    H.exit_visual_mode()
    MiniIndentscope.move_cursor(start, use_border, scope)
    vim.cmd('normal! V')
    MiniIndentscope.move_cursor(finish, use_border, scope)

    -- Use `try_as_border = false` to enable chaining
    scope = MiniIndentscope.get_scope(nil, nil, { try_as_border = false })

    -- Don't support scope that can't be shown
    if H.scope_get_draw_indent(scope) < 0 then
      return
    end
  end
end

-- Helper data ================================================================
-- Module default config
H.default_config = MiniIndentscope.config

-- Namespace for drawing vertical line
H.ns_id = vim.api.nvim_create_namespace('MiniIndentscope')

-- Timer for doing animation
H.timer = vim.loop.new_timer()

H.current = { event_id = 0, scope = {}, draw_status = 'none' }

-- Functions to compute indent in ambiguous cases
H.indent_funs = {
  ['min'] = function(top_indent, bottom_indent)
    return math.min(top_indent, bottom_indent)
  end,
  ['max'] = function(top_indent, bottom_indent)
    return math.max(top_indent, bottom_indent)
  end,
  ['top'] = function(top_indent, bottom_indent)
    return top_indent
  end,
  ['bottom'] = function(top_indent, bottom_indent)
    return bottom_indent
  end,
}

-- Functions to compute indent of blank line to satisfy `config.options.border`
H.blank_indent_funs = {
  ['none'] = H.indent_funs.min,
  ['top'] = H.indent_funs.bottom,
  ['bottom'] = H.indent_funs.top,
  ['both'] = H.indent_funs.max,
}

-- Functions to compute border from body
H.border_from_body = {
  ['none'] = function(body, opts)
    return {}
  end,
  ['top'] = function(body, opts)
    return { top = body.top - 1, indent = H.get_line_indent(body.top - 1, opts) }
  end,
  ['bottom'] = function(body, opts)
    return { bottom = body.bottom + 1, indent = H.get_line_indent(body.bottom + 1, opts) }
  end,
  ['both'] = function(body, opts)
    return {
      top = body.top - 1,
      bottom = body.bottom + 1,
      indent = math.max(H.get_line_indent(body.top - 1, opts), H.get_line_indent(body.bottom + 1, opts)),
    }
  end,
}

-- Functions to correct line in case it is a border
H.border_correctors = {
  ['none'] = function(line, opts)
    return line
  end,
  ['top'] = function(line, opts)
    local cur_indent, next_indent = H.get_line_indent(line, opts), H.get_line_indent(line + 1, opts)
    return (cur_indent < next_indent) and (line + 1) or line
  end,
  ['bottom'] = function(line, opts)
    local prev_indent, cur_indent = H.get_line_indent(line - 1, opts), H.get_line_indent(line, opts)
    return (cur_indent < prev_indent) and (line - 1) or line
  end,
  ['both'] = function(line, opts)
    local prev_indent, cur_indent, next_indent =
      H.get_line_indent(line - 1, opts), H.get_line_indent(line, opts), H.get_line_indent(line + 1, opts)

    if prev_indent <= cur_indent and next_indent <= cur_indent then
      return line
    end

    -- If prev and next indents are equal and bigger than current, prefer next
    if prev_indent <= next_indent then
      return line + 1
    end

    return line - 1
  end,
}

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
function H.setup_config(config)
  -- General idea: if some table elements are not present in user-supplied
  -- `config`, take them from default config
  vim.validate({ config = { config, 'table', true } })
  config = vim.tbl_deep_extend('force', H.default_config, config or {})

  -- Validate per nesting level to produce correct error message
  vim.validate({
    draw = { config.draw, 'table' },
    mappings = { config.mappings, 'table' },
    options = { config.options, 'table' },
    symbol = { config.symbol, 'string' },
  })

  vim.validate({
    ['draw.delay'] = { config.draw.delay, 'number' },
    ['draw.animation'] = { config.draw.animation, 'function' },

    ['mappings.object_scope'] = { config.mappings.object_scope, 'string' },
    ['mappings.object_scope_with_border'] = { config.mappings.object_scope_with_border, 'string' },
    ['mappings.goto_top'] = { config.mappings.goto_top, 'string' },
    ['mappings.goto_bottom'] = { config.mappings.goto_bottom, 'string' },

    ['options.border'] = { config.options.border, 'string' },
    ['options.indent_at_cursor'] = { config.options.indent_at_cursor, 'boolean' },
    ['options.try_as_border'] = { config.options.try_as_border, 'boolean' },
  })
  return config
end

function H.apply_config(config)
  MiniIndentscope.config = config
  local maps = config.mappings

  --stylua: ignore start
  H.map('n', maps.goto_top, [[<Cmd>lua MiniIndentscope.operator('top', true)<CR>]], { desc = 'Go to indent scope top' })
  H.map('n', maps.goto_bottom, [[<Cmd>lua MiniIndentscope.operator('bottom', true)<CR>]], { desc = 'Go to indent scope bottom' })

  H.map('x', maps.goto_top, [[<Cmd>lua MiniIndentscope.operator('top')<CR>]], { desc = 'Go to indent scope top' })
  H.map('x', maps.goto_bottom, [[<Cmd>lua MiniIndentscope.operator('bottom')<CR>]], { desc = 'Go to indent scope bottom' })
  H.map('x', maps.object_scope, '<Cmd>lua MiniIndentscope.textobject(false)<CR>', { desc = 'Object scope' })
  H.map('x', maps.object_scope_with_border, '<Cmd>lua MiniIndentscope.textobject(true)<CR>', { desc = 'Object scope with border' })

  H.map('o', maps.goto_top, [[<Cmd>lua MiniIndentscope.operator('top')<CR>]], { desc = 'Go to indent scope top' })
  H.map('o', maps.goto_bottom, [[<Cmd>lua MiniIndentscope.operator('bottom')<CR>]], { desc = 'Go to indent scope bottom' })
  H.map('o', maps.object_scope, '<Cmd>lua MiniIndentscope.textobject(false)<CR>', { desc = 'Object scope' })
  H.map('o', maps.object_scope_with_border, '<Cmd>lua MiniIndentscope.textobject(true)<CR>', { desc = 'Object scope with border' })
  --stylua: ignore start
end

function H.is_disabled()
  return vim.g.miniindentscope_disable == true or vim.b.miniindentscope_disable == true
end

function H.get_opts(opts)
  local opts_local = vim.b.miniindentscope_options
  local opts_global = MiniIndentscope.config.options
  return vim.tbl_deep_extend('force', opts_global, opts_local or {}, opts or {})
end

-- Scope ----------------------------------------------------------------------
function H.get_line_indent(line, opts)
  local prev_nonblank = vim.fn.prevnonblank(line)
  local res = vim.fn.indent(prev_nonblank)

  -- Compute indent of blank line depending on `options.border` values
  if line ~= prev_nonblank then
    local next_indent = vim.fn.indent(vim.fn.nextnonblank(line))
    local blank_rule = H.blank_indent_funs[opts.border]
    res = blank_rule(res, next_indent)
  end

  return res
end

function H.cast_ray(line, indent, direction, opts)
  local final_line, increment = 1, -1
  if direction == 'down' then
    final_line, increment = vim.fn.line('$'), 1
  end

  local min_indent = math.huge
  for l = line, final_line, increment do
    local new_indent = H.get_line_indent(l + increment, opts)
    if new_indent < indent then
      return l, min_indent
    end
    if new_indent < min_indent then
      min_indent = new_indent
    end
  end

  return final_line, min_indent
end

function H.scope_get_draw_indent(scope)
  return scope.border.indent or (scope.body.indent - 1)
end

function H.scope_is_equal(scope_1, scope_2)
  if type(scope_1) ~= 'table' or type(scope_2) ~= 'table' then
    return false
  end

  return scope_1.buf_id == scope_2.buf_id
    and H.scope_get_draw_indent(scope_1) == H.scope_get_draw_indent(scope_2)
    and scope_1.body.top == scope_2.body.top
    and scope_1.body.bottom == scope_2.body.bottom
end

function H.scope_has_intersect(scope_1, scope_2)
  if type(scope_1) ~= 'table' or type(scope_2) ~= 'table' then
    return false
  end
  if (scope_1.buf_id ~= scope_2.buf_id) or (H.scope_get_draw_indent(scope_1) ~= H.scope_get_draw_indent(scope_2)) then
    return false
  end

  local body_1, body_2 = scope_1.body, scope_2.body
  return (body_2.top <= body_1.top and body_1.top <= body_2.bottom)
    or (body_1.top <= body_2.top and body_2.top <= body_1.bottom)
end

-- Indicator ------------------------------------------------------------------
function H.indicator_compute(scope)
  scope = scope or H.current.scope
  local indent = H.scope_get_draw_indent(scope)

  -- Don't draw indicator that should be outside of screen. This condition is
  -- (perpusfully) "responsible" for not drawing indicator spanning whole file.
  if indent < 0 then
    return {}
  end

  local leftcol = vim.fn.winsaveview().leftcol
  if indent < leftcol then
    return {}
  end

  local virt_text = { { MiniIndentscope.config.symbol, 'MiniIndentscopeSymbol' } }
  local prefix = string.rep(' ', indent - leftcol)
  -- Currently Neovim doesn't work when text for extmark is empty string
  if prefix:len() > 0 then
    table.insert(virt_text, 1, { prefix, 'MiniIndentscopePrefix' })
  end

  local top = scope.body.top
  local bottom = scope.body.bottom

  return { buf_id = vim.api.nvim_get_current_buf(), virt_text = virt_text, top = top, bottom = bottom }
end

-- Drawing --------------------------------------------------------------------
function H.draw_scope(scope, opts)
  scope = scope or {}
  opts = opts or {}

  local indicator = H.indicator_compute(scope)

  -- Don't draw anything if nothing to be displayed
  if indicator.virt_text == nil or #indicator.virt_text == 0 then
    H.current.draw_status = 'finished'
    return
  end

  -- Make drawing function
  local draw_fun = H.make_draw_function(indicator, opts)

  -- Perform drawing
  H.current.draw_status = 'drawing'
  H.draw_indicator_animation(indicator, draw_fun, opts.animation_fun)
end

function H.draw_indicator_animation(indicator, draw_fun, animation_fun)
  -- Draw from origin (cursor line but wihtin indicator range)
  local top, bottom = indicator.top, indicator.bottom
  local origin = math.min(math.max(vim.fn.line('.'), top), bottom)

  local step = 0
  local n_steps = math.max(origin - top, bottom - origin)
  local wait_time = 0

  local draw_step
  draw_step = vim.schedule_wrap(function()
    -- Check for not drawing outside of interval is done inside `draw_fun`
    local success = draw_fun(origin - step)
    if step > 0 then
      success = success and draw_fun(origin + step)
    end

    if not success or step == n_steps then
      H.current.draw_status = step == n_steps and 'finished' or H.current.draw_status
      H.timer:stop()
      return
    end

    step = step + 1
    wait_time = wait_time + animation_fun(step, n_steps)

    if wait_time < 1 then
      H.timer:set_repeat(0)
      -- Use `return` to make this proper "tail call"
      return draw_step()
    else
      H.timer:set_repeat(wait_time)

      -- Restart `wait_time` only if it is actually used
      wait_time = 0

      H.timer:again()
    end
  end)

  H.timer:start(10000000, 0, draw_step)

  -- Draw step zero (at origin) immediately
  draw_step()
end

function H.undraw_scope(opts)
  opts = opts or {}

  -- Don't operate outside of current event if able to verify
  if opts.event_id and opts.event_id ~= H.current.event_id then
    return
  end

  pcall(vim.api.nvim_buf_clear_namespace, H.current.scope.buf_id or 0, H.ns_id, 0, -1)

  H.current.draw_status = 'none'
  H.current.scope = {}
end

function H.make_autodraw_opts(scope)
  local res = {
    event_id = H.current.event_id,
    type = 'animation',
    delay = MiniIndentscope.config.draw.delay,
    animation_fun = MiniIndentscope.config.draw.animation,
  }

  if H.current.draw_status == 'none' then
    return res
  end

  -- Draw immediately scope which intersects (same indent, overlapping ranges)
  -- currently drawn or finished. This is more natural when typing text.
  if H.scope_has_intersect(scope, H.current.scope) then
    res.type = 'immediate'
    res.delay = 0
    res.animation_fun = MiniIndentscope.gen_animation('none')
    return res
  end

  return res
end

function H.make_draw_function(indicator, opts)
  local extmark_opts = {
    hl_mode = 'combine',
    priority = 2,
    right_gravity = false,
    virt_text = indicator.virt_text,
    virt_text_pos = 'overlay',
  }

  local current_event_id = opts.event_id

  return function(l)
    -- Don't draw if outdated
    if H.current.event_id ~= current_event_id and current_event_id ~= nil then
      return false
    end

    -- Don't draw if disabled
    if H.is_disabled() then
      return false
    end

    -- Don't put extmark outside of indicator range
    if not (indicator.top <= l and l <= indicator.bottom) then
      return true
    end

    return pcall(vim.api.nvim_buf_set_extmark, indicator.buf_id, H.ns_id, l - 1, 0, extmark_opts)
  end
end

-- Animations -----------------------------------------------------------------
function H.animation_arithmetic_powers(power, type, opts)
  --stylua: ignore start
  local arith_power_sum = ({
    [0] = function(n_steps) return n_steps end,
    [1] = function(n_steps) return n_steps * (n_steps + 1) / 2 end,
    [2] = function(n_steps) return n_steps * (n_steps + 1) * (2 * n_steps + 1) / 6 end,
    [3] = function(n_steps) return n_steps ^ 2 * (n_steps + 1) ^ 2 / 4 end,
  })[power]
  --stylua: ignore end

  local duration_unit, duration_value = opts.unit, opts.duration
  local make_delta = function(n_steps, is_in_out)
    local total_time = duration_unit == 'total' and duration_value or (duration_value * n_steps)
    local total_parts
    if is_in_out then
      total_parts = 2 * arith_power_sum(math.ceil(0.5 * n_steps)) - (n_steps % 2 == 1 and 1 or 0)
    else
      total_parts = arith_power_sum(n_steps)
    end
    return total_time / total_parts
  end

  return ({
    ['in'] = function(s, n)
      return make_delta(n) * (n - s + 1) ^ power
    end,
    ['out'] = function(s, n)
      return make_delta(n) * s ^ power
    end,
    ['in-out'] = function(s, n)
      local n_half = math.ceil(0.5 * n)
      local s_halved
      if n % 2 == 0 then
        s_halved = s <= n_half and (n_half - s + 1) or (s - n_half)
      else
        s_halved = s < n_half and (n_half - s + 1) or (s - n_half + 1)
      end
      return make_delta(n, true) * s_halved ^ power
    end,
  })[type]
end

function H.animation_geometrical_powers(type, opts)
  local duration_unit, duration_value = opts.unit, opts.duration
  local make_delta = function(n_steps, is_in_out)
    local total_time = duration_unit == 'step' and (duration_value * n_steps) or duration_value
    -- Exact solution to avoid possible (bad) approximation
    if n_steps == 1 then
      return total_time + 1
    end
    if is_in_out then
      local n_half = math.ceil(0.5 * n_steps)
      if n_steps % 2 == 1 then
        total_time = total_time + math.pow(0.5 * total_time + 1, 1 / n_half) - 1
      end
      return math.pow(0.5 * total_time + 1, 1 / n_half)
    end
    return math.pow(total_time + 1, 1 / n_steps)
  end

  return ({
    ['in'] = function(s, n)
      local delta = make_delta(n)
      return (delta - 1) * delta ^ (n - s)
    end,
    ['out'] = function(s, n)
      local delta = make_delta(n)
      return (delta - 1) * delta ^ (s - 1)
    end,
    ['in-out'] = function(s, n)
      local n_half, delta = math.ceil(0.5 * n), make_delta(n, true)
      local s_halved
      if n % 2 == 0 then
        s_halved = s <= n_half and (n_half - s) or (s - n_half - 1)
      else
        s_halved = s < n_half and (n_half - s) or (s - n_half)
      end
      return (delta - 1) * delta ^ s_halved
    end,
  })[type]
end

-- Utilities ------------------------------------------------------------------
function H.message(msg)
  vim.cmd('echomsg ' .. vim.inspect('(mini.indentscope) ' .. msg))
end

function H.map(mode, key, rhs, opts)
  --stylua: ignore
  if key == '' then return end

  opts = vim.tbl_deep_extend('force', { noremap = true, silent = true }, opts or {})

  -- Use mapping description only in Neovim>=0.7
  if vim.fn.has('nvim-0.7') == 0 then
    opts.desc = nil
  end

  vim.api.nvim_set_keymap(mode, key, rhs, opts)
end

function H.exit_visual_mode()
  local ctrl_v = vim.api.nvim_replace_termcodes('<C-v>', true, true, true)
  local cur_mode = vim.fn.mode()
  if cur_mode == 'v' or cur_mode == 'V' or cur_mode == ctrl_v then
    vim.cmd('normal! ' .. cur_mode)
  end
end

return MiniIndentscope.setup()

EOF

" **/
" **/

" /** ----- ##### OTHERS ####### 
" /** ----------> LINE NUMBER 
set cursorline

highlight CursorLine guibg=#1a1b26
highlight CursorLineNr guibg=#212330 guifg=#c0caf5
autocmd InsertEnter * highlight CursorLineNr guibg=#f7768e guifg=#1a1b26
autocmd InsertLeave * highlight CursorLineNr guibg=#212330 guifg=#c0caf5
" **/
" /** ----------> STATUSLINE  
function! Statusline()

hi Base guibg=#15161E guifg=#c0caf5 gui=bold
hi Mode guibg=#7aa2f7 guifg=#1a1b26 gui=bold 
hi Indicator guibg=#15161E guifg=#7aa2f7 gui=bold 

function! ModeColor()
  let l:modecolor=mode()
  if l:modecolor==#"n" " Normal
    hi Mode guibg=#7aa2f7 
    hi Indicator guifg=#7aa2f7
  elseif l:modecolor==#"i" " Insert
    hi Mode guibg=#f7768e
    hi Indicator guifg=#f7768e
  elseif l:modecolor==#"c" " Command 
    hi Mode guibg=#9ece6a 
    hi Indicator guifg=#9ece6a
  elseif l:modecolor==#"R" || l:modecolor==#"Rv"
    hi Mode guibg=#bb9af7
    hi Indicator guifg=#bb9af7
  elseif l:modecolor==#"v" || l:modecolor==#"V" || l:modecolor==#"\<C-V>"
    hi Mode guibg=#ff9e64 
    hi Indicator guifg=#ff9e64
  endif
endfunction

  let g:currentmode={
				\  'n'      : 'NORMAL ',
				\  'no'     : 'O·P ',
				\  'v'      : 'VISUAL ',
				\  'V'      : 'V·LINE ',
				\  "\<C-V>" : 'V·BLOCK ',
				\  's'      : 'SELECT ',
				\  'i'      : 'INSERT ',
				\  'R'      : 'REPLACE ',
				\  'Rv'     : 'V·REPLACE ',
				\  'c'      : 'COMMAND ',
				\  'r'      : 'PROMPT ',
				\  'rm'     : 'MORE ',
				\  'r?'     : 'CONFIRM ',
				\  '!'      : 'SHELL ',
				\  't'      : 'TERMINAL '
				\}

  let g:modeindicator={
				\  'n'      : '<|',
				\  'no'     : '<|',
				\  'i'      : '|>',
				\  'v'      : '<>',
				\  'V'      : '<>',
				\  "\<C-V>" : '<>',
				\  's'      : '<>',
				\  'R'      : '<>',
				\  'Rv'     : '<>',
				\  'c'      : '|>',
				\  'r'      : '<>',
				\  'rm'     : '<>',
				\  'r?'     : '<>',
				\  '!'      : '<|',
				\  't'      : '<|'
				\}

	let statusline = ""
	let statusline .= "%#Mode#"
	let statusline .= "\ %{(g:currentmode[mode()])}"
	let statusline .= "%#Indicator#"
	let statusline .= "\ %{(g:modeindicator[mode()])}"
	let statusline .= "%#Base#"
	let statusline .= "\ %f"
	let statusline .= "\ %{&modified?'●':''}" 
	let statusline .= "%="
	let statusline .= "\ %{toupper(&filetype)}\ "
	let statusline .= "%#Mode# %l/%L "

	call ModeColor()
	return statusline
endfunction

set statusline=%!Statusline()

" **/
" /** ----------> NETRW  
let g:netrw_winsize = 20 
let g:netrw_banner = 0
" **/
" **/
 
