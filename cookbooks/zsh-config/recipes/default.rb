home_dir = node[:zsh][:home_dir]
username = node[:zsh][:username]

zsh_files_dir = "#{home_dir}/.zsh"

directory zsh_files_dir do
  user username
  group username
end

git "#{home_dir}/.oh-my-zsh" do
  repository "git://github.com/robbyrussell/oh-my-zsh.git"
  reference "master"
  revision "bc3cadf5c83697c176c9d"
  action :sync
end

git "#{zsh_files_dir}/zsh-syntax-highlighting" do
  repository 'https://github.com/zsh-users/zsh-syntax-highlighting.git'
  reference 'master'
  action :sync
end

cookbook_file "#{home_dir}/.zsh/zsh-syntax-highlighting.zsh" do
  owner username
  group username
end

cookbook_file "#{home_dir}/.zshrc" do
  owner username
  group username
end

bash 'make ZSH the default login shell' do
  code "sudo chsh -s `which zsh` #{username}"
end
