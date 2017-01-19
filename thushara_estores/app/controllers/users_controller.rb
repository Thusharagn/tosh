class UsersController < ApplicationController
 
 skip_before_action :check_session, only: [:login, :login_authenticate, :new ,:create]
 
 
 def index
    @user= User.all
  end


 
  # def new
    # @user = User.new
  # end
  
  
  def login
    @user=User.new
    
  end
  
  
##def login_authenticate

##  em=user_params.merge!(password:Digest::MD5.hexdigest(user_params["password"]))
##  @user=User.authenticate(em)
#p session[:user_id]
##  if @user
##    session[:user_id]=@user.id
#p session[:user_id]
##    redirect_to action: :index
##  else
##    redirect_to action: :login

## end
##end

def login_authenticate



  user = User.where("email=? and password=?",params[:email],Digest::MD5.hexdigest(params[:password]))
  if !user.blank?
    session[:user_id] = user.last.id
    redirect_to action: :index
  else
    #redirect_to action: :login
    render "login"

 end
end

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to action: :index
    else
       render "new"
    end
  end


  
  def show
    @user=User.find params[:id]
  end


  def edit
    @user=User.find params[:id]
  end
  
 
  def update
    @user=User.find params[:id]
    if @user.update(user_params)
      
       redirect_to action:  :index
      flash[:notice]="successfully updated :)"
    else
      render "edit"
      flash[:notice]="something went worng"
      end
  end
  
  def logout
    session[:user_id]=nil
    #redirect_to action: :login
     render "login"
  end
  
  
  def destroy
    @user=User.find params[:id]
    @user.destroy
    redirect_to action: :index
    flash[:notice]="successfully delete:)"
    
  end
 
  private
  def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
