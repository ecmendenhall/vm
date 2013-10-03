package "git-core"

user = node[:git][:user]
home_dir = node[:git][:home_dir]

template "#{home_dir}/.gitconfig" do
  owner user
  group user
  variables :full_name => node[:git][:full_name],
            :email => node[:git][:email]
end

cookbook_file "#{home_dir}/.gitignore_global" do
  owner user
  group user
end
