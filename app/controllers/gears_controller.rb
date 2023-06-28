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
        @options = Gear.pluck(:name)
        
    end
    
    

def create_test
  input_text = params[:model][:input_text] # テキストフィールドからの入力を取得
  existing_record = Model.find_by(column_name: input_text) # 特定のカラム内に指定された文字列が存在するか確認

  if existing_record.present?
    flash[:error] = "エラーメッセージ" # エラーメッセージを設定
    redirect_to new_model_path # エラーメッセージを表示するページにリダイレクトする
  else
    @model = Model.new(column_name: input_text) # 新しいレコードを作成
    if @model.save
      flash[:success] = "保存しました"
      redirect_to @model
    else
      flash[:error] = "保存に失敗しました"
      render :new
    end
  end
end


    # 登録
    def create
        # stringのパラメタを整数型に変換する
        weight = params[:gear][:weight]
        mntevents_id = params[:gear][:mntevents_id]
        name = params[:gear][:name]
        existing_record = Gear.find_by(name: name)
        
        p existing_record
        
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
    
    
    def check_duplicate
      input_text = params[:name]
      existing_record = Gear.exists?(name: input_text)
    
      render json: { duplicate: existing_record }
    end
    
    def get_weight
        gear_name = params[:name]
        existing_record = Gear.find_by(name: gear_name)
        
        p existing_record
        render json: {weight: existing_record[:weight]}
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
       @gear = Gear.find(params[:id])
        @gear.destroy
        redirect_to gears_path
   end
   
   private
   def gear_params
       params.require(:gear).permit(:mntevents_id, :weight, :name,:user_id)
   end

end
