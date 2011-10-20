class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # :trackable, :validatable, :rememberable, :recoverable,
  devise :database_authenticatable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :user_code, :is_admin, :first_name, :last_name, :email, :encrypted_password, :password, :password_confirmation

  has_many :posts, :dependent => :destroy
  has_many :post_votes, :dependent => :destroy
  has_many :replies, :dependent => :destroy
  has_many :reply_votes, :dependent => :destroy

  def self.search(search)
    #search_condition = "%" + search + "%"
    #self.find(:all, :conditions => ['user_code LIKE ?', search_condition])
    if !search.nil?
      search_length = search.split.length
      return find(:all, :conditions => ['user_code LIKE ? AND user_code LIKE ? AND user_code LIKE ?',
          "%#{search.split[0]}%", "%#{search.split[1]}%", "%#{search.split[search_length]}%" ])
    else
      find(:all)
    end
  end

  validates_uniqueness_of :user_code, :scope => :id
  validates_uniqueness_of :email, :scope => :id
end
