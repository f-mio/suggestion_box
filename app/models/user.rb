class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :authentication_keys => [:corporate_no]

  # 一人のユーザは複数部署の兼任をせず、一つの代表部署に所属していると仮定する
  has_one  :department, through: :user_departments_relations
  has_many :suggestions

  ### ### ###
  # validation

  with_options presence: true do

    # 1970年から2039年入社までに対応 (20年後までにはメンテナンスが発生する)
    CORP_CODE_REGEX = /abcd(19[7-9]|2[0-3]\d)\d{4}/.freeze
    with_options length: {is: 11, message: "11文字で入力してください"}, format: {with: CORP_CODE_REGEX, message: "abcdと数字7桁で入力してください"}, uniqueness: true do
      validates :corporate_no
    end

    # パスワードは英数含めた8文字以上のみ可能　(セキュリティは少し緩め。社内使用のみのため、大文字小文字は特に気にしない)
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    with_options length: {minimum: 8}, format: {with: PASSWORD_REGEX, message: "半角アルファベットと半角数字の2種類を使用して、8文字以上で入力してください。"} do
      validates :password
    end

    # 名前についての確認。1文字以上10文字以下とした。
    with_options length: {in: 1..10, message: "1〜10文字で入力してください"} do
      validates :family_name, :first_name
    end

    # 会社のEmailアドレス
    EMAIL_REGEX = /.+@abcd.co.jp/
    with_options format: {with: EMAIL_REGEX, message: "当社のメールアドレスを入力してください"} do
      validates :email
    end

  end

end
