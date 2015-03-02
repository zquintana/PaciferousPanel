class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :lockable, :timeoutable
  # after_create :create_unix_user
  before_create :before_create_set_pending


  has_many :domains
  has_many :ssk_keys
  has_one :profile

  @@StatusTypes = {
    :disabled => 0, 
    :pending => 1, 
    :enabled => 2
  }

  @@DisabledStatusType  = 0
  @@PendingStatusType   = 1
  @@EnabledStatusType   = 2

  def is_admin?
  	read_attribute(:is_admin) == true
  end

  def unix_alias
    "client#{id}"
  end

  def home_path
    "/home/#{user.unix_alias}"
  end

  def generate_password
    self.password = RandomPasswordGenerator.generate(12, :skip_symbols => true)
    self.password_confirmation = self.password
  end

  class << self
    def StatusTypes
      @@StatusTypes
    end

    def all_pending
      self.where(status: @@PendingStatusType)
    end

    def EnabledStatusType
      @@EnabledStatusType
    end

    def PendingStatusType
      @@PendingStatusType
    end

    def DisabledStatusType
      @@DisabledStatusType
    end
  end

  protected
    def before_create_set_pending
      write_attribute(:status, 1)
    end

    
end
