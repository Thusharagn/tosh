class User < ActiveRecord::Base
  validates :name,presence:true
  validates :email,presence:true,uniqueness:true
  validates :password,presence:true,length:{maximum:10, minimum:5}
  #validates :confirm_password,presence:true,length:{minimum:5}
  validates :password, confirmation: true
  
#before_validation :check_password_values
  #def check_password_values
# p self
#p self.password
#p  self.confirm_password   
#  if self.password != self.confirm_password
#      errors.add(:base,'password and confirm password are not equal')
#
#    end

#  end


  before_save :encrypt_password

  def encrypt_password
    self.password=Digest::MD5.hexdigest(password)
    #self.confirm_password=Digest::MD5.hexdigest(confirm_password)
  end
  
  before_destroy :take_backup
  def take_backup
        #logger.info"=========hjgh======="
  File.open("#{Rails.root}/public/#{self.name}","a+"){ |foo| foo.write(self.inspect)}  
end
  
  
  
  def self.authenticate(data)
    @user=User.where(data)
    if @user.present?
      @user.last
    else
       nil
    end
  end
end
