class CommentForApi < Presenter
  def as_json(*)
    {
      id: @object.id,
      body: h.tags_to_links(@object.body, @object.tags),
      created_at: @object.created_at,
      author: {
        username: @object.author.username,
        id: @object.author.id,
        avatar_url: h.image_url(
          @object.author.profile.gr_or_avatar(:small) )
      }
    }
  end
end

