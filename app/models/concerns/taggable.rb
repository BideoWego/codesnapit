module Taggable
  extend ActiveSupport::Concern


  included do
    after_create :create_tags
  end


  def create_tags
    self.class.taggable_fields.each do |taggable_field|
      create_tags_from_field(taggable_field)
    end
  end


  class_methods do
    def taggable_fields(*fields)
      @taggable_fields = fields if fields.present?
      @taggable_fields
    end


    def taggable_default_tags(*fields)
      if fields.present?
        @taggable_default_tags = fields.first.is_a?(Proc) ? fields.first : fields
      end
      @taggable_default_tags
    end
  end




  private
  def create_tags_from_field(field)
    tag_names = get_tags_field(field)
    tag_names += get_default_tags
    create_tags_from_collection(tag_names)
  end


  def get_tags_field(field)
    text = send(field)
    text.scan(/.?#[A-Za-z_0-9]+/)
      .map { |tag| tag.strip }
      .reject { |tag| tag.chars.first != '#' }
      .map { |tag| tag[1..-1] }
  end


  def get_default_tags
    default_tags = self.class.taggable_default_tags || []
    default_tags.is_a?(Array) ? default_tags : default_tags.call(self)
  end


  def create_tags_from_collection(tag_names)
    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by!(
        :name => tag_name
      )
      taggings.find_or_create_by!(
        :tag => tag
      )
    end
  end
end

