module SessionsHelper
   def current_user
    @current_user ||= User.find_by(id: session[:user_id])
   end
    
   def logged_in?
      !current_user.nil? 
#current_user.nil? は「current_userがnilの場合（ログインしていない場合）にtrue」を返し、先頭に ! をつけると逆になり「current_userがnilではない場合（ログインしている場合）にtrue」を返すようになりま
   end 
    
   def request_login
      if current_user.nil?
        redirect_to new_session_path, notice: "ログインが必要です"
      end
   end  
end
