class MnteventsController < ApplicationController
    
    # イベント一覧
    def index
        # @mntevents = Mntevent.all
        user = User.find(current_user.id)
        @user_mntevents = user.mntevent
    end
    
    # イベント詳細
    def show
        @mntevent = Mntevent.find(params[:id])
        @gears = @mntevent.gears
    end

    # イベント作成
    def new
        @mntevent = Mntevent.new
    end
    
    # イベント登録
    def create
        # mnteventモデルを初期化
        @mntevent = Mntevent.new(mntevent_params)
        # mnteventモデルをDBへ保存
        if @mntevent.save
            # showへリダイレクト
            redirect_to @mntevent
        else
           render 'new', status: :unprocessable_entity 
        end
    end
    
    # 編集
    def edit
        @mntevent = Mntevent.find(params[:id])
        
    end
    
    # 更新
    def update
        @mntevent = Mntevent.find(params[:id])
        if @mntevent.update(mntevent_params)
            redirect_to @mntevent
        else
            render 'edit', status: :unprocessable_entity
        end
    end
    
    # 削除
    def destroy
    end
    
    def new_wear
    end
    
    private
    # eventname eventdate mntのみ許可
    def mntevent_params
        params.require(:mntevent).permit(:eventname,:eventdate,:mnt, :user_id)
    end
    
end
