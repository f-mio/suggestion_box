class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many   :suggestions
  belongs_to :department

  with_options presence: true do

    # 1970年から2039年入社までに対応 (20年後までにはメンテナンスが発生する)
    CORP_CODE_REGEX = /ABCD(19[7-9]|20[0-3])\d{4}/.freeze
    with_options length: {is: 11}, format: {with: CORP_CODE_REGEX, message: "ABCDと数字7桁で入力してください"} do
      validates :corp_no
    end

    # パスワードは英数含めた8文字以上のみ可能　(セキュリティは社内使用のみのため、大文字小文字は特に気にしない)
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    with_options length: {minimum: 8}, format: {with: PASSWORD_REGEX, message: "全角文字で入力してください"} do
      validates :password
    end

    # 名前についての確認。1文字以上10文字以下とした。
    with_options length: {in: 1..10} do
      validates :family_name, :first_name
    end

    # 会社のEmailアドレス
    EMAIL_REGEX = /.+@abcd.co.jp/
    with_options format: {with: EMAIL_REGEX, message: "当社のメールアドレスを入力してください"} do
      validates :email
    end

    # 部署一覧のレコードID。任意のユーザはどこかの部署に所属している
    with_options numericality: :only_integer do
      validates :department_id
    end

  end


end
