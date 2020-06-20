class MessagesController < ApplicationController
  before_action :set_group

  def index
    # メッセージの一覧を表示する機能
    @message = Message.new
    @messages = @group.messages.includes(:user)
    # @groupのmessagesのuserカラムを@messagesに代入
    # N+1問題対策(.includes)
    # アソシエーションでテーブルをつなげるとデータベースへのアクセスが多くなる問題を解消する
  end

  def create
    # メッセージを追加する機能
    @message = @group.messages.new(message_params)
    if @message.save
    # ↑もしメッセージが保存できたら
      respond_to do |format|
      # フォーマットに応じたレスポンスを作成
        format.html { redirect_to group_messages_path, notice: "メッセージを送信しました" }
        # ↑HTMLフォーマット
        # ↑Prefix(group_messages)へメッセージ付きでリンク
        format.json
        # ↑JSONフォーマット
      end
    else
      # メッセージ保存に失敗した場合
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
      # フラッシュメッセージとindexへ戻る
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
    # ハッシュ値(:message)の中から(:content, :image)のパラメータのみにフィルタをかける
    # ↑と(user_id: current_user.id)を足す
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
