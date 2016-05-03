class SnapItProxy < ActiveRecord::Base
  before_create :clean_up
  after_create :create_token




  private
  def clean_up
    SnapItProxy.where(:user_id => user_id)
      .destroy_all
  end


  def create_token
    str = "#{user_id}@#{Time.now} #{Time.now.usec}"
    hash = Digest::MD5.new.hexdigest(str)
    update!(:token => hash)
  end
end
