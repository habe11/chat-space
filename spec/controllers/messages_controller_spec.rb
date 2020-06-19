require 'rails_helper'
# ヘルパーを適用

describe MessagesController do
  #  letを利用してテスト中使用するインスタンスを定義
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe '#index' do
    context 'log in' do
      # この中にログインしている場合のテストを記述
      before do
        login user
        get :index, params: { group_id: group.id }
      end
      # ↑この中にログインしている場合のテストを記述
      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)
        # assigns(:message) = @messageを参照したい場合、こう書く
        # be_a_newマッチャ = 対象が「messageクラスのインスタンス」かつ「未保存のレコード」か確認
      end

      it 'assigns @group' do
        expect(assigns(:group)).to eq group
        # @group と groupが一致しているか確認
      end
      

      it 'renders index' do
        expect(response).to render_template :index
        # response = example内でリクエストが行われた後の遷移先のビューの情報を持つインスタンス
        # render_template = シンボル型にしたアクション(:index)がリクエストされた時に自動的に遷移するビューを返す
        # 上2つの内容が同値か確認
      end
    end

    context 'not log in' do
      # この中にログインしていない場合のテストを記述
      before do
        get :index, params: { group_id: group.id }
      end
      # ↑この中にログインしていない場合のテストを記述
      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end

      describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        subject {
          # 引数が長くなる時はsubjectで切り出せる
          post :create,
          params: params
          # postメソッドでcreateアクションを擬似的にリクエストをした結果
        }

        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
        end

        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'does not count up' do
          expect{ subject }.not_to change(Message, :count)
        end

        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'not log in' do

      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end



    end
  end
end

describe '#create' do
  let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

  context 'log in' do
  # context中にログインしている場合のテストを記述
    before do
      login user
    end

    context 'can save' do
      # メッセージの保存に成功した場合の記述
      subject {
        post :create,
        params: params
      }

      it 'count up message' do
        expect{ subject }.to change(Message, :count).by(1)
      end

      it 'redirects to group_messages_path' do
        subject
        expect(response).to redirect_to(group_messages_path(group))
      end
    end

    context 'can not save' do
      # メッセージの保存に失敗した場合の記述
      let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

      subject {
        post :create,
        params: invalid_params
      }

      it 'does not count up' do
        expect{ subject }.not_to change(Message, :count)
      end

      it 'renders index' do
        subject
        expect(response).to render_template :index
      end
    end
  end

  context 'not log in' do
    # context内にログインしていない場合のテストを記述
    it 'redirects to new_user_session_path' do
      post :create, params: params
      expect(response).to redirect_to(new_user_session_path)
    end