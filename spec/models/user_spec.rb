require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context '新規登録できる場合' do
    it 'nickname, email, password, password_confirmationが正しく入力されていれば登録できる' do
      expect(@user).to be_valid
    end
  end

  context '新規登録できない場合' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it '重複したemailは登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'emailに@が含まれていないと登録できない' do
      @user.email = 'invalid-email'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字未満では登録できない' do
      @user.password = 'a1b2'
      @user.password_confirmation = 'a1b2'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

it 'passwordが英字のみでは登録できない' do
  @user.password = 'abcdef'
  @user.password_confirmation = 'abcdef'
  @user.valid?
  expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
end

it 'passwordが数字のみでは登録できない' do
  @user.password = '123456'
  @user.password_confirmation = '123456'
  @user.valid?
  expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
end


    it 'passwordとpassword_confirmationが一致しないと登録できない' do
      @user.password = 'abc123'
      @user.password_confirmation = 'xyz789'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    describe '背景画像と透過度の設定' do
      it '背景画像がアタッチされると有効' do
        user = FactoryBot.build(:user)
        user.background_image.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/sample.jpg')),
          filename: 'sample.jpg',
          content_type: 'image/jpeg'
        )
        expect(user.background_image).to be_attached
      end

  it '透過度が1〜100の範囲であれば有効' do
    user = FactoryBot.build(:user, background_opacity: 50)
    expect(user).to be_valid
  end

  it '透過度が1未満だと無効' do
    user = FactoryBot.build(:user, background_opacity: 0)
    user.valid?
    expect(user.errors.full_messages).to include("Background opacity must be greater than or equal to 1")
  end

  it '透過度が100を超えると無効' do
    user = FactoryBot.build(:user, background_opacity: 101)
    user.valid?
    expect(user.errors.full_messages).to include("Background opacity must be less than or equal to 100")
  end
    end
  end
end
