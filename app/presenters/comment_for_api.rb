class CommentForApi < Presenter

  def as_json(*)
    {
      id: @object.id,
      body: @object.body,
      created_at: @object.created_at,
      author: {
        username: @object.author.username,
        id: @object.author.id,
        avatar_url: ActionController::Base.helpers.image_url( 
          @object.author.profile.gr_or_avatar(:small) )
      }
    }
  end

end