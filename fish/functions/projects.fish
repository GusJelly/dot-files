function projects
  set oldDir $(pwd)
  cd ~/projects

  set selected $(ls | fzf)

  if [ -z $selected ]    # '-z' checks if $selected is empty
    cd $oldDir
  else
    cd "$HOME/projects/$selected"
    clear
    fish_prompt
  end

end
