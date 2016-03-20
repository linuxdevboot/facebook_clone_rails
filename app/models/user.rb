class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :frienships, dependent: :destroy
  has_many :inverse_frienships, class_name: "Frienship", foreign_key: "friend_id", dependent: :destroy
  has_many :posts, dependent: :destroy

  def request_friendship(user_2)
    self.frienships.create(friend: user_2)
  end

  def active_friends
    self.frienships.where(state: "active").map(&:friend) + self.inverse_frienships.where(state: "active").map(&:user)
  end

  def pending_friend_requests_to
    self.frienships.where(state: "pending")
  end

  def pending_friend_requests_from
    self.inverse_frienships.where(state: "pending")
  end

  def friendship_relation(user_2)
    Frienship.where(user_id: [self.id,user_2.id], friend_id: [self.id,user_2.id]).first
  end

  def friendship_status(user_2)
    friendship = Frienship.where(user_id: [self.id,user_2.id], friend_id: [self.id,user_2.id])
    unless friendship.any?
      return "not_friends"
    else
      if friendship.first.state == "active"
        return "friends"
      else
        if friendship.first.user == self
          return "pending"
        else
          return "requested"
        end
      end
    end
  end
end
