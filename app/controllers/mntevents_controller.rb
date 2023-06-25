class MnteventsController < ApplicationController
    
    # イベント一覧
    def index
        @mntevents = Mntevent.all
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
        @mntevent.save
        # showへリダイレクト
        redirect_to @mntevent
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
    
    def new_wear
    end
    
    private
    # eventname eventdate mntのみ許可
    def mntevent_params
        params.require(:mntevent).permit(:eventname,:eventdate,:mnt)
    end
    
end
