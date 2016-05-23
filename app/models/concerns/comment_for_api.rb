class CommentForApi

  def initialize(comment)
    @comment = comment
  end

  def as_json(*)
    {
      id: @comment.id,
      body: @comment.body,
      created_at: @comment.created_at,
      author: {
        username: @comment.author.username,
        id: @comment.author.id,
        avatar_url: @comment.author.profile.gr_or_avatar(:small)
      }
    }
  end

end