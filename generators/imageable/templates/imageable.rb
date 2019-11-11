module Imageable
  extend ActiveSupport::Concern

  # add, include Imageable to each model you want it to include.
  # add, pictures_attributes: [:id, :name] to the controller permit params.
  # add example: @article.pictures.build to the controller NEW action.
  # add to form of the model.
    #<%= f.fields_for :pictures do |pic| %>
    # <%= f.label :image %><br>
    # <%= pic.text_field :name %>
    #<% end %>

  included do
    has_many :pictures, as: :imageable
    accepts_nested_attributes_for :pictures, :allow_destroy => true
  end

end
