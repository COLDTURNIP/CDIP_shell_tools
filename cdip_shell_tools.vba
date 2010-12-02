" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
plugin/cdip_shell_tool.vim	[[[1
53
"
" Try to load Cscope tags under the codebase's local setting
"
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB == ""
        let mysrctop = $CDIP_TOP
        let mytagpath = $CDIP_TAG_PATH
        if filereadable(mytagpath."/cscope_c.out")
            autocmd BufRead *.c    exec("cs add ".mytagpath."/cscope_c.out ".mysrctop)
            autocmd BufRead *.cpp  exec("cs add ".mytagpath."/cscope_c.out ".mysrctop)
            autocmd BufRead *.h    exec("cs add ".mytagpath."/cscope_c.out ".mysrctop)
        endif
        if filereadable(mytagpath."/cscope_j.out")
            autocmd BufRead *.java exec("cs add ".mytagpath."/cscope_j.out ".mysrctop)
        endif
        if filereadable(mytagpath."/cscope.out")
            autocmd BufRead *.java exec("cs add ".mytagpath."/cscope.out ".mysrctop)
        endif
    else
        cs add $CSCOPE_DB
    endif
endif


"
" Try to load ctags tag files under the codebase's local setting.
"

" add any database in current directory
if filereadable("tags")
    set tag=tags
" else add database pointed to by environment
else
    let mysrctop = $CDIP_TOP
    if filereadable(mysrctop."/.cdip_tags_c")
        autocmd BufRead *.c    exec("set tag=".mysrctop."/.cdip_tags_c")
        autocmd BufRead *.cpp  exec("set tag=".mysrctop."/.cdip_tags_c")
        autocmd BufRead *.h    exec("set tag=".mysrctop."/.cdip_tags_c")
    endif
    if filereadable(mysrctop."/.cdip_tags_j")
        autocmd BufRead *.java exec("set tag=".mysrctop."/.cdip_tags_j ")
    endif
    if filereadable(mysrctop."/tags")
        set tag=mysrctop."/tags"
    endif
endif
