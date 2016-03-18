class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :frienships, dependent: :destroy
  has_many :inverse_frienships, class_name: "Frienship", foreign_key: "friend_id", dependent: :destroy

  def create_friendship(user_2)
    self.frienships.create(friend: user_2)
  end
end
