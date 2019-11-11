class ImageableGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def create_migration
    generate "model Picture name:text imageable:references{polymorphic}"
  end

  def rake_db
    rake 'db:migrate'
  end

  def add_concern
    copy_file "imageable.rb", "app/models/concerns/imageable.rb"
  end

end
