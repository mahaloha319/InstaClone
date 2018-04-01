class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:new, :show, :edit]
  
  def index
    @pictures = Picture.order(:created_at).reverse_order #orderメソッド実行し、created_atの昇順でソートされる.reverse_orderは降順
  end
  
  def new
    if params[:back]
      @picture = current_user.pictures.new(picture_params)
    else
      @picture = current_user.pictures.new
    end  
  end
  
  def create
  @picture = Picture.new(picture_params)
  @picture.user_id = current_user.id  #現在ログインしているuserのidをblogのuser_idカラムに挿入
  
  #画像保存（create）の際、キャッシュから画像を復元してから保存する
  @picture.image.retrieve_from_cache! params[:cache][:image] if params[:cache][:image].present? # if画像選択したら
    if @picture.save
      PictureMailer.picture_mail(@picture).deliver #↑post内容が保存された時にPictureMailerのpicture_mailメソッドを呼び出す
                                                   #picture_mail(@picture)で、picture_mailメソッドを呼び出す時、引数として@picture(post情報)を渡す
      redirect_to pictures_path, notice: "postしました！"
    else 
    render 'new'
    end
  end  
  
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end
  
  def edit
  end
  
  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice:"Postを編集しました！"
    else
      render 'edit'
    end  
  end
  
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"Postを削除しました！"
  end  
  
  def favorite
     @favorite = current_user.favorites.find_by(picture_id: params[:picture_id])  
  end  
    
  def confirm
    @picture = current_user.pictures.new(picture_params)
    render :new if @picture.invalid?
  end  
    
  private
  def picture_params
    if params[:picture]
      params.require(:picture).permit(:image, :comment)
    else false
    end 
  end
  
  def set_picture
    @picture = Picture.find_by_id(params[:id])
  end 
end  