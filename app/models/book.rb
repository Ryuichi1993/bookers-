class Book < ApplicationRecord

belongs_to :user
has_many :book_comments, dependent: :destroy
has_many :favorites, dependent: :destroy
def favorited_by?(user)
	favorites.where(user_id: user.id).exists?
end

validates :body, presence:true, length: { maximum:50 }
validates :title, presence:true

def Book.search(search, user_or_book, select_search)
    if select_search == "1"
    	Book.where(['title LIKE ?', "#{search}"])
    elsif select_search == "2"
    	Book.where(['title LIKE ?', "#{search}%"])
    elsif select_search == "3"
    	Book.where(['title LIKE ?', "%#{search}"])
    elsif select_search == "4"
    	Book.where(['title LIKE ?', "%#{search}%"])
    else
        Book.all
    end
end
end