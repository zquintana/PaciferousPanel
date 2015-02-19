class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :lockable, :timeoutable
  # after_create :create_unix_user
  before_create :before_create_set_pending


  has_many :domains
  has_one :profile

  @@StatusTypes = {
    :disabled => 0, 
    :pending => 1, 
    :enabled => 2
  }

  @@PendingStatusType = 1
  @@EnabledStatusType = 2

  def is_admin?
  	read_attribute(:is_admin) == true
  end

  def unix_alias
    "client#{id}"
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
  end

  def create_unix_user
    default_shell = Setting.get('default_shell')
    debug = Setting.get('debug')
    if debug == true
      write_attribute(:status, @@PendingStatusType)
      return self.save
    end

    command = "adduser -m --disabled-password"
    command += " -s #{default_shell}" if default_shell
    command += " #{self.unix_alias}"
    `#{command}`

    if $?.success? == false
      write_attribute(:status, @@PendingStatusType)
      return self.save
    end

    write_attribute(:status, @@EnabledStatusType)
    self.save
  end

  protected
    def before_create_set_pending
      write_attribute(:status, 1)
    end

    
end
