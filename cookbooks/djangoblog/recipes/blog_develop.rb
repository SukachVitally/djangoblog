home_dir = node[:home_dir]
dev_owner = node[:dev_owner]

directory "#{home_dir}" do
    owner dev_owner
    mode '0777'
    action :create
end

execute 'venv init' do
  user dev_owner
  command "virtualenv #{home_dir}venvs/djangoblog"
  action :run
end
Chef::Log.warn("Virtualenv directory created")

template "/home/vagrant/start.sh" do
    source 'start.sh.erb'
    mode '0755'
    owner dev_owner
    variables(
        :home_dir => home_dir
    )
end

