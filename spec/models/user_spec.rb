require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '正しい情報での入力' do
      it '正しい情報を入力するとログインできる' do
        expect(@user).to be_valid
      end
      it '名字は半角英語でも登録できる' do
        @user.family_name = "Alphabet"
        expect(@user).to be_valid
      end
      it '名字は全角英語でも登録できる' do
        @user.family_name = "ａｌｐａｈｂｅｔ"
        expect(@user).to be_valid
      end
      it '名前は半角英語でも登録できる' do
        @user.first_name = "Alphabet"
        expect(@user).to be_valid
      end
      it '名前は全角英語でも登録できる' do
        @user.first_name = "ａｌｐａｈｂｅｔ"
        expect(@user).to be_valid
      end
    end

    context 'emailが間違っている場合' do
      it '空欄である' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank", "Email 当社のメールアドレスを入力してください")
      end
      it '@が含まれていないと登録できない' do
        @user.email = @user.email.gsub!(/@/, '')
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid', "Email 当社のメールアドレスを入力してください")
      end
      it '@以前が入力されていないと登録できない' do
        @user.email = "@abcd.co.jp"
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid', "Email 当社のメールアドレスを入力してください")
      end
      it '@以降が間違っている場合は登録されていない' do
        @user.email = "aaa@abcc.co.jp"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email 当社のメールアドレスを入力してください")
      end
      it '同じメールアドレスが過去に登録されている' do
        @user2 = FactoryBot.build(:user)
        @user2.email = @user.email
        @user2.save
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
    end

    context 'passwordが間違っている場合' do
      it '空欄だと登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include(
          "Password can't be blank",
          "Password is too short (minimum is 8 characters)",
          'Password 半角アルファベットと半角数字の2種類を使用して、8文字以上で入力してください。',
          "Password confirmation doesn't match Password")
      end
      it '8文字未満のパスワードが登録できないこと' do
        @user.password = "abcd123"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include(
          "Password is too short (minimum is 8 characters)")
      end
      it '半角英字のみでは登録できないこと' do
        @user.password = Faker::Alphanumeric.alpha
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include(
          'Password 半角アルファベットと半角数字の2種類を使用して、8文字以上で入力してください。')
      end
      it '半角数字のみでは登録できないこと' do
        @user.password = Faker::Number.number
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include(
          "Password 半角アルファベットと半角数字の2種類を使用して、8文字以上で入力してください。")
      end
    end

    context 'password_confirmationが間違っている場合' do
      it '空欄だと登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include()
      end
      it 'passwordと異なる値の場合、登録できない' do
        @user.password_confirmation = @user.password_confirmation + "a"
        @user.valid?
        expect(@user.errors.full_messages).to include()
      end
    end

    context '社員番号が間違っている場合' do
      it '空欄だと登録できない' do
        @user.corporate_no = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Corporate no can't be blank", "Corporate no 11文字で入力してください", "Corporate no abcdと数字7桁で入力してください")
      end
      it "ルールにない番号を入力した場合登録できない" do
        @user.corporate_no = "aaaa0000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Corporate no abcdと数字7桁で入力してください")
      end
      it '5〜8桁目が、197より小さいと場合、登録できない' do
        @user.corporate_no = "abcd1690001"
        @user.valid?
        expect(@user.errors.full_messages).to include("Corporate no abcdと数字7桁で入力してください")
      end
      it '5〜8桁目が、239より大きいと場合、登録できない' do
        @user.corporate_no = "abcd" + (Faker::Number.within(range: 240..999)).to_s + "0001"
        @user.valid?
        expect(@user.errors.full_messages).to include("Corporate no abcdと数字7桁で入力してください")
      end
      it '過去に登録されている番号がある場合、新しく登録できない' do
        @user2 = FactoryBot.build(:user)
        @user2.corporate_no = @user.corporate_no
        @user2.email = "a" + @user.email
        @user2.save
        @user.valid?
        expect(@user.errors.full_messages).to include('Corporate no has already been taken')
      end
    end

    context '名字が間違っている場合' do
      it '空欄だと登録できない' do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name 1〜10文字で入力してください")
      end
    end
  
    context '名前が間違っている場合' do
      it '空欄だと登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name 1〜10文字で入力してください")
      end
    end

  end
end