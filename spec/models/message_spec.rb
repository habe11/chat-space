require 'rails_helper'
# railshelperを適用する

RSpec.describe Message, type: :model do
  describe '#create' do
    context 'can save' do
      # メッセージを保存できる場合

      it 'is valid with content' do
        expect(build(:message, image: nil)).to be_valid
        # メッセージがあれば保存できる
      end

      it 'is valid with image' do
        expect(build(:message, content: nil)).to be_valid
        # 画像があれば保存できる
      end

      it 'is valid with content and image' do
        expect(build(:message)).to be_valid
        # メッセージと画像があれば保存できる
      end
    end

    context 'can not save' do
      # メッセージを保存できない場合
      it 'is invalid without content and image' do
        message = build(:message, content: nil, image: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください")
        # メッセージも画像も無いと保存できない
      end

      it 'is invalid without group_id' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
        # group_idが無いと保存できない
      end

      it 'is invaid without user_id' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
        # user_idが無いと保存できない
      end
    end
  end
end