# Add the current directory to the path Thor uses
# to look up files
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

# ------------------------------------------------------------------------------
# Gem file
# ------------------------------------------------------------------------------

# remove old gem file and create new one
remove_file "Gemfile"
run "touch Gemfile"
add_source 'https://rubygems.org'
gem 'rails'
gem 'sqlite3'
gem 'devise'
gem 'susy', '2.2.12'
gem 'will_paginate'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'devise'
gem 'sass-rails', '~> 4.0.0'
gem 'sprockets', '2.11.0'
gem 'sdoc', group: :doc
gem_group :development, :test do
  gem 'admin_scaffold'
  gem 'quiet_assets'
  gem 'pry-rails'
  gem 'byebug'
  gem 'awesome_print'
end

# run 'bundle update'

# ------------------------------------------------------------------------------
# Readme
# ------------------------------------------------------------------------------

# remove readme and replace with markdown
remove_file 'README.rdoc'
create_file 'README.md' do <<-TEXT
  #My Porject!
  Created with the help of Rails application templates
  TEXT
end

# ------------------------------------------------------------------------------
# Gitignore
# ------------------------------------------------------------------------------

# remove gitignore and replace with template ignore.
remove_file ".gitignore"
copy_file ".gitignore"

# ------------------------------------------------------------------------------
# remove directorys
# ------------------------------------------------------------------------------

# remove standard assest and layouts
remove_dir 'app/assets'
remove_dir 'app/views/layouts'
remove_dir 'app/helpers'

# ------------------------------------------------------------------------------
# copy template directorys to root
# ------------------------------------------------------------------------------
directory "assets", "app/assets"
directory "layouts", "app/views/layouts"
directory "helpers", "app/helpers"

# ------------------------------------------------------------------------------
# link custom assets and layouts
# ------------------------------------------------------------------------------
#link_file "assets", "app/assets"
#link_file "layouts", "app/views/layouts"
#link_file "helpers", "app/helpers"


# ------------------------------------------------------------------------------
# config assets test framework
# ------------------------------------------------------------------------------
insert_into_file('config/application.rb', "\n\t\tconfig.generators do |g|\n
  \t\tuser config active record
  \t\tg.orm :active_record\n
  \t\tuser config template engine
  \t\tg.template_engine :erb\n
  \t\tuser config no test_framework,
  \t\tg.test_framework :test_unit, fixture: false\n
  \t\tuser config no stylesheets
  \t\tg.stylesheets false\n
  \t\tuser config no javascripts
  \t\tg.javascripts false\n
  \tend", :after => /    config.active_record.raise_in_transactional_callbacks = true/)
  comment_lines 'config/application.rb', /user/
# ------------------------------------------------------------------------------
# pages
# ------------------------------------------------------------------------------
# create pages controller
generate 'controller pages welcome about'

# change welcome to root
gsub_file 'config/routes.rb', /get \'pages\/welcome\'/, 'root "pages#welcome"'

# ------------------------------------------------------------------------------
# create seed file
# ------------------------------------------------------------------------------
remove_file 'db/seeds.rb'
copy_file "seeds.rb", "db/seeds.rb"

#rake 'db:seed'

# ------------------------------------------------------------------------------
#  Lib
# ------------------------------------------------------------------------------
empty_directory 'lib/generators'
empty_directory 'lib/templates/rails/helper'
empty_directory 'lib/templates/erb'
# move templates
directory "scaffold", "lib/templates/erb/scaffold"
directory "initializer", "lib/generators/initializer"
# ------------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------------
# initialise a git repo add all and commit.
git :init
git add: "."
git commit: "-a -m 'Initial commit'"
