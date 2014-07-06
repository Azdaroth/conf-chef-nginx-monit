bash 'add repo for Nginx' do
  user 'root'
  code <<-CODE
    add-apt-repository ppa:nginx/stable
    apt-get update
  CODE
end

package "nginx"

template "/etc/nginx/nginx.conf" do
  owner "root"
  group "root"
  mode "0644"
  source "nginx.conf.erb"
  notifies :run, "execute[nginx-restart]", :immediately
end

execute "nginx-restart" do
  command "/etc/init.d/nginx restart"
  action :nothing
end