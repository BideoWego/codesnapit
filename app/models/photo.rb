class Photo < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  has_attached_file :file, :styles => { :large => "512x512", :medium => "256x256", :thumb => "128x128" }


  validates_attachment  :file,
                        :presence => true,
                        :content_type => {
                          :content_type => ["image/jpeg", "image/gif", "image/png"]
                        },
                        :size => { :in => 0..2.megabytes }
end
