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

# add custom assets and layouts
link_file "assets", "app/assets"
link_file "layouts", "app/views/layouts"
link_file "helpers", "app/helpers"

# ------------------------------------------------------------------------------
# pages
# ------------------------------------------------------------------------------

# create pages controller
generate 'controller pages welcome about'

# remove pages/welcome
gsub_file('config/routes.rb', /get\s\"pages\/welcome\"/, " ")

# replace pages/welcome as root
route "root 'pages#welcome'"

# ------------------------------------------------------------------------------
# admin - devise
# ------------------------------------------------------------------------------

# create admin controllers
generate 'controller admin/dashboard index'
gsub_file('config/routes.rb', /get\s\"dashboard\/index\"/, " ")

# devise login
generate 'devise:install'
generate 'devise User'

# add username to users
generate 'migration add_username_to_users username:string:uniq'
rake 'db:migrate'

# generate admin/user views
generate 'devise:views admin/users'

# generate devise controllers
generate 'devise:controllers admin/users'

# routes - create admin namespace
route "namespace :admin do \n\t
      get '', to: 'dashboard#index', as: '/'\n
      devise_for :users, controllers: { sessions: 'admin/users/sessions',
      registrations: 'admin/users/registrations'}\n
    end"


# routes - remove added devise_for outside of the namespace
gsub_file('config/routes.rb', /devise_for\s\:users$/, "")

# config/initializers/devise - add authentication_keys for devise login.
insert_into_file('config/initializers/devise.rb', "\nconfig.authentication_keys = [ :login ]\n", :after => /# config.omniauth_path_prefix = '\/my_engine\/users\/auth'/)

# admin/users - modify devise views adding - username, login
insert_into_file('app/views/admin/users/registrations/new.html.erb', "\n<p><%= f.label :username %><br />\n<%= f.text_field :username %></p>\n", :after => /<%= devise_error_messages! %>/)

insert_into_file('app/views/admin/users/registrations/edit.html.erb', "\n<p><%= f.label :username %><br />\n<%= f.text_field :username %></p>\n", :after => /<%= devise_error_messages! %>/)

# admin/users sub old email of new login
gsub_file('app/views/admin/users/sessions/new.html.erb', /:email/, ":login")
gsub_file('app/views/admin/users/sessions/new.html.erb', /f.email_field/, "f.text_field")


# recreate devise user models.
remove_file 'app/models/user.rb'
create_file 'app/models/user.rb' do <<-TEXT
  class User < ActiveRecord::Base
      # Include default devise modules. Others available are:
      # :confirmable, :lockable, :timeoutable and :omniauthable
      devise :database_authenticatable, :registerable,
             :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

      # Virtual attribute for authenticating by either username or email
      # This is in addition to a real persisted field like 'username'
      attr_accessor :login

      validate :validate_username

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
    end


    def validate_username
      if User.where(email: username).exists?
        errors.add(:username, :invalid)
      end
    end

  end

  TEXT
end


# recreate devise registration controller permiting username and redirecting to
# source page after edit.
remove_file 'app/controllers/admin/users/registrations_controller.rb'

create_file 'app/controllers/admin/users/registrations_controller.rb' do <<-TEXT
  class Admin::Users::RegistrationsController < Devise::RegistrationsController
   before_filter :configure_sign_up_params, only: [:create]
   before_filter :configure_account_update_params, only: [:update]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    # def create
    #   super
    # end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.for(:sign_up) << added_attrs
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.for(:account_update) << added_attrs
    end

    # The path used after sign up.
    def after_sign_up_path_for(resource)
       super(resource)
    end

    def after_update_path_for(resource)
       user_path(resource)
    end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end

  TEXT
end



# ------------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------------

# initialise a git repo add all and commit.
git :init
git add: "."
git commit: "-a -m 'Initial commit'"
