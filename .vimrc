vim.g.mapleader = " "
nnoremap <leader>pv :Explore<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap J mzJ`z
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" greatest remap ever
xnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
noremap <leader>y "+y
noremap <leader>Y "+Y

noremap <leader>d "_d

" This is going to get me cancelled
inoremap <C-c> <Esc>

noremap Q <nop>
nnoremap <leader>f :lua vim.lsp.buf.format()<CR>

noremap <C-k> :cnext<CR>zz
noremap <C-j> :cprev<CR>zz
noremap <leader>k :lnext<CR>zz
noremap <leader>j :lprev<CR>zz

noremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
noremap <leader>x :!chmod +x %<CR>

nnoremap <leader>mr :CellularAutomaton make_it_rain<CR>

nnoremap <leader><leader> :so %

nnoremap <leader>f ?Prettier<CR>
