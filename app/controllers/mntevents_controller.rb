class MnteventsController < ApplicationController
    
    # イベント一覧
    def index
        @mntevents = Mntevent.all
        p @mntevents
    end
    
    # イベント詳細
    def show
        p params
        @mntevent = Mntevent.find(params[:id])
        p @mntevent
        @gears = @mntevent.gears
        p @gears[0].name
    end

    # イベント作成
    def new
        @mntevent = Mntevent.new
    end
    
    # イベント登録
    def create
        p params
        p mntevent_params
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
