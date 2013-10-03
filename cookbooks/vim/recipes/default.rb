package "vim-nox"

user = node[:vim][:user]
home_dir = node[:vim][:home_dir]
vim_dir = "#{home_dir}/.vim"

git vim_dir do
  repository "https://github.com/trptcolin/vimfiles.git"
  reference "master"
  action :sync
end

bash "chown vimdir, because of CHEF-3940" do
  code "chown #{user}:#{user} #{vim_dir}"
end

bash "update bundle" do
  environment({"HOME" => home_dir})
  code <<-EOF
    cd #{vim_dir}
    ruby update_bundles
  EOF
end

bash "build command-t" do
  code <<-EOF
    cd #{vim_dir}/bundle/Command-T/ruby/command-t
    ruby extconf.rb
    make clean
    make
  EOF
end

link "#{home_dir}/.vimrc" do
  to "#{vim_dir}/.vimrc"
  owner user
  group user
end
