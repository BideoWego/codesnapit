class CommentsForApi

  def initialize(comments)
    @comments = comments
  end

  def as_json(*)
    @comments.map { |c| CommentForApi.new(c) }
  end

end