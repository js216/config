execute "runtime! syntax/" . "tex" . ".vim"

if exists("b:current_syntax")
   unlet b:current_syntax
endif

syntax match codeChunkStart "^<<.*>>=$" display
syntax match codeChunkEnd "^@$" display

highlight link codeChunkStart Type
highlight link codeChunkEnd Type

execute "syntax include @Code syntax/" . "verilog" . ".vim"
syntax region codeChunk start="^<<.*>>=$" end="^@$" contains=@Code containedin=ALL keepend
