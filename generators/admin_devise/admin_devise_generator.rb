class AdminDeviseGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  def devise_install
    generate "devise:install"
  end

  def create_model
    generate "devise User"
  end

  def create_views
    generate "devise:views users"
  end

  def create_controllers
    generate "devise:controllers users"
  end

  def copy_partial_file
    copy_file "_admin.html.erb", "app/views/layouts/_admin.html.erb"
  end

  def create_nav_links
    insert_into_file "app/views/layouts/_nav.html.erb", "<%= render 'layouts/_admin.html.erb' %>", :before => "</ul>"
  end

end
