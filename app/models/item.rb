class Item < ActiveRecord::Base
  validates :user_id, :title, :rank, presence: true
  validates :rank, uniqueness: {scope: :parent_id}

  belongs_to :user
  has_many :views

  belongs_to :parent, class_name: 'Item', inverse_of: :children

  has_many :children, class_name: 'Item',
           foreign_key: :parent_id,
           dependent: :destroy,
           inverse_of: :parent

  def shortened_notes
    if notes
      notes.split(/\r?\n/).first
    else
      ''
    end
  end
end
