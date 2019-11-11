class ForumGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

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

  def routes
    begin
      copy_file "Forum_Config.txt"
    rescue
      puts "Error: unable to create Forum_Config.txt"
    end
  end

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

  def init_devise
    generate 'devise User'
  end

  def init_votable
    #generate 'acts_as_votable:migration'
  end

  def model_comments
    generate 'model Comment content:text topic:references user:references'
  end

end
