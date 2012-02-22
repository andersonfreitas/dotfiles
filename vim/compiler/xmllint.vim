" Vim compiler file
" Compiler:     xmllint
" Maintainer:   Doug Kearns <djkea2@mugca.its.monash.edu.au>
" URL:          http://mugca.its.monash.edu.au/~djkea2/vim/compiler/xmllint.vim
" Last Change:  2004 Mar 27 (Modified 2012-02-21)

if exists("current_compiler")
  finish
endif
let current_compiler = "xmllint"

if exists(":CompilerSet") != 2          " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

"CompilerSet makeprg=xmllint\ --valid\ --noout\ --schema\ \"lib/odm/xsd/medscale-odm.xsd\"\ %
"CompilerSet makeprg=xmllint\ --xinclude\ --noout\ --postvalid\ . shellescape(expand("%:p"))
let makeprg="xmllint --xinclude --noout --postvalid " . shellescape(expand("%:p"))

" Doesn't work
"CompilerSet errorformat=%E%f:%l:\ error:\ %m,
                    "\%E%f:%l:\ parser\ error\ :\ %m,
                    "\%W%f:%l:\ warning:\ %m,
                    "\%E%f:%l:\ validity\ error\ :\ %m,
                    "\%W%f:%l:\ validity\ warning\ :\ %m,
                    "\%-Z%p^,
                    "\%-G%.%#

" Consider that every line is an error (wrong)
"CompilerSet errorformat=%E%f:%l:\ %m
"CompilerSet errorformat=%f:%l:\ %m
CompilerSet errorformat=%A%f:%l:\ %.%#error\ :\ %m,%-Z%p^,%-C%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

