class CommentsForApi < Presenter

  def as_json(*)
    @object.map { |c| CommentForApi.new(c) }
  end

end