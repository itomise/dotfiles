" Key mappings
imap jj <Esc>      " Map jj to Escape in insert mode

" Close current workspace
exmap wq obcommand workspace:close
exmap q obcommand workspace:close

" Focus pane movements using Shift + hjkl
exmap focusRight obcommand editor:focus-right
nmap <S-l> :focusRight

exmap focusLeft obcommand editor:focus-left
nmap <S-h> :focusLeft

exmap focusTop obcommand editor:focus-top
nmap <S-k> :focusTop

exmap focusBottom obcommand editor:focus-bottom
nmap <S-j> :focusBottom

" Tab navigation using Control + jk
exmap tabprev obcommand workspace:previous-tab
nmap <C-j> :tabprev
exmap tabnext obcommand workspace:next-tab
nmap <C-k> :tabnext

" History navigation using Control + hl
exmap back obcommand app:go-back
nmap <C-h> :back
exmap forward obcommand app:go-forward
nmap <C-l> :forward

" Use ; as :
nmap ; :

" System clipboard support
set clipboard=unnamed
