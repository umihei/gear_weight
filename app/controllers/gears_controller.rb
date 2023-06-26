class GearsController < ApplicationController
    
    # 一覧表示
    def index
        user = User.find(current_user.id)
        @user_gears = user.gear
    end
    
    # 詳細ページ表示
    def show
    end
    
    # 作成
    def new
        @gear = Gear.new
        @mntevents_id = params[:mntevents_id]
        
    end
    
    # 登録
    def create
        # stringのパラメタを整数型に変換する
        weight = params[:gear][:weight]
        mntevents_id = params[:gear][:mntevents_id]
        
        # モデルを初期化
        @gear = Gear.new(name: params[:gear][:name], weight: weight.to_i, mntevents_id: mntevents_id.to_i, user_id: params[:gear][:user_id])
        
        # DBに保存
        if @gear.save
        # newへリダイレクト
            redirect_to new_gear_path(mntevents_id:mntevents_id) 
        else
           render 'new', status: :unprocessable_entity 
        end
            
    end

   # 編集
   def edit
   end
   
   # 更新
   def update
   end
   
   # 削除
   def destroy
   end
   
   private
   def gear_params
       params.require(:gear).permit(:mntevents_id, :weight, :name,:user_id)
   end
   
#   private
#   def question_params
#         params.require(:question).permit(:title,:name,:content)
   
#   end
end
