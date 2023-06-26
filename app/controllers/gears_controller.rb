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
        
        # 山行記録を取り出して，総重量に今登録したギアの重さを加算
        mntevent = Mntevent.find(mntevents_id)
        mntevent_total_weight = mntevent.total_weight
        new_mntevent_total_weight = mntevent_total_weight + weight.to_i
        
        # 総重量をmnteventテーブルに保存
        if mntevent.update(total_weight: new_mntevent_total_weight)
            
        else
           render 'new', status: :unprocessable_entity 
        end
        
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
       @gear = Gear.find(params[:id])
       @mntevents_id = @gear.mntevents_id
       
   end
   
   # 更新
   def update
       @gear = Gear.find(params[:id])
       after_weight = params[:gear][:weight]
       mntevents_id = @gear.mntevents_id
       before_weight = @gear.weight
       
       # 山行記録を取り出して，総重量に今登録したギアの重さを加算
        mntevent = Mntevent.find(mntevents_id)
       new_weight = mntevent.total_weight + after_weight.to_i - before_weight 
       
       # 総重量をmnteventテーブルに保存
        if mntevent.update(total_weight: new_weight)
            
        else
           render 'edit', status: :unprocessable_entity 
        end
       
        if @gear.update(gear_params)
            # 山行詳細画面に戻る
            redirect_to mntevent_path(@gear.mntevents_id)
        else
            render 'edit', status: :unprocessable_entity
        end
   end
   
   # 削除
   def destroy
   end
   
   private
   def gear_params
       params.require(:gear).permit(:mntevents_id, :weight, :name,:user_id)
   end

end
