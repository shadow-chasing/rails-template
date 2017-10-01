# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#-------------------------------------------------------------------------------
# seed a admin user first
#-------------------------------------------------------------------------------
user = User.create(
      :email                 => "admin@live.com",
      :username              => "admin",
      :password              => "12345678",
      :password_confirmation => "12345678"
  )

#-------------------------------------------------------------------------------
# Uncoment to seed gallery, title - image - discription
#-------------------------------------------------------------------------------
#gallery_list = [
#  [ "night scape", "http://t.wallpaperweb.org/wallpaper/buildings/1600x900/wp_NY_Skyline_1920x1080_1600x900.jpg", "this is to pass validations" ],
#  [ "the world at night", "https://s-media-cache-ak0.pinimg.com/originals/2c/9f/e9/2c9fe9e41a539c07082f496483d0273e.jpg", "this text is to pass validations" ],
#  [ "mona mona", "https://www.hdwallpapers.in/walls/toronto_nightscape-wide.jpg", "this text is to pass validations" ]
#]

#gallery_list.each do |name, url, disc|
#  User.first.galleries.create( title: name, image: url, discription: disc )
#end

#-------------------------------------------------------------------------------
# Uncoment to seed articles, title - image - content
#-------------------------------------------------------------------------------
#article_list = [
#  [ "night scape", "http://t.wallpaperweb.org/wallpaper/buildings/1600x900/wp_NY_Skyline_1920x1080_1600x900.jpg", "this is to pass validations" ],
#  [ "the world at night", "https://s-media-cache-ak0.pinimg.com/originals/2c/9f/e9/2c9fe9e41a539c07082f496483d0273e.jpg", "this text is to pass validations" ],
#  [ "mona mona", "https://www.hdwallpapers.in/walls/toronto_nightscape-wide.jpg", "this text is to pass validations" ]
#]

#article_list.each do |name, url, disc|
#  User.first.articles.create( title: name, image: url, content: disc )
#end
#-------------------------------------------------------------------------------
