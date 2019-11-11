class CategoryGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def generate_articles
    generate 'scaffold Article title:string content:text pagecount:integer published:boolean published_at:datetime category:references user:references'
  end

  def remove_articles_model
    remove_file 'app/models/article.rb'
  end

  def copy_article_model
      template "article.rb", "app/models/article.rb"
  end

  def create_category_model
    generate 'model Category name:string'
  end

  def rake_category_model
    rake 'db:migrate'
  end

  def add_assosiation
    insert_into_file "app/models/category.rb", "\thas_many :articles\n", :after => "class Category < ApplicationRecord\n"
  end

  def remove_article_controller
    remove_file 'app/controllers/articles_controller.rb'
  end

  def replace_article_conroller
    template "articles_controller.rb", "app/controllers/articles_controller.rb"
  end

  def remove_category_model
    remove_file 'app/models/category.rb'
  end

  def copy_categorys_template
    template "category.rb", "app/models/category.rb"
  end

  def remove_nav
    remove_file 'app/views/layouts/_nav.html.erb'
  end

  def add_nav
    template "_nav.html.erb", "app/views/layouts/_nav.html.erb"
  end

  def remove_form
    remove_file "app/views/articles/_form.html.erb"
  end

  def add_form
    copy_file "_form.html.erb", "app/views/articles/_form.html.erb"
  end

end
