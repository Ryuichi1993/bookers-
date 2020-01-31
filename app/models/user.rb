class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :entries
  has_many :direct_messages
  has_many :rooms, through: :entries
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  def User.search(search, user_or_book, select_search)
  if user_or_book == "1"
    if select_search == "1"
      User.where(['name LIKE ?', "#{search}"])
    elsif select_search == "2"
      User.where(['name LIKE ?', "#{search}%"])
    elsif select_search == "3"
      User.where(['name LIKE ?', "%#{search}"])
    elsif select_search == "4"
      User.where(['name LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end
end

  def send_ivate_to_user(user)
    @user = User.all
    @user.each do |u|
      NotificationMailer.send_ivate_to_user(u).deliver
    end
  end


 include JpPrefecture
  jp_prefecture :prefecture_code
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  geocoded_by :address_city
  after_validation :geocode, if: :address_city_changed?


  attachment :profile_image

  validates :name,
  			presence: true, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
end
