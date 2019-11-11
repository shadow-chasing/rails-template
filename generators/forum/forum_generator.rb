class ForumGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  # create view and controller under scoped module name forum.

  def view
    begin
      directory "forum", "app/views/forum"
    rescue
      puts "Error: unable to create forum views"
    end

  end

  def controller
    begin
      directory "forum_controller", "app/controllers/forum"
    rescue
      puts "Error: unable to create forum controllers"
    end
  end

  # generate models for forum, topic and comments.

  def model_forums
    generate 'model Forum name:string description:text pagecount:integer user:references'
  end

  # TODO:
  #t.integer :pagecount, default: 0

  def model_topics
    generate 'model Topic name:string last_poster_id:integer last_post_at:datetime last_poster_username:string pagecount:integer user:references forum:references'
  end

  # TODO:
  #t.integer :pagecount, default: 0

  def model_comments
    generate 'model Comment content:text user:references topic:references'
  end



end
