class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_votes, :dependent => :destroy
  has_many :replies, :dependent => :destroy
  attr_accessible :post_text, :vote_count, :user_id
  #validates_presence_of :post_text => I18n.t('AuthenticatedUser')
  # is this a reasonable minimum of for a post
  validates_length_of :post_text, :minimum => 10, :message => I18n.t('PostTooShort')

  def self.search(search)
    #@terms = search.split(" ").map { |s| s }
    #puts @terms.to_s
    #search_condition = "%" + search + "%"
    #self.find(:all, :conditions => ['post_text LIKE ?', search_condition])
      if !search.nil?
        search_length = search.split.length
        return find(:all, :conditions => ['post_text LIKE ? AND post_text LIKE ? AND post_text LIKE ?',
          "%#{search.split[0]}%", "%#{search.split[1]}%", "%#{search.split[search_length]}%" ])
      else
        find(:all)
      end
  end

end