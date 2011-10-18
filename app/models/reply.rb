class Reply < ActiveRecord::Base

  attr_accessible  :user_id, :reply_text, :reply_votes, :post_id, :vote_count
  belongs_to :user
  belongs_to :post
  has_many :reply_votes, :dependent => :destroy

  #validates_presence_of :user_id, :message => I18n.t('AuthenticatedUser')

  def self.search(search)
    #search_condition = "%" + search + "%"
    #self.find(:all, :conditions => ['reply_text LIKE ?', search_condition])
    if !search.nil?
      search_length = search.split.length
      return find(:all, :conditions => ['reply_text LIKE ? AND reply_text LIKE ? AND reply_text LIKE ?',
        "%#{search.split[0]}%", "%#{search.split[1]}%", "%#{search.split[search_length]}%" ])
    else
      find(:all)
    end
  end

  has_many :reply_votes, :dependent => :destroy
end